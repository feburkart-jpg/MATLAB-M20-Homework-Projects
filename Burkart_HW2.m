%%HW 2
%Felix Burkart
%UID: 706483588
%date: 01/22/2026
%Binary Conversion,Tax Slab Calculation and  Modified Neighbor Identification
%   Problem 1: Converts integers =< 1023 into binary
%   Problem 2: Calculates tax payment based on income and tax bracket
%   Problem 3: Identifies neighbors of a given cell within a given matrix
% Collaborators:Seqouia Ashby - explained that binary conversion should be
%   concatination of numbers as strings


clc
%%
Problem = input("Problem # (1,2,3): ");

switch Problem 
%% Problem 1, Binary Conversion 
    case 1
integer = input("Enter an integer <= 1023: ");

if  ~isnumeric(integer) || ~isscalar(integer) || mod(integer,1)~=0
    error("Input must be a single integer");
end

if integer < 0 || integer > 1023
    error("Input must be between 0 and 1023")
end


%setting boundary cases for highest bit value to lowest
if integer >= 512
    fprintf("1")
    integer = integer - 512;
else
    fprintf("0");
end

if integer >= 256
    fprintf("1")
    integer = integer - 256;
else
    fprintf("0");
end

if integer >= 128
    fprintf("1")
    integer = integer - 128;
else
    fprintf("0")
end

if integer >= 64
    fprintf("1")
    integer = integer - 64; 
else
    fprintf("0")
end

if integer >= 32
    fprintf("1")
    integer = integer - 32;
else
    fprintf("0")
end

if integer >= 16
    fprintf("1")
    integer = integer - 16;
else
    fprintf("0")
end

if integer >= 8
    fprintf("1")
    integer = integer - 8;
else
    fprintf("0")
end

if integer >= 4
    fprintf("1")
    integer = integer - 4;
else
    fprintf("0")
end

if integer >= 2
    fprintf("1")
    integer = integer - 2;
else
    fprintf("0")
end

if integer >= 1
    fprintf("1\n")
    integer = integer - 1;
else
    fprintf("0\n")
end


%% Problem 2, Tax Slab Calculation 
    case 2

income = input("enter your annual income: ");
tax = 0;

%Check for valid input, integer & positive
if ~isnumeric(income) || ~isscalar(income) || mod(income,1) ~= 0
    error("Income must be an integer")
end

if income < 0
    error("Income must be greater than 0")
end

%while income is greater than 0, work through progressive tax bracket
%   beginning with highest bracket

if income > 50000
    tax = tax + (income-50000)*0.3;
    income = income - (income-50000);
end

if income > 20000
    tax = tax + (income-20000)*0.2;
    income = income - (income-20000);
end

if income > 10000
    tax = tax + (income-10000) * 0.1;
    income = 0;
end


%print output: tax owed
fprintf("Your tax for the year is $%.2f\n", tax)

%%Problem 3, Modified Neighbor Identification
case 3
M = input("Number of rows: ");
N = input("Number of columns: ");
P = input("Cell of interest: ");

%input validation
if ~isnumeric(M) || ~isscalar(M) || mod(M,1) ~= 0 || M < 2
    error("Row number must be an integer greater than 2")
end

if ~isnumeric(N) || ~isscalar(N) || mod(N,1) ~= 0 || (N < 2)
    error("Column number must be an integer greater than 2")
end

if ~isnumeric(P) || ~isscalar(P) || mod(P,1) ~= 0 || P>(M*N)
    error("Cell of interest must be an integer within matrix")
end


%identify all theoretical neighboring tiles
left = (P-M);
top = (P-1);
bottom = (P+1);
right = (P+M);

%print cell id
fprintf("Cell id: %d\n", P)

%check special cases 
%left side
if P <= M 
    %top left
    if P==1
        Neighbors = [bottom, right]; 
    %bottom left
    elseif P==M
       Neighbors = [top, right];
    else
        Neighbors = [top, bottom, right];
    end
%right side
elseif P>= (M*N-(M-1)) 
    %top right
    if P==(M*N-(M-1))
        Neighbors = [left, bottom];
    %bottom right
    elseif P==(M*N)
        Neighbors = [left, top];
    else
        Neighbors = [left, top, bottom];
    end
%top side
elseif mod(P,M) == 1 && ~(P==1) && ~(P==(M*N-(M-1)))
    Neighbors = [left, bottom, right];
%bottom side
elseif mod(P,M) == 0 && ~(P==M) && ~(P==M*N)
    Neighbors = [left, top, right];
%normal cases
else
    Neighbors = [left, top, bottom, right];
end

%sort neighbor values and print them 
Neighbors = sort(Neighbors);
fprintf("Neighbors: ")
fprintf("%d ", Neighbors)
fprintf("\n")

end
%% (C)
%Yes, numbering would proceed normally across the x and y directions and
%   start again at the top left cell of the slice one cell deep and continue
%   in that pattern. 
%In 3D we can classify cells as corner, edge, side and interior where:
%  corner: 3 neighbors
%   edge: 4 neighbors
%   side: 5 neighbors
%   interior: 6 neighbors