%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POLI GPS MAIN %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all; clc;

%This script encases all the experimental campaigns developed in the 
%project report. Here, it is possible to study and analyse all the results 
%obtained and understand how all the functions are used for the saim goal.

%Here it is possible to choose the experimental campaign to solve:
%1 - GPS Tracker
%2 - Space Based Internet
%3 - Aeroplane Routes

experimental_campaign = 3;

%Here it is possible to choose the size_instance for the random origin and
%destination generation, applied to the first experimental campaign only
%(the other two have two different ways of random route generation).
%The size can be:
%1 - Small
%2 - Medium
%3 - Large

size_instance = ceil(3 * rand(1,1)); 

%In the following command it is possible to choose the method to obtain the
%normalization constants. The methods are:
%1 - NCM1
%2 - NCM2
%3 - NCM3
%Pay attention: if one chooses NCM = 2, they would need to change the 
%limits of each size (small, medium, large) in order to make the algorithm 
%properly work for experimental campaigns 2 and 3 (because the distances 
%involved are different). All of them properly work with NCM1 and NCM3.

NCM = 3;
random_instances = 12;

if experimental_campaign == 1
    GPSDataLoading
    t = t/60/60; %[h]
    OD = random_OD(nodes, size_instance, 2);
    o = OD(1,1); X_o = OD(1,2); Y_o = OD(1,3);
    d = OD(2,1); X_d = OD(2,2); Y_d = OD(2,3);
    lambda1 = 0.5; lambda2 = 0.5; lambda3 = 0; %Weights choice
    marker = 0.005;
elseif experimental_campaign == 2
    SBIDataLoading
    ido = ceil(size(nodes,1)*rand(1,1));
    idd = ceil(size(nodes,1)*rand(1,1));
    while idd - ido == 0
        idd = ceil(size(nodes,1)*rand(1,1));
    end
    o = nodes(ido,1); X_o = nodes(ido,2); Y_o = nodes(ido,3);
    d = nodes(idd,1); X_d = nodes(idd,2); Y_d = nodes(idd,3);
    lambda1 = 1/3; lambda2 = 1/3; lambda3 = 1/3; %Weights choice
    marker = 0.005;
elseif experimental_campaign == 3
    AiRouteDataLoading
    o = ceil(ny/2) * nx + 1; X_o = X(o); Y_o = Y(o);
    d = ceil(ny/2) * nx + nx; X_d = X(d); Y_d = Y(d);
    lambda1 = 1/3; lambda2 = 1/6; lambda3 = 1/2; %Weights choice
    marker = 0;
end

%Now that all the data are selected, the algorithm starts compiling and
%presents the final results.

lambda = [lambda1, lambda2, lambda3];

if NCM == 2
    [T, G, R] = NCM2(nodes, arcs, distances, t, c, r, turns, size_instance, random_instances);
end
    
tic

if NCM == 1
    [T, G, R] = NCM1(o, d, distances, nodes, arcs, t, c, r, turns);
elseif NCM == 3
    T = max(t);
	G = max(c);
	R = max(r);
end

C = generalized_costs(lambda, t, T, c, G, r, R);
delta = delta_estimation(distances, C); %km/h
rho_u = rho_estimation(d, nodes, delta);
rho_u_wrt_arc = nodes_potential(arcs, ID_nodes, rho_u);

path = PoliGPS(o, d, arcs, C, rho_u_wrt_arc, turns);

toc 

z = length(path);
X_p = zeros(z,1);
Y_p = zeros(z,1);

for i = 1:z
    k = find_node_index(path(i),ID_nodes);
    X_p(i) = nodes(k,2);
    Y_p(i) = nodes(k,3);
end

figure()
plot(X/1e3, Y/1e3, 'm.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', marker, 'Color', 'k');
hold on;
plot(X_o/1e3, Y_o/1e3, 'r.', 'MarkerSize', 25);
hold on;
plot(X_d/1e3, Y_d/1e3, 'g.', 'MarkerSize', 25);
hold on;
plot(X_p/1e3, Y_p/1e3, 'c-', 'LineWidth', 2.5);

if experimental_campaign == 1
    xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
    title('Graph of the Milan Metropolitan Area (Comune di Milano 2008)');
elseif experimental_campaign == 2
    xlabel('X [km]'), ylabel('Y [km]');
    title('Projected graph of the satellites network (SBI)');
elseif experimental_campaign == 3
    xlim([0,distance_M_NYC/1e3]), ylim([0,distancey/1e3]);
    xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
    title('Grid of the different nodes');
end