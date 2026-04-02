%%HW 5
%Felix Burkart
%UID: 706483588
%date: 02/08/2026
%Recursive Function drawing Koch triangle 
%   created a recursive function that calls itself to draw koch triangle
%   until defined depth integer
%colaborators: ChatGPT: helped me find an effective way to calculate mid
%point of new triangles using material taught in this class


% Define the initial equilateral triangle vertices
p1 = [0, 0];
p2 = [1, 0];
p3 = [0.5, sqrt(3)/2];

depth = input('Enter depth: '); %user-input depth

hold on
axis equal



recursive_function(p1,p2,depth) %koch triangle from point 1-2
recursive_function(p2,p3,depth) %point 2-3
recursive_function(p3,p1,depth) %point 3-1

function recursive_function(p1,p2, depth)
    if depth == 0
        fprintf('Depth 0: Base case reached!\n');
        plot([p1(1), p2(1)], [p1(2), p2(2)], 'b-', 'LineWidth', 1.5);
            %plot the last lines defined in recursion
        return;
    end

v = (p2-p1)/3; %vector btw parent points
pa = p1+v; %first new point 
pc = p1 + 2*v; %last new point

u = pc - pa; %vector btw first & last new points
pb = (pa + pc)/2 - (sqrt(3)/2)*[-u(2) u(1)]; %apex of newly formed triangle




    % Recursive case: print current depth and recurse
    fprintf('Depth %d: Recursing vvv \n', depth);
    %perform recursivefunction for every line segment defined above
recursive_function(p1,pa, depth-1)
recursive_function(pa,pb, depth-1)
recursive_function(pb,pc, depth-1)
recursive_function(pc,p2, depth-1)
    fprintf('Depth %d: Returning ^^^ \n', depth);
end
