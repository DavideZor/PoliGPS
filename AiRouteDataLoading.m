%%%%%%%%%%%%%%%%%%%% Airplane Route Data Loading %%%%%%%%%%%%%%%%%%%%%%%%%%

%Define the distance between the origin and the destination. In the
%experimental campaign it was supposed that the origin was Milan and the
%destination was given by New York City, so the distance is:

distance_M_NYC = 6460 * 1e3; %[m]

%A suitable number of nodes is chosen, such as for example N = 1e5 since it 
%would mean that in a grid 1000x100 every 6.46km a wind or temperature
%change is considered (which is reasonable). However since the PoliGPS
%function is not optimized for this data structure, the nodes number choice
%is much lower (N = 1e3 and N = 1e2)

N = 1e2;

nx = 1e1;
ny = N/nx;

%The distance versus y is chosen as 5000m if the y is interpreted as the
%maximum deviation from the mean path the aircraft can pursue. In this 
%case, the origin is considered to be in the middle of the Y axis and the 
%destination on the same line but at X = distance_M_NYC;
%Otherwise, it is also possible to interpret the y axis as the height
%at which the aircraft can fly. In this case, the distance versus y is 
%chosen as 15'000m and it seems reasonable as the average height a 
%commercial aircraft flies is 10'000m - 12'000m. In this case, 
%the origin will be chosen as the origin of the Carthesian axes 
%and the destination as the point (distance_M_NYC, 0). However this
%latter case is not taken into account since wind is not likely to change
%its direction along the height, whilst the following data take into
%account a possible wind direction change.

distancex = distance_M_NYC;
distancey = 5000; %[m]

%A grid is made in order to define the arcs in between. Only the directions
%towards the right are considered possible (the airplane can't go back).

[nodes, arcs] = make_grid(distancex, distancey, nx, ny);

%Let's now define the costs of each arc. The time is directly proportional
%to the distances which are calculated as Euclidean distances between the
%nodes. The proportional constant is v = M * c where M = 0.78 is the
%average Mach number for commercial aircrafts, c is the speed of sound
%calculated for a polytropic ideal gas with temperature T = 223.15K (ISA)
%and v is the average aircraft velocity.

M = 0.78; T = 223.15; v = sqrt(1.4 * 287 * T);

%In order to evaluate distances, it is possible to use the
%evaluate_distances function, but it is extremely inefficient for big
%ordered graphs (that is graphs with nodes of which number goes from 1 to
%the number of nodes). In fact, with non-ordered graphs (such as the graph
%of the Milan Metropolitan Area) the algorithm needs to look for the nodes
%indices implying three loops on A (number of arcs) that mean a AxAxA = A^3
%complexity algorithm. This problem can be solved by ordering once the data
%and then using always the evaluate_ordered_distances algorithm.

distances = evaluate_ordered_distances(arcs, nodes);

t = distances/v;

A = size(arcs,1);

%As the second criterion, the average temperature of each arc is taken.
%Since the temperature changes according to the ISA model from 0°C to
%-56.5° (20'000m) the temperature is choosen randomly from a Gaussian 
%distribution of mean 223.15K (which is the cruise altitude)

st_dev = 5;
c = T + st_dev * randn(A,1);

%As the last criterion, the wind velocity is taken into account which can
%vary in average from -15m/s (tailwind, favourable) to +15m/s (headwind). 
%Since the Dijkstra's algorithm cannot take into account negative costs,
%the minimum is added to the random vector generated in order to respect 
%the cost algebra structure.

v_max = 15;

r = - 2 * v_max + ceil(v_max * rand(A,1));
r = r + abs(min(r));

%There are no forbidden turns so the turns matrix is defined as follows:

turns = [0,0,0];

%For compatibility reasons with the PoliGPSMain script the following
%variables are defined:

ID_nodes = nodes(:,1);

X = nodes(:,2);
Y = nodes(:,3);

A_n = arcs(:,1); %ID of the beginning node of an arc
B_n = arcs(:,2); %ID of the ending node of the arc

%For the same reasons that led to use the ordered version of the evaluation
%distances algorithm, here the find_location function is not used, but the
%fact that the nodes are ordered from 1 to N is exploited.

XY_A = zeros(A,2);
XY_B = zeros(A,2);

for i = 1:A
    XY_A(i,1) = nodes(A_n(i,1),2); XY_A(i,2) = nodes(A_n(i,1),3);
    XY_B(i,1) = nodes(B_n(i,1),2); XY_B(i,2) = nodes(B_n(i,1),3);
end

return

figure()
plot(X/1e3, Y/1e3, 'm.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0, 'Color', 'k');