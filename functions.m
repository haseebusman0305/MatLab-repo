% Essential Functions
% Phil Parisi Code // Phils Beginner Code
% 25July2020

%% clc, close all, clear all

% clc clears the command window
clc

% close all exits out of figures such as plots (closes them)
close all

% clear all clears workspace variables
clear all






%% clearvars -except
clc, clear all

z = 10;
x = 12;
y = 60;

clearvars -except y

y + 3



%% disp()
clc, clear all

%display any output (text or numeric)
text_to_show = 'help I need somebody help!';
disp(text_to_show)

y = 240;
disp(y)







%% fprintf()
clc, clear all

y = 240;
fprintf('The answer is... \n ...%d meters! \n', y)









%% e vs. exp
clc, clear all

% five times 10 to the 'power'
5e2
5e10

% 5 * e^2
5*exp(2)






%% sqrt() and pi and abs()
clc, clear all

sqrt(25)

pi*2

sqrt(abs(-25))









%% linspace()
clc, clear all

% create a matrix, vector, array from x1 to x2 w/ N values in between
x = linspace(0,1,100)









%% eye() and zeros()
clc, clear all

% create an identity matrix
eye(3) %argument sets square dimension nxn

% create a zero matrix, nxn
zeros(4)







%% det()
clc, clear all

B = [2 4 -3;
    1 9 0;
    2 -7 -1]
det(B)








%% rref()
%Reduced Row Echelon Form
clc, clear all

% set of equations
% x  + 0y = 4
% 2x + 8y = 16

A = [1 0 4;
    2 8 16];

rref(A)







%% hold on (for plotting)

x = linspace(0,10,20);
y = linspace(20,30,20);
z = linspace(30,40,20);

plot(x,y,'bv')
hold on     % allows multiple datasets/lines on 1 figure
plot(x,z,'ro')








%% rand()
clc, clear all

% create a random number or matrix (values between zero and one)
rand(1);

% random number between A and B
a = 7; b = 10;

rand(1)*(b-a) + a







%% max() and min()
clc, clear all

stresses = [320, 190, 44, 690, 111, 1019, 3123, 3332, 889, 9012, 55, -1000, 7231, 8920, 5555, 2551];

%find maxmimum (or min) value and its position
[stress_max, index] = max(stresses)













%% ceil(), floor(), round()
clc, clear all

x = 5.148
round(x)

y = 7.7
floor(y)

ceil(x)

fix(-4.2)


%% polyfit() & polyval()
clc, clear all, close all

x = [1 2 3 4 5 6 7];
y = [2 5 7 20 22 40 48];

a = polyfit(x,y,2); %looks like an x^2 (put 2 as argument for order of polynomial)
y_fit = polyval(a,x);


plot(x,y,'bv')
hold on
plot(x,y_fit,'r','Linewidth',2)






%% roots
%find the roots of an equation
clc, clear all

% y = x^2 + 0x + -2
% order matters!!!!!
coefficients = [1,0,-2];
roots(coefficients)













%% function = @x
clc, clear all, close all

radius = 2; %set parameters
calc_cyl_vol = @(x) pi*(radius^2)*x; %define quick function

%calc cylinder volume with h=3 (plug in for x)
calc_cyl_vol(3)








%% table()
clc, clear all

%table elements
TotalDeaths = 24000;
Survivors = 123000000;
BioDiversity = .8;

%put into table
table1 = table(TotalDeaths,Survivors,BioDiversity);

%output table
disp(table1)





%% input()
%prompts for user input

clc, clear all

previous_cracks = 42;
new_cracks = input('How many cracks in the bridge today? ');

total_cracks = previous_cracks + new_cracks
disp('you should get crackin!')








