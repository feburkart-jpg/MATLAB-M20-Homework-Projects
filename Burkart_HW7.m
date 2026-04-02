%HW 7
%Felix Burkart 
%UID: 706483588
%date: 03/02/2026
%Mixed Data in Cell arrays and structs, applied 
    %Problem 1 - creates a 2x2 cell array and access points inside
    %Problem 2 - creates a struct with Credit Card info and accesses
    %related entries 
    %Problem 3 - initializes sensor data and creates a function that plots
    %it

%Problem 1 - Mixed Data in Cell Arrays.

%create Cell array 
c = cell(2,2);
c{1,1} = "MATLAB";
c{1,2} = [10 20 30 40];
c{2,1} = 3.14;
c{2,2} = "M20";

average = mean(c{1,2}); %store average value of stored array 

fprintf("%s %.2f",c{1,1},average)

%%
%Problem 2 - Credit Card Struct Initialization

%initialize struct sections
names = {'Bilt Blue', 'Sapphire Reserve', 'VentureX', 'Hilton', 'United Explorer'};
credit_limit = [10000 20000 25000 3000 4000];
payment_systems = {'mastercard', 'visa', 'visa', 'american express','visa'};
annual_fee = [99 695 395 95 150];

%create struct 
card_data = struct('names',names,'credit_limit', credit_limit, 'payment_system',payment_systems,'annual_fee', annual_fee);

values = [card_data.annual_fee]; %separate array of values within struct
[maxvalue, indexOfMax] = max(values); %find index of max value 

%index of max value has same index of corresponding name
fprintf('Card with highest fee is %s with a fee of %d',card_data(indexOfMax).names,maxvalue)

%%
%Problem 3 - Sensor Data Analysis & Plotting.

%create struct 
sensorData.time = 0:0.1:10;
sensorData.temperature = 20+5*sin(0.5*sensorData.time);
sensorData.pressure = 101+2*cos(0.2*sensorData.time);

plotSensorData(sensorData)

%initialize function 
function[] = plotSensorData(data)
yyaxis left
plot(data.time, data.temperature)
ylabel('Temperature')

yyaxis right
plot(data.time, data.pressure)
ylabel('Pressure')

xlabel('Time')
legend('Temperature','Pressure')
title('Sensor Data vs Time')

end
