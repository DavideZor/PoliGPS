%The function find_node_index finds the row index where it is possible to
%find a particulare node ID among all the nodes IDs listed in the ID_nodes
%vector.
%
%-------------------------------------------------------------------------
%Input arguments:
%ID_node      [1x1]     ID of the interested node                  [-]
%ID_nodes     [nx1]     List of all the node IDs                   [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%j            [1x1]     Index of the node row in ID_nodes          [-]

function j = find_node_index(ID_node, ID_nodes)

if size(ID_node,2) ~= 1 || size(ID_nodes,2) ~= 1
    error('The input sizes are not adequate');
end

j = find_first_index(ID_node == ID_nodes);

end