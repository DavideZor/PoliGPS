%The NCM1 function is a function that evaluates the normalization constants
%needed for the generalized costs through the NCM1 method.
%
%-------------------------------------------------------------------------
%Input arguments:
%o            [1x1]     ID of the origin                           [-]
%d            [1x1]     ID of the destination                      [-]
%distances    [Ax1]     List of arcs lengths                       [km]
%nodes        [Nx1]     Matrix with nodes IDs and coordinates      [m]
%arcs         [Ax2]     Matrix with the list of arcs               [-]
%t            [Ax1]     Column vector of time costs                [s]
%c            [Ax1]     Column vector of costs                     [€]
%r            [Ax1]     Column vector of risks                     [-]
%turns        [Fx3]     List of forbidden turns (p,q,r)            [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%T            [1x1]     Normalization constant for the time        [s]
%G            [1x1]     Normalization constant for the costs       [€]
%R            [1x1]     Normalization constant for the risks       [-]

function [T, G, R] = NCM1(o, d, distances, nodes, arcs, t, c, r, turns)

A = [t,c,r];
H = zeros(3,3);
ID_nodes = nodes(:,1);

for i = 1:3
    delta = delta_estimation(distances, A(:,i));
    rho_u = rho_estimation(d, nodes, delta);
    rho_u_wrt_arc = nodes_potential(arcs, ID_nodes, rho_u);
    path = PoliGPS(o, d, arcs, A(:,i), rho_u_wrt_arc, turns);
    H(i,1) = path_cost_calculator(path, arcs, t);
    H(i,2) = path_cost_calculator(path, arcs, c);
    H(i,3) = path_cost_calculator(path, arcs, r);
end

T = max(H(:,1));
G = max(H(:,2));
R = max(H(:,3));

end