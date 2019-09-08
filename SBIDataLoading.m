%%%%%%%%%%%%%%%%%%%%%%%%%% SBI Data Loading %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This script is needed in order to generate a feasible situation and
%topology of a satellite network for the Space Based Internet.

%First of all, the number of nodes is randomly chosen:

N = ceil(1e2 * rand(1,1));
ID_nodes = [1:N]';
X = zeros(N,1);
Y = zeros(N,1);

%As well as this, some false coordinates are randomly generated:

for i = 1:N
    X(i) = 1e6 * rand(1,1);
    Y(i) = 1e6 * rand(1,1);
end

nodes = [ID_nodes, X, Y];

%Again, a random number is assigned to the number of arcs, but it is bigger
%than the number of nodes (1e3 factor) since all the nodes of the graph
%should be reacheable.

A = ceil(1e3 * rand(1,1));
arcs = zeros(A,2);

for j = 1:A
    arcs(j,1) = ID_nodes(ceil(N*rand(1,1)));
    arcs(j,2) = ID_nodes(ceil(N*rand(1,1)));
end

arcs = delete_same_arcs(arcs);
A = size(arcs,1);

A_n = arcs(:, 1); %ID of the beginning node of an arc
B_n = arcs(:, 2); %ID of the ending node of the arc

XY_A = find_location(nodes, A_n);
XY_B = find_location(nodes, B_n);

distances = evaluate_distances(arcs, nodes);

c0 = 3e8; %Speed of light

t = distances/(c0/1e8);

c = zeros(A,1);
r = zeros(A,1);

for i = 1:A
    c(i) = ceil(10*rand(1,1));
    r(i) = ceil(3*rand(1,1));
end

%There are no forbidden turns so the turns matrix is defined as follows:

turns = [0,0,0];

%However, it could be meaningful to consider forbidden turns also for the
%SBI problem since some satellites may transfer data to one particular 
%satellite that cannot forward them to exactly every satellite of the
%network.

return

%This part of the script is not relevant for the PoliGPSMain, but it is
%here in order to study the correctness and efficiency of the data loaded
%so far.

figure()
plot(X/1e3, Y/1e3, 'm.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'k');