%The rho_estimation function allows to determine the potential of each node
%according to the A* algorithm proposed by Hart in 1969.
%
%-------------------------------------------------------------------------
%Input arguments:
%d            [1x1]     ID of the destination                      [-] 
%nodes        [Nx1]     Matrix with nodes IDs and coordinates      [m]
%delta        [1x1]     Delta factor                               [km]
%
%--------------------------------------------------------------------------
%Output arguments:
%rho_u        [Nx1]     Nodes potential vector                     [-]

function rho_u = rho_estimation(d, nodes, delta)

ID_nodes = nodes(:,1);
n = length(ID_nodes);

i = find_node_index(d, ID_nodes);

X_d = nodes(i,2); Y_d = nodes(i,3);

rho_u = zeros(n,1);

for u = 1:n
    X_u = nodes(u,2); Y_u = nodes(u,3);
    rho_u(u) = norm([X_d - X_u, Y_d - Y_u]) / delta;
end

end