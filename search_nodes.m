%The search_nodes function lists all the nodes present in a given region
%described by two intervals (in the X and Y coordinates).
%
%-------------------------------------------------------------------------
%Input arguments:
%X_interval   [1x2]     Interval on the X axis                     [m]
%Y_interval   [1x2]     Interval on the Y axis                     [m]
%nodes        [Nx3]     Matrix with nodes IDs and coordinates      [m]
%
%--------------------------------------------------------------------------
%Output arguments:
%test         [1x1]     Logical value                              [-]
%list_of_nodes[px1]     List of the nodes in the region            [m]

function [test, list_of_nodes] = search_nodes(X_interval, Y_interval, nodes)

n = size(nodes,1);

ID_nodes = nodes(:,1);
X = nodes(:,2);
Y = nodes(:,3);

test = 0;
list_of_nodes = zeros(n, 3);

for i = 1:n
    if X(i) >= X_interval(1) && X(i) <= X_interval(2) && ...
            Y(i) >= Y_interval(1) && Y(i) <= Y_interval(2)
        list_of_nodes(i,1) = ID_nodes(i);
        list_of_nodes(i,2) = X(i);
        list_of_nodes(i,3) = Y(i);
        test = 1;
    end
end

list_of_nodes = delete_null_rows(list_of_nodes);

end
        
    
