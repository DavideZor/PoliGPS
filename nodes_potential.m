%The function nodes_potential simply transforms the already evaluated
%generalized nodes potentials in a matrix of generalized nodes potentials
%compatible with the arcs matrix: it means that for each arc there is an
%associated node potential to the arc head.
%
%-------------------------------------------------------------------------
%Input arguments:
%arcs         [Ax1]     Matrix with the list of arcs               [-]
%ID_nodes     [Nx1]     List of nodes IDs                          [-]
%rho_u        [Nx1]     Generalized potential of each node         [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%v            [Ax1]     Generalized potential for each node        [-]

function v = nodes_potential(arcs, ID_nodes, rho_u)

if size(ID_nodes,2) ~= 1
    error('The list of nodes should be a vector');
end

n = size(arcs,1);

v = zeros(n,1);

for i = 1:n
    node = arcs(i,2);
    k = find_node_index(node,ID_nodes);
    v(i) = rho_u(k);
end

end
    