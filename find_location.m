%The find_location function takes a nodes matrix structured as 
%[ID_nodes, X, Y], where X and Y are the nodes coordinates, a vector 
%that contains all the interested ID_nodes and it gives back a matrix with 
%the Carthesian coordinates of such nodes.
%
%-------------------------------------------------------------------------
%Input arguments:
%nodes        [Nx3]     Matrix with nodes IDs and coordinates      [m]
%ID_nodes     [mx1]     List of the interested nodes               [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%XY           [mx2]     Coordinates of the interested nodes        [m]

function XY = find_location(nodes, ID_nodes)

[n, m] = size(nodes);
[p, q] = size(ID_nodes);

if q ~= 1
    error('The list of nodes is not a (column) vector');
elseif m ~= 3
    error('The list of nodes must be a nx3 matrix');
end

XY = zeros(p, 2);

for i = 1:p 
    for j = 1:n
        if nodes(j,1) == ID_nodes(i)
            XY(i,1) = nodes(j,2);
            XY(i,2) = nodes(j,3);
        end
    end
end
end
