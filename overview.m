% MATLAB Overview
% P.Parisi 25May2020


%% Part 1 - Assign and Clear Variables


% Assign x
x = 7

% Assign y from x
% y = x + 3

% Re-assign x


% using semicolons, output
% add comments with percent sign --> %




%% Make a Matrix


% Create and output a matrix (command window & workspace variable)
y = [0 2; 7 8; 3 4]

% Calling Values, Index starts at ONE!!!
%y(2,2)
%y(1,2)

% Changing Values
%y(2,2) = 1

%% Unique Matrices

% Identity Matrix
z = eye(10)

% Zero Matrix
%test = zeros(3)

% Unity Matrix
%test2 = ones(4)

% Transpose
%why = [1;2;3;4]
%why_not = why'


%% Mathing with Matrices

clc, clear all

%x = linspace(0,10,11)   % Items sold per customer
%y = 3*x                 % Number of daily customers

% Calc total number of items
%day_totals = x*y


% Actual Matrix Multiplication
u = [1 2 3 4];
w = [2; 2; 2; 2];
u*w
w*u

xi = [1 2 4; 4 5 6; 3 3 3]
new_w = xi(1,:)

























%% Import Excel
clc, close all, clear all

% Import Excel Data
excel_data = xlsread('FractureData.xlsx');
excel_data = excel_data';

% Define x and y data to Plot
x_excel = excel_data(1,:);
y_excel = excel_data(2,:);




%% Plotting
clc, close all, clearvars -except x_excel y_excel

% Raw Data
x1 = linspace(0,10,11);                 % Day
y1 = [0 1 3 12 15 27 34 50 66 75 101];  % Number of Fractures

% Plot the Data

figure(1)
subplot(1,2,1)
plot(x1,y1,'om','MarkerFaceColor','m','Markersize',5)

hold on

y2 = x1.^2;
plot(x1,y2,'m--')

hold on

plot(x1(6),y1(6),'ko','Markersize',8,'MarkerFaceColor','k')

% Add Plot Features
title('Fractures in Mayweather Bridge')
xlabel('Day')
ylabel('Number of Fractures')
legend('Raw Data','Raw Data Trendline','Key Point','Location','Northwest')

% Change Axes Limits
xlim([0 12])
ylim([0 120])
grid on

% Add Text
text(x1(6),y1(6),'Fracture Point!')

% SECOND SUBPLOT
subplot(1,2,2)

plot(x_excel,y_excel)


figure(2)
plot(x1,y1)






%gtext('Complete Fracture')



% Add color and change markers
% help plot command

% Control the Axes
% xlim([0 11])
% ylim([0 120])
% grid on


% Add multiple lines / data
% hold on
% Data should be points, trendlines should be lines
%legend()

% Add text to graph
%text(2.5,3,'Fracture Point!')
%gtext('Mouse Click Fracture Point!')


% Figures and Subplots w/ more data
%subplot(1,2,2)
%plot(x1,y1)






% Other kinds of plot
%bar, pie
%y = [2 2 3; 2 5 6; 2 8 9; 2 11 12];
%reference page
