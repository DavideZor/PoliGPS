%%%%%%%%%%%%%%%%%%%%%%%%% GPS Data Loading %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This script prepares the necessary data for the GPS Tracking experimental
%campaign.

%First of all, a graph downloaded from the Comune di Milano website (2008)
%aims to describe the Milan Metropolitan Area.

nodes = load('NODES.txt'); %Position of the graph nodes
graph = load('GRAPH.txt'); %Arcs and graph properties
turns = load('TURNS.txt'); %Not allowed turns

%A vehicle is chosen and the related data are immediately loaded.

vehicle = [2, 1, 1];

[t, c, r] = select_data(vehicle);

ID_nodes = nodes(:,1);
X = nodes(:, 2);
Y = nodes(:, 3);
x_min = min(X); x_max = max(X);
y_min = min(Y); y_max = max(Y);

A_n = graph(:, 2); %ID of the beginning node of an arc
B_n = graph(:, 3); %ID of the ending node of the arc
arcs = [graph(:,2), graph(:,3)];
distances = graph(:,4);

P = turns(:,1);
Q = turns(:,2);
R = turns(:,3);

XY_A = find_location(nodes, A_n);
XY_B = find_location(nodes, B_n);

XY_P = find_location(nodes, P);
XY_Q = find_location(nodes, Q);
XY_R = find_location(nodes, R);

return

%This part of the script is not relevant for the PoliGPSMain, but it is
%here in order to study the correctness and efficiency of the data loaded
%so far.

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Nodes of the Milan Metropolitan Area (Comune di Milano 2008)');

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'b');
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Graph of the Milan Metropolitan Area (Comune di Milano 2008)');

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'b');
hold on;
quiver(XY_P(:,1)/1e3, XY_P(:,2)/1e3, (XY_Q(:,1)-XY_P(:,1))/1e3, ...
    (XY_Q(:,2)-XY_P(:,2))/1e3, 0, 'MaxHeadSize', 0, 'Color', 'm');
hold on;
quiver(XY_Q(:,1)/1e3, XY_Q(:,2)/1e3, (XY_R(:,1)-XY_Q(:,1))/1e3, ...
    (XY_R(:,2)-XY_Q(:,2))/1e3, 0, 'MaxHeadSize', 0, 'Color', 'm');
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Forbidden turns in the Milan Metropolitan Area (Comune di Milano 2008)');