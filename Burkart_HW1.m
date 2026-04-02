%% HW 1

%Concatenating strings and Perimeter Estimation
%   Below is the code to solve Problem 1 and 2 of HW 1
%       Problem 1 concatenates two strings flipping the second
%       Problem 2 provides many perimeter estimations for two given variables
% Name: Felix Burkart UID: 706483588
% Date: 01/12/2026
% Collaborators: used google to figure out that i needed "s" 

clear all
close all
clc
%% Problem 1

% Take the first user input from command window
string1 = input('Enter a string: ', "s");

%Take the second user input from command window
 string2 = input('Enter a second string: ', "s");

 %flip string2
 string2 = fliplr(string2);

 % Display output
fprintf('%s %s\n', string1, string2)
%%  Problem 2
%------------------------------------------------
%   Input values (a,b) for the ellipse
a = input('input axes a: ');
b = input('input axes b: ');
%------------------------------------------------
%------------------------------------------------
%   Approximation for its perimeter

%calculate h value, needed in perimeter calculations
h = ((a-b) / (a+b))^2;

%calculate all possible perimeter expressions
P1 = pi * (a+b);
P2 = pi * sqrt(2 * (a^2 + b^2));
P3 = pi * sqrt(2 * (a^2 + b^2) - (a-b)^2/2);
P4 = pi * (a+b) * (1 + h/8)^2;
P5 = pi * (a+b) * (1 + ((3*h) / (10 + sqrt(4 - 3*h))));
P6 = pi * (a+b) * ((64 - 3*h^2) / (64-16*h));
P7 = pi * (a+b) * ((256-  48*h - 21*h^2) / (256 - 112*h + 3*h^2));
P8 = pi * (a+b) * ((3 - sqrt(1-h)) / 2);

%------------------------------------------------
%------------------------------------------------
%   Display the results

%print h value in scientific notation to second decimal place
fprintf('h: %.2e\n\n',h)

%print perimeter results to the second decimal place
%print as two lines of four for easy viewing
%seperated into two print statements for code readability
fprintf('P1:%.2f  P2:%.2f  P3:%.2f  P4:%.2f\n',P1,P2,P3,P4)
fprintf('P5:%.2f  P6:%.2f  P7:%.2f  P8:%.2f\n',P5,P6,P7,P8)
%-----------------------------------------------
%   discrepancies among perimeter formula 

%as ellipse becomes more oblong the perimeter expressions become less
%uniform; harder to estimate perimeter
%-----------------------------------------------




