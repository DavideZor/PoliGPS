%The select_path function is a function that starting from a list of
%predecessors return the corresponding ordered path from the origin to the
%destination.
%
%-------------------------------------------------------------------------
%Input arguments:
%d            [1x1]     ID of the destination                      [-]
%pred         [Nx1]     List of each node predecessors             [-]
%ID_nodes     [Nx1]     Vector with nodes IDs                      [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%path         [px1]     Vector of ordered nodes                    [-]

function path = select_path(d, pred, ID_nodes)

path = zeros(length(ID_nodes),1);

i = find_node_index(d, ID_nodes);
j = 1;

while pred(i) ~= 0
    path(j) = pred(i);
    i = find_node_index(path(j), ID_nodes);
    j = j + 1;
end

path = flip_vector(path);
path = [path; d];

q = find_first_index(path);
path = path(q:end);

end

