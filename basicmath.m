% Matrix Math
% Phil Parisi Code // Phil's Beginner Code
% 25July2020

%% Matrix addition and multiplication
clc, clear all

% follows rules of linear algebra
x = linspace(0,100,101);
y = x + 3;

% matrix 1 3x5 multiply matrix 2 2x4
% general mxN * Mxn = mxn
% 3x5 * 5x2 --> 3x2

%2x3 * 3x1 --> 2x1
x = [1 2 3;
     6 7 2];
y = [4; 5; 6];
x*y;

%3x1 * 2x3
%y*x



w = linspace(0,5);
v = linspace(10,20);

w.^2
w.*w


y = w.*y./x



% most common pitfall (RIP)

% mismatched dimensions
% x*y vs. x.*y

% not using the '.'