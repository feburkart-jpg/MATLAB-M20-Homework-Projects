%HW 6
%Felix Burkart 
%UID: 706483588
%date: 02/23/2026
%Game of Life Simulation and Euler-Bernoulli Beam Bending
    %Problem 1: Creates game of life simulat6ion over 200x150 matrix and
        %creates plot of time vs. # of cells 
    %Problem 2: Runs Euler_Bernoulli Beam Bending simulation given set
    %constraints and outputs plot describing deflection, shear force, and
    %bending moment, given a provided interval #, n.
%Colaborators: ChatGPT - helped me understand the taylor expansion of the
%second-order derivative 

%%
%Problem 1: Game of Life

%set matrix dimensions
i_grid = 200;
j_grid = 150;

%set grid with 10% chance of a given cell being alive
lifegrid = rand(i_grid,j_grid) < 0.1;


iter = 0; %start at iteration # 0
livecount = zeros(1,300); %intialize livecount array

while iter < 300
    
    newgrid = lifegrid;

    for i = 1:i_grid %scan through i_grid
        if i == 1; im1 = i_grid; else im1 = i-1; end
        if i == i_grid; ip1 = 1; else ip1 = i+1; end
            
        for j = 1:j_grid %scan through j-grid
            if j == 1; jm1 = j_grid; else jm1 = j-1; end
            if j == j_grid; jp1 = 1; else jp1 = j+1; end

            neighbors = lifegrid([im1,i,ip1],[jm1,j,jp1]); %identify neighbors by matrix surrounding cell in question
            livesum = sum(neighbors,'all') - lifegrid(i,j); %sum of neighbors

            %game of life conditions
           if lifegrid(i,j) == 1
                if livesum == 2 || livesum == 3
                    newgrid(i,j) = 1;
                else
                    newgrid(i,j) = 0;
                end
            else
                if livesum == 3
                    newgrid(i,j) = 1;
                else
                    newgrid(i,j) = 0;
                end
            end

        end
    end

lifegrid = newgrid;
    
iter = iter + 1; %iterate one step


livecount(iter) = sum(lifegrid, 'all'); %fill livecount inputs

imagesc(lifegrid) %plot every frame of iteration
title(['Iteration: ', num2str(iter)])
drawnow;
end

figure
plot(1:300, livecount); %plot time vs. livecount
xlabel("Iteration")
ylabel("Number of living cells")
title("Living Cells vs. Time")

%%
%Problem 2: Euler–Bernoulli Beam Bending

%set conidtions described in rubric
L = 2;
r = 0.01;
E = 68e9;
F = 1500;

I = (pi/4)*r^4; %calculate I value

%a) Grid Discretization

n = input("Grid points: ");

if n ~= floor(n) || n <= 0 %input verification
    error("Invalid Gid Point #")
end

interval = linspace(0, L, n); %make array with n intervals
grid_spacing = L/(n-1);

%b) Shear and Bending Moment

midindex = floor(n/2); %define midpoint of array

shearforce = zeros(1,n);
shearforce(1:midindex) = (F/2);
shearforce(midindex+1:n) = (-F/2);

bendingmoment = zeros(1,n);
bendingmoment(1:midindex) = (F/2)*interval(1:midindex);
bendingmoment(midindex+1:n) = (F/2)*(L - interval(midindex+1:n));

%C) Finite Difference Formulation

%set initial matix coniditons
A = zeros(n,n);
b = zeros(n,1);

%define known values
A(1,1) = 1;
A(n,n) = 1;

b(1) = 0;
b(n) = 0;

%fill out rest of values 
for k = 2:n-1 
    A(k,k-1) = 1;
    A(k,k) = -2;
    A(k,k+1) = 1;

    b(k) = (grid_spacing^2/(E*I)) * bendingmoment(k);

end

y = A\b; %solve for deflection

figure %make figure with three subplots

deflection = y; 
subplot(3,1,1);

hold on
plot(interval, zeros(size(interval)));  % Undeformed beam
plot(interval, deflection);               % Deflected beam

xlabel('Position along the beam (m)');
ylabel('Deflection (m)');
title('Undeformed and Deformed Beam');
legend('Undeformed','Deflected');
grid on
hold off

subplot(3,1,2)
plot(interval, shearforce);
xlabel('Position along the beam (m)');
ylabel('Shear Force')
title('Shear Force under Load');
grid on;

subplot(3,1,3);
plot(interval, bendingmoment);
xlabel('Position along the beam (m)');
ylabel('Bending Moment');
title('Bending moment under Load');
grid on;