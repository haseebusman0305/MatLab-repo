% For Loops
% Phil Parisi Code
% 4May2020

%% Ex 1
clc, clear all

% Show the index
for i = 1:5
    i
    disp("next loop")
end


%% Ex 2
clc, clear all

cracks = [2 4 1 0 2];

% Display elements in cracks
for i = 1:5
    cracks(i)
    disp('next loop')
end





%% Ex 3
clc, clear all

cracks = [2 4 1 0 2];

% Sum elements in cracks
sum_cracks = 0;
for i = 1:5
    cracks(i)
    sum_cracks = cracks(i) + sum_cracks
    disp("next loop")
end


% END Video 1 of For Loops





%% Ex 4
clc, clear all

% New data! cracks is 2x5 matrix now
cracks = [2 4 1 0 2; 5 1 2 0 0]

% Add +3 to cracks in second row
for i = 1:length(cracks)
    cracks(2,i) = cracks(2,i) + 3;
end

cracks





%% Ex 5
clc, clear all


% Index thru matrix

cracks = [2 4 1 0 2; 5 1 2 0 0; 7 7 0 4 6];
[M N] = size(cracks);

for i = 1:M             % 1 to 3 (rows)
    
    for j = 1:N         % 1 to 5 (columns)
        cracks(i,j)
    end
    
end




%% Ex 6
clc, clear all

weather  = [0 1 0 0 1 0 0] % 1 = rain, 0 = sunny, 2 = partial showers

% Whenever we encounter 1, change the next day to 2
for i = 1:length(weather)
    
    % If weather is rain
    if weather(i) == 1;
        % Change next day (i+1) to partial showers
        weather(i+1) = 2;       
    end
    
end

weather






%% Ex 6
clc, clear all

weather  = [0 1 0 0 1 0 0]; % 1 = rain, 0 = sunny, 2 = partial chance
surfacewater = zeros(1,7);
% Whenever we encounter 1, change the next day to 2
for i = 1:length(weather)
    
    % If weather is rain
    if weather(i) == 1;
        
        % Change next day (i+1) to partial showers
        weather(i+1) = 2; 
        
        % Record ith day surfacewater
        surfacewater(i) = 10;
        
        % Record i+1 day surfacewater
        surfacewater(i+1) = 5;
        
    end
        
end


weather
surfacewater
    


%% Ex 7 
clc, clear all

data = [20 50 35 10 40 66 33];

for i = 2:length(data)
    new(i) = data(i) + data(i-1)
end


%% Ex 8
clc, clear all

data = [20 50 35 10 40 66 33];

for i = 1:length(data)
    new(i) = data(i) + data(i+1);
end
