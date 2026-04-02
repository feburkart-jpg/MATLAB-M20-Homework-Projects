% Felix Burkart
% M20 Final Project
%UID: 706483588
%date: 03/12/2026

clearvars
close all
clc

createGUI()


function createGUI()

maxSize = 150;
maxOrient = 200;
maxTemp = 2000;

f = figure('Position',[300 300 420 380],'Name','Grain Growth Simulator');

%% SAMPLE SIZE
uicontrol(f,'Style','text','Position',[20 330 200 20],'String','Sample Size (NxN)');
sizeSlider = uicontrol(f,'Style','slider','Min',20,'Max',150,'Value',60,'Position',[20 310 250 20]);
sizeLabel = uicontrol(f,'Style','text','Position',[280 310 60 20],'String','60');

%% ORIENTATIONS
uicontrol(f,'Style','text','Position',[20 270 200 20],'String','Grain Orientations');
orientSlider = uicontrol(f,'Style','slider','Min',5,'Max',200,'Value',50,'Position',[20 250 250 20]);
orientLabel = uicontrol(f,'Style','text','Position',[280 250 60 20],'String','50');

%% TEMPERATURE
uicontrol(f,'Style','text','Position',[20 210 200 20],'String','Temperature');
tempSlider = uicontrol(f,'Style','slider','Min',1,'Max',2000,'Value',400,'Position',[20 190 250 20]);
tempLabel = uicontrol(f,'Style','text','Position',[280 190 60 20],'String','400');

%% RUN BUTTON
uicontrol(f,'Style','pushbutton',...
    'String','Run Simulation',...
    'Position',[120 80 160 50],...
    'Callback',@runSimulation);

%% UPDATE SLIDER LABELS
sizeSlider.Callback = @(src,~) set(sizeLabel,'String',num2str(round(src.Value)));
orientSlider.Callback = @(src,~) set(orientLabel,'String',num2str(round(src.Value)));
tempSlider.Callback = @(src,~) set(tempLabel,'String',num2str(round(src.Value)));

%% RUN SIMULATION

function runSimulation(~,~)

N = round(sizeSlider.Value);
M = N;
G = round(orientSlider.Value);
T = round(tempSlider.Value);


if N > maxSize || G > maxOrient || T > maxTemp
    errordlg('Selected parameters exceed allowed limits.','Parameter Error');
    return
end

numSweeps = 200;

sample = randi(G,N,M);
[x,y] = meshgrid(1:M,1:N);

%% PERFORMANCE OPTIMIZATION
step = 1;
renderSkip = 1;

if N > 80
    step = 2;
end

if N > 120
    step = 3;
    renderSkip = 2;
end

avg_area_history = zeros(1,numSweeps);

figure('Name','Grain Growth Simulation');


%% MAIN SIMULATION LOOP

for sweep = 1:numSweeps

    for i = 1:(N*M)

        row = randi(N);
        col = randi(M);

        current_cell = sample(row,col);

        row_up    = mod(row-2,N) + 1;
        row_down  = mod(row,N) + 1;
        col_left  = mod(col-2,M) + 1;
        col_right = mod(col,M) + 1;

        neighbors = [
            sample(row_up,col)
            sample(row_down,col)
            sample(row,col_left)
            sample(row,col_right)
            sample(row_up,col_right)
            sample(row_down,col_right)
            sample(row_up,col_left)
            sample(row_down,col_left)
        ];

        Cell_neighbor = neighbors(randi(8));

        if Cell_neighbor ~= current_cell

            E_old = sum(neighbors ~= current_cell);
            E_new = sum(neighbors ~= Cell_neighbor);

            deltaE = E_new - E_old;

            if deltaE < 0 || rand() < exp(-deltaE/T)
                sample(row,col) = Cell_neighbor;
            end

        end

    end

    %% GRAIN SIZE CALCULATION
    num_grains = numel(unique(sample));
    avg_area = (N*M)/num_grains;
    avg_area_history(sweep) = avg_area;

    %% ORIENTATION VECTORS
    theta = 2*pi*(sample-1)/G;
    u = cos(theta);
    v = sin(theta);

    %% SKIP RENDERING IF LARGE
    if mod(sweep,renderSkip) ~= 0
        continue
    end

    %% MICROSTRUCTURE
    subplot(1,2,1)

    imagesc(sample)
    colormap(parula)
    axis equal off
    hold on

    quiver(x(1:step:end,1:step:end),...
           y(1:step:end,1:step:end),...
           u(1:step:end,1:step:end),...
           v(1:step:end,1:step:end),...
           0.4,'k')

    title(['Grain Structure (Sweep ',num2str(sweep),')'])

    text(2,3,['Avg Grain Area: ',num2str(avg_area,'%.1f')],...
        'Color','white','FontSize',12,'FontWeight','bold')

    hold off

    %% GRAIN GROWTH GRAPH
    subplot(1,2,2)

    plot(1:sweep,avg_area_history(1:sweep),'b','LineWidth',2)
    hold on
    plot(sweep,avg_area_history(sweep),'ro','MarkerFaceColor','r')

    xlabel('Monte Carlo Sweeps')
    ylabel('Average Grain Area')
    title('Grain Growth Over Time')
    grid on
    xlim([0 numSweeps])

    hold off

    drawnow

end
end
end