%HW 8
%Felix Burkart 
%UID: 706483588
%date: 03/11/2026
%Data Set Plotting, Koch Snowflake video 
    %Problem 1 - reads 'titanic.csv', cleans data and plots specific data
    %Problem 2 - plots koch snowflake depth-wise, records every depth
    %iteration as a frame, and outputs video of koch triangle generation
%ChatGPT - helped me set up and understand the how to make a best fit line
%for the plot, and helped me troubleshoot solutions for the last frame of
%Koch triangle to stay visible for longer

%%
%Problem 1 - Titanic Data Set Plotting

data = readtable('titanic.csv'); %read data and declare data variable

 %cleans data by replacing missing values with means
data.Age = fillmissing(data.Age, 'constant', mean(data.Age, 'omitnan'));
data.Fare = fillmissing(data.Fare, 'constant', mean(data.Fare, 'omitnan'));

%sets variables equal to subsections of struct for easy plotting
age = data.Age;
fare = data.Fare;


%plot
scatter(age, fare)
xlabel('Passenger Age')
ylabel('Passenger Fare');
title('Scatter Plot of Age vs Fare');
hold on;

p = polyfit(age, fare, 1); %calculates the coefficients for a straight line

%creates fitted lines for smooth best-fit
xfit = linspace(min(age), max(age), 100);
yfit = polyval(p, xfit);

plot(xfit, yfit) %plots the best-fit line

y_pred = polyval(p, age); %variable storing predicted fare values based on best-fit

SSres = sum((fare - y_pred).^2); %residual sum of squares
SStot = sum((fare - mean(fare)).^2); %total sum of squares

R2 = 1 - SSres/SStot; %solves for R2 value

%stores best fit equation and R2 values
eq = sprintf('y = %.2fx + %.2f', p(1), p(2));
r2text = sprintf('R^2 = %.3f', R2);

text(min(age), max(fare), {eq, r2text}) %puts text on plot

saveas(gcf,'titanic.png') %saves plot as png


%%
%Problem 2 - Koch Snowflake Part 2

% Define the initial equilateral triangle vertices
p1 = [0, 0];
p2 = [1, 0];
p3 = [0.5, sqrt(3)/2];

depth = input('Enter depth: '); % user-input depth

v = VideoWriter('Kochsnowflake.mp4','MPEG-4');
v.FrameRate = 2;
open(v)

figure
hold on
axis equal
axis([-0.5 1.5 -0.5 1.5])

for d = 1:depth


    % Draw snowflake for current depth
    recursive_function(p1,p2,d)
    recursive_function(p2,p3,d)
    recursive_function(p3,p1,d)

    title(['Depth = ', num2str(d)])


    drawnow %drawing finishes before each frame 

    frame = getframe(gcf);
    writeVideo(v,frame);

end

%hold frame so it doesn't end on last depth iteration
for k = 1:6
    writeVideo(v,frame);
end

close(v)

%Koch triangle function, slight tweak of previous homework
function recursive_function(p1,p2,depth)


    if depth == 0
        plot([p1(1), p2(1)], [p1(2), p2(2)], 'b-', 'LineWidth', 1.5)
        return
    end

    v = (p2 - p1)/3;

    pa = p1 + v;
    pc = p1 + 2*v;

    u = pc - pa;
    pb = (pa + pc)/2 - (sqrt(3)/2)*[-u(2) u(1)];


    recursive_function(p1,pa,depth-1)
    recursive_function(pa,pb,depth-1)
    recursive_function(pb,pc,depth-1)
    recursive_function(pc,p2,depth-1)

end
