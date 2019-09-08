%The function evaluate_distances evaluates the Euclidean distance among all
%the couples of nodes within an arcs structure. The algorithm is extremely
%inefficient since its complexity is of the order of O(AxAxA) as there
%are three nested for loops over the number of arcs A. However, it is
%necessary for graphs that are not previously ordered and the nodes names
%do not correspond with the row.
%
%-------------------------------------------------------------------------
%Input arguments:
%arcs         [Ax2]     Matrix with all the arcs                   [-]
%nodes        [Nx3]     Set of nodes                               [m]
%
%--------------------------------------------------------------------------
%Output arguments:
%distances    [Ax1]     Vector with the Euclidean distances        [m]

function distances = evaluate_distances(arcs, nodes)

n = size(arcs,1);
ID_nodes = nodes(:,1);

distances = zeros(n,1);

for i = 1:n
    a = find_node_index(arcs(i,1),ID_nodes);
    b = find_node_index(arcs(i,2),ID_nodes);
    X_a = nodes(a,2); Y_a = nodes(a,3);
    X_b = nodes(b,2); Y_b = nodes(b,3);
    distances(i) = norm([X_a-X_b, Y_a-Y_b]);
end

end