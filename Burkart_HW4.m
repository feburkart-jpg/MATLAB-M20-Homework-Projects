%%
% Problem 0
%HW 4
%Felix Burkart
%UID: 706483588
%date: 02/08/2026
%Bilt Credit Card 1.0, Bilt Credit Card 2.0, Bilt Credit Card 2.0.1
%   Problem 1 - plots described points made with varying rent payments
%   Problem 2 - compares 3 different cards using plotted values 
%       plotting points earned vs. dollars spent on non-rent first
%       then, plotting effective points vs. spend as % of rent 
%   Problem 3 - compares 3 different cards with tweaked rewards system
%       plotting effective points vs. spend as % of rent
%Collaborators - Anna Fedetov - Compared graphs 
%Google Gemini - helped me make a better multiplier system for Bilt Card
%2.0.1, compared to the array addition I had before 

%%
% Problem 1 - Bilt Credit Card 1.0
%a)
rent = 0:200:5000;
apples = 0.19*5;
dollars_spent = rent + apples;

points = 1* (dollars_spent);

figure(1);
plot(dollars_spent,points,'--m','Marker','o', 'MarkerFaceColor','m');
xlabel('Total Dollars Spent (Rent + apples)')
ylabel('points earned')
title('Problem 1 - Points Earned vs. Dollars Spent');
grid on;

%b)
%   point earning and rent cost have a directly linear relationship,
%   because Olivia's card gives her 1x back for rent as well as groceries

%C)
%   No, because even at the highest point return margin, dining for x3,
%the Bilt 1.0 card gives the same effective cash back at 1 cent per point
%%
%%Problem 2 - Bilt Credit Card 2.0
%a)
rent = 4000;
dollars_spent = 1:4500; 
everyday = 0.2 * dollars_spent; %following 2:3:5 ratio 
dining = 0.3 * dollars_spent;
travel = 0.5 * dollars_spent;

bilt_cash = 0.04 * dollars_spent;
rent_points = (bilt_cash/30) * 1000;
rent_points = min(rent_points, rent); %set max points condition for Bilt rewards

%card multipliers
blue = (everyday + dining + travel) + rent_points;
obsidian = (everyday + 3*dining + 2*travel) + rent_points;
palladium = (2*everyday + 2*dining + 2*travel) + rent_points;

figure(2);
plot(dollars_spent, blue, '-b', 'DisplayName', 'Blue Points');
hold on;
plot(dollars_spent, obsidian, '-r', 'DisplayName', 'Obsidian Points');
plot(dollars_spent, palladium, '-g', 'DisplayName', 'Palladium Points');
legend show;
grid on;
xlabel('dollars spent on non-rent purchases')
ylabel('points earned')
title('points earned vs dollars spent on non-rent purchases')

%b)
%Once Olivia spends more than $3000, the rent points unlocked through 
% Bilt Cash reach their maximum and stop increasing. After this point, 
% additional spending only earns points from non-rent purchases, so the 
% curves continue linearly with a reduced slope.


%%
%c)
dollars_spent = 1:6000; %for x-axis up to 150%, start at 1 to avoid 0/0

%re-declare all variables for new dollars_spent range
everyday = 0.2*dollars_spent;
dining = 0.3*dollars_spent;
travel = 0.5*dollars_spent;
rent_points = (1000/30)*0.04*dollars_spent;
rent_points = min(rent_points, 4000);
blue = dollars_spent + rent_points;
obsidian = 3*dining + 2*travel + everyday + rent_points;
palladium = 2*dollars_spent + rent_points;

figure; 
blue_effective = blue./dollars_spent; %array division for effective points per $
obsidian_effective = obsidian./dollars_spent;
palladium_effective = palladium./dollars_spent;

spend_percent = dollars_spent/4000 * 100;

plot(spend_percent,blue_effective, '-b', 'DisplayName', "Blue Effective")
hold on;
title("Effective Points Earned per $1 vs. Credit Card Spend as % of Rent")
xlabel("Credit Card Spend as % of Rent")
ylabel("Effective Points Earned per $1 dollar of Credit Card Spend")
plot(spend_percent, obsidian_effective, '-r', "DisplayName", "Obsidian Effective")
plot(spend_percent, palladium_effective, '-g', 'DisplayName', 'Palladium Effective')
legend show; 
grid on;

%d)
%   Once Olivia spends more than 75% of of her rent amount, the rate at
%   which she earns points per dollar plateaus.

%e)
xline(100*(500/3000),'--r') 

%f)
%   The obsidian card is the most ideal for Olivia for the situation
%   described above. It is also generally the best card for Olivia given
%   her spending ratios. 

%%
%Problem 3 - Bilt Credit Card 2.0.1
%a)
rent = 4000;
everyday_spend = 50:6000; %starts at 50 to avoid giant spike, $50 per month unrealistic anyways
spend_percent = everyday_spend/rent * 100;

multiplier = zeros(size(everyday_spend)); %set an all zero array the size of everyday spend

%set multiplier values using logical operators within the array
multiplier(everyday_spend >= 0.25*rent) = 0.5;
multiplier(everyday_spend >= 0.5*rent)  = 0.75;
multiplier(everyday_spend >= 0.75*rent) = 1.0;
multiplier(everyday_spend >= rent)      = 1.25;

bilt_points_2 = rent * multiplier;

bilt_points_2(everyday_spend < 0.25*rent) = 250; %for values below 25% of rent

blue = everyday_spend + bilt_points_2;
obsidian = everyday_spend +  bilt_points_2;
palladium = 2*everyday_spend + bilt_points_2;

blue_effective = blue./everyday_spend;
obsidian_effective = obsidian./everyday_spend;
palladium_effective = palladium./everyday_spend;

figure;
plot(spend_percent, blue_effective, '-b', 'DisplayName', "Blue Effective");
hold on;
title("Bilt 2.0.1 effective points earned per $1 vs. card spend as % rent")
xlabel("Credit Card Spend as % of Rent");
ylabel("Effective Points Earned per $1 dollar of Credit Card Spend");
plot(spend_percent, obsidian_effective, '-r', "DisplayName", "Obsidian Effective");
plot(spend_percent, palladium_effective, '-g', 'DisplayName', 'Palladium Effective');
legend show; 
grid on;

%b)
%   When taking effective points earned per $1 and comparing 
% to amount spent as % of rent, the Bilt Cash system is generally 
% a better earnings structure, since it is more consistent. 
% However, at very particular rent % points (25% and below 3.15%) 
% for the Palladium card using the Housing Only Rewards, effective
% points earned is better with the Housing Only Rewards. 

%c)
%   Given her spending ratio, and the percent of her rent she spends on
%   every day items (as described in part e of problem 2) I would recommend
%   the Obsidian card with the Bilt Cash rewards structure, for the best
%   return on the money she spends. 