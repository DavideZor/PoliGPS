%The function evaluate_ordered_distances evaluates the Euclidean distance 
%among all the couples of nodes within an arcs structure. The nodes must be
%ordered from 1 to the number of nodes (N). The algorithm is extremely
%efficient since its complexity is of the order of O(A) as there
%is only one for loop over the number of arcs A. However, it is
%necessary for graphs to be previously ordered.
%
%-------------------------------------------------------------------------
%Input arguments:
%arcs         [Ax2]     Matrix with all the arcs                   [-]
%nodes        [Nx3]     Set of nodes                               [m]
%
%--------------------------------------------------------------------------
%Output arguments:
%distances    [Ax1]     Vector with the Euclidean distances        [m]

function distances = evaluate_ordered_distances(arcs, nodes)

[n, m] = size(arcs);
[~, q] = size(nodes);

if m ~= 2
    error('The arc matrix must be a double-column matrix');
elseif q ~= 3
    error('The list of nodes must be a nx3 matrix');
end

distances = zeros(n,1);

for i = 1:n
    a = arcs(i,1);
    b = arcs(i,2);
    X_a = nodes(a,2); Y_a = nodes(a,3);
    X_b = nodes(b,2); Y_b = nodes(b,3);
    distances(i) = norm([X_a-X_b, Y_a-Y_b]);
end

end