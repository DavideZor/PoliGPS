%%%%%%%%%%%%%%%% GPS Tracker Fictional Data generation %%%%%%%%%%%%%%%%%%%%

%This script aims to generate feasible data for the times, the costs and
%the risks in an average day in Milan.

nodes = load('NODES.txt'); %Position of the graph nodes
graph = load('GRAPH.txt'); %Arcs and graph properties
turns = load('TURNS.txt'); %Not allowed turns
ID_nodes = nodes(:,1);
arcs = graph(:,2:3);
n_arcs = size(graph,1);
n_nodes = length(ID_nodes);

distances = graph(:,4); %[km]
max_speed = graph(:,7); %[km/h]

min_times = 60 * 60 * distances./max_speed; %[s]

%We differentiate three vehicles types:
%1 - motorbike: the motorbike can go up to 0.95 times the speed limit and
%it is not affected very much by the traffic. That's why during the day its
%coefficient varies between 0.9 and 1
%2 - car: the car can go up to 0.9 times the speed limit and it is slightly
%affected by the traffic. During the day its random coefficient varies
%between 0.85 to 1
%3 - truck: the truck can go up to 0.8 times the speed limit and it is
%strongly affected by traffic. During the day its random coefficient varies
%between 0.5 and 0.9 

motorbike_speed = 0.95 * max_speed;
car_speed = 0.9 * max_speed;
truck_speed = 0.8 * max_speed;

motorbike_timetable = (60 * 60 * distances./motorbike_speed); 
car_timetable = (60 * 60 * distances./car_speed);
truck_timetable = (60 * 60 * distances./truck_speed);

motorbike_coefficient = 0.9 + (1-0.9)*rand(1,1);
car_coefficient = 0.85 + (1-0.85)*rand(1,1);
truck_coefficient = 0.5 + (0.9-0.5)*rand(1,1);

motorbike_coefficients = 1./motorbike_coefficient;
car_coefficients = 1./car_coefficient;
truck_coefficients = 1./truck_coefficient;

motorbike_timetable = motorbike_coefficients * motorbike_timetable;
car_timetable = car_coefficients * car_timetable;
truck_timetable = truck_coefficients * truck_timetable;

%There are three types of vehicle according to the costs:
%1 - gasoline: 0.544€/km
%2 - diesel: 0.53€/km
%3 - electrical: 0.5131€/km

gasoline = 0.544 * distances;
diesel = 0.53 * distances;
electrical = 0.5131 * distances;

%The highway tolls are now considered (0.1€/km):

for i = 1:n_arcs
    if graph(i,5) == 1
        gasoline(i) = gasoline(i) + distances(i) * 0.1;
        diesel(i) = diesel(i) + distances(i) * 0.1;
        electrical(i) = electrical(i) + distances(i) * 0.1;
    end
end

%The Area C is also taken into account even if the time dependency is here 
%ignored: it is reasonable to suppose that the GPS system will be used
%during the day, so a fixed cost of 5€ was applied to the arcs entering
%into Area C.

for i = 1:n_arcs
        if graph(i,6) == 8
            gasoline(i) = gasoline(i) + 5;
            diesel(i) = diesel(i) + 5;
            electrical(i) = electrical(i) + 5;
        end
end

%Now we are generating data for the risks. First we consider a default risk
%value equal to 0.5 km^-1 for both cathegories:
%1 - No risk transport: coefficient equal to 1
%2 - Risk transport: coefficient equal to 2

risk = 0.5 * distances;

RISK1 = risk;
RISK2 = 2*risk;

%Now the generated data are collected into different .txt documents so that
%they can be used in a second moment.

dlmwrite('H1_MOTORBIKE.txt',motorbike_timetable);
dlmwrite('H2_CAR.txt',motorbike_timetable);
dlmwrite('H3_TRUCK.txt',motorbike_timetable);

dlmwrite('K1_GASOLINE.txt', gasoline);
dlmwrite('K2_DIESEL.txt', diesel);
dlmwrite('K3_ELECTRICAL.txt', electrical);

dlmwrite('S1.txt', RISK1);
dlmwrite('S2.txt', RISK2);