% Conditional Statements
% Phil Parisi Code // Phil's Beginner Code
% 25July2020

%% WHILE Loop
clc, clear all

score = 25; %condition
i = 0; %counter

while score > 5
    disp('it is greater, keep on loopin')
    score = score - 1;
    i = i + 1;
end




%% For loop w/ a Break statement
clc, clear all

score = 25;

for i = 1:5
    
    % decrease score
    score = score - 1;
    
    % evaluate break
    if score == 5
        break
    end
    
    
end

