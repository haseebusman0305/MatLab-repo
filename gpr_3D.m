% Add gpr_functions to the path
dir_path = cd;
idcs = strfind(dir_path, '\'); % Change '/' to '\'
func_dir = dir_path(1:idcs(end));
func_dir = strcat(func_dir, "MATLAB\");

if isfolder(func_dir)
    addpath(func_dir);
    if exist(fullfile(func_dir, 'untitled.m'), 'file') ~= 2
        error('K_Function.m not found in gpr_functions folder.');
    end
else
    error('Directory does not exist: %s', func_dir);
end

% Rest of the script
clc, clearvars, close all, format compact

% Kernel Hyperparameters
hp.L = 3.0;               % lengthscale (high = smoother, low = noisier)
hp.sigma_p = 4.0;         % process noise (output scale / vertical scale)
hp.sigma_n = 0.2;         % sensor noise (used to create W)
hp.kerneltype = 'exact';  % 'exact' or 'sparse' approximate kernel

% Generate Random Training Data + Noise (2.5D)
map_size = 20; % side of square map dimensions, keep this even if you can
x = (-map_size/2:(map_size/2-1));
y = (-map_size/2:(map_size/2-1));
[X,Y] = meshgrid(x,y);

% Matrices map_size x map_size
X = X + randn(map_size,map_size);
Y = Y + randn(map_size,map_size);
Z = 1*sin(X) + Y/20;                    % shape of curve!
% gaussian nosie
noise.mu = 0; noise.sigma = hp.sigma_n;
Z = Z + normrnd(noise.mu,noise.sigma,map_size,map_size)/5;

% Reshape (map_size^2 x 1)
X1 = reshape(X,map_size^2,1);
Y1 = reshape(Y,map_size^2,1);
Z1 = reshape(Z,map_size^2,1);

% Rename and Clear Variables
X = [X1 Y1];
Y = Z1;
nnum = length(Y);
clearvars -except X Y map_size nnum hp

% Plot
figure
scatter3(X(:,1),X(:,2),Y,'k.')
xlabel('X'),ylabel('Y'),zlabel('Depth')
title('Raw Training Data'), zlim([-5 5])

% Prediction Points STAR
predict_pts = map_size*2;
x_star = (-predict_pts/2:0.5:(predict_pts/2)-0.5);
y_star = (-predict_pts/2:0.5:(predict_pts/2)-0.5); %adding pts twice as dense
[x_star,y_star] = meshgrid(x_star,y_star);
x_star = reshape(x_star,(2*predict_pts)^2,1);
y_star = reshape(y_star,(2*predict_pts)^2,1);

X_Star = [x_star y_star]; % m x 2 % vertical array, can add training data for prediction X
clear x_star y_star

disp('...test data generated, run the next section...')

% MATRIX CALCS
clc, close all, disp('...running GPR, may take a minute...')
tic

% Calculate V and Inv(V)
W = (hp.sigma_n^2)*eye(nnum);                       % Whitenoise (identity * sigmasquared)
V = K_Function(X,X,hp) + W;                         % Calculate Covariance Matrix using Kernel

% Generate K Parameters
tic
K_Star = K_Function(X_Star,X,hp);                   % Calculate K_Star for New Point(s)
K_StarStar = K_Function(X_Star,X_Star,hp);          % Calculate K_StarStar for New Point(s)
prediction_kernel_calc_time = toc;

% Cholesky Decomposition
L = chol(V,'lower');                                % Lower triangular cholesky factor

% Calculate Predictions!
Y_Star_Hat = K_Star * CholeskySolve(L,Y);                   % Mean Predictions (mean values of Gaussians)
CapSigma_Star = K_StarStar-K_Star*CholeskySolve(L,K_Star'); % Variance Predictions (prediction covariance matrix)
Y_Star_Var = diag(CapSigma_Star);                           % The diagonals store the variances we want!

% LOG MARGINAL LIKELIHOOD
LML = calcLML(L,Y,nnum);
AlgoTime = toc;

% PLOTS & OUTPUTS
clc
fprintf('KernelPredictionTime = %1.2f.\n',prediction_kernel_calc_time)
fprintf('AlgoTime = %1.2f.\n',AlgoTime)
fprintf('Log Marginal Likelihood is %1.1f. Tune hyperparams for better fit.\n',LML)

% Plot Raw Data
figure
scatter3(X(:,1),X(:,2),Y, 2, 'k')
xlabel('X'),ylabel('Y'),zlabel('Depth')
title('Raw Training Data'), zlim([-5 5])

% Plot Prediction Data
figure
scatter3(X(:,1),X(:,2),Y, 2, 'k')
scatter3(X_Star(:,1),X_Star(:,2),Y_Star_Hat, 10, 2*sqrt(Y_Star_Var), 'filled')
xlabel('X'), ylabel('Y'), zlabel('Depth')
title('GPR 3D - Seafloor Ripples')
zlim([-5 5])
legend('Predictions','Location','North')
colormap();
bar = colorbar();
ylabel(bar,'variance')
xlabel('X'), ylabel('Y'), zlabel('Depth')
title('GPR 3D - Seafloor Ripples')
zlim([-5 5])

% Training and Prediction Data
figure
scatter3(X(:,1),X(:,2),Y, 5, 'r')
hold on
scatter3(X_Star(:,1),X_Star(:,2),Y_Star_Hat, 10, 2*sqrt(Y_Star_Var), 'filled')
xlabel('X'), ylabel('Y'), zlabel('Depth')
title('GPR 3D - Seafloor Ripples')
zlim([-5 5])
colormap();
legend('Raw Data','Predictions','Location','North')
bar = colorbar();
ylabel(bar,'variance')

% Function Definitions

function K = K_Function(X1, X2, hp)
    % Gaussian Kernel Function
    % X1, X2: Input matrices
    % hp: Hyperparameters structure containing L (lengthscale) and sigma_p (process noise)
    
    % Calculate the squared Euclidean distance
    sqdist = pdist2(X1, X2, 'euclidean').^2;
    
    % Calculate the covariance matrix using the Gaussian kernel
    K = (hp.sigma_p^2) * exp(-0.5 * sqdist / (hp.L^2));
end

function x = CholeskySolve(L, b)
    % CholeskySolve solves the linear system L*L'*x = b
    % where L is a lower triangular matrix from Cholesky decomposition.
    
    % Solve L*y = b for y
    y = L \ b;
    
    % Solve L'*x = y for x
    x = L' \ y;
end

function LML = calcLML(L, Y, nnum)
    % Calculate Log Marginal Likelihood
    % L: Cholesky factor of the covariance matrix
    % Y: Observations
    % nnum: Number of observations
    
    % Solve for alpha
    alpha = L' \ (L \ Y);
    
    % Calculate log determinant of V
    logDetV = 2 * sum(log(diag(L)));
    
    % Calculate Log Marginal Likelihood
    LML = -0.5 * (Y' * alpha + logDetV + nnum * log(2 * pi));
end