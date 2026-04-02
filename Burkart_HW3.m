%%HW 3
%Felix Burkart
%UID: 706483588
%date: 02/02/2026
%Golden Ratio Calculation, and Pocket change optimization 
%Problem 1 uses a taylor expansion of 2cos(36) and the fibbonacci sequence
%   to give golden ratio float values that match an input uncertainty value
%Problem 2 calculates average pocket change needed for all possible cent
%   values using the standard american coin system 
%colaborators: Google Gemini - helped me understand that the uncertainty
%   used in the example was comparing the fibbonacci sequence ratio to the
%   true value it was converging to rather than the prior value in the
%   sequence

clc
clear

problem = input("Enter problem number (1,2): ");
switch problem 

%%Problem 1 - Golden Ratio
case 1

%taylor series expansion 

    %input tolerance value
uncertainty = input("Enter Tolerance: ");

    %set variables used in while loop
value = 0;
x = pi/5;
n = 0;

    %start at non-zero term so first iteration of while loop triggers
term = 1;

    %set uncertainty condition
while abs(term) > uncertainty/2
 
        %taylor series 
    term = (-1)^n * (x)^(2*n) / factorial(2*n);
    value = value + term;
    n = n + 1;

end 

final = 2*value;
fprintf('Taylor golden ratio is %.12f\n', final)


%Fibonacci Sequence
 
    %set variables used in while loop
n_2 = 0;
n_1 = 1;
fibo_final = 0;
fibo_former = 1;
cycle = 2;
phi = (1 + sqrt(5))/2; %"true" golden ratio sequence converges to

    %set uncertainty condition
while abs(fibo_final - phi) > uncertainty

    fibo_former = fibo_final;
    
    n_t = n_1;
    n_1 = n_2 + n_1;
    n_2 = n_t;
    
    fibo_final = n_1/n_2;
    cycle = cycle + 1;
end

fprintf("fibonacci golden ratio is %.12f\n",fibo_final)
fprintf("%d numbers were needed to achieve this result.\n", cycle)

%%problem 2 - The Pocket Change Problem
    case 2
c = 0:99;

%set coin values (used for part d)
Q_value = 25;
D_value = 10;
N_value = 5;
max = length(c); %allows for variability in array
coins = 0;

for i = 1:max %loop for every entry in the defined array
    Q = 0;
    D = 0;
    N = 0;
    P = 0;
        change = c(i); %counts coins needed for every entry in array
    while change > 0
        if change >= Q_value
            change = change - Q_value;
            Q = Q + 1;
        elseif change >= D_value
            change = change - D_value;
            D = D + 1;
        elseif change >= N_value
            change = change - N_value;
            N = N + 1;
        else
            change = change - 1;
            P = P + 1;
        end

    end
coins = coins + Q + D + N + P; %sum of all coins for every entry

end

average = coins/max; 
fprintf('Average Number of Coins = %.2f\n', average)

end

%%b)
%The average number of coins needed drops from 4.70 to 2.70.
%
% The 2.70 value makes sense when you consider that from cent values 0-95
%when all values are multiples of 5, every number can be made by 3 or less
%coins, explaining a average value slightly below 3

%%c)
%So far the most optimal monetary system I have discoverd has
%Quarters = 35, Dimes = 12, and Nickles = 3
%This system gives an average number of coins of 4.26
%I think the most significant disadvanatage would be the inconvenience of
%calculating cummulative coin values in your head, we work well with a base
%5 system, and only computers could effeciently work with a non-base ten or
%five coin system effectively. 