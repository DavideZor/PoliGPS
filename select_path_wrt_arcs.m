%The select_path_wrt_arcs function is a function that starting from a list 
%of arcs predecessors return the corresponding ordered path from the origin 
%to the destination.
%
%-------------------------------------------------------------------------
%Input arguments:
%o            [1x1]     ID of the origin                           [-]
%d            [1x1]     ID of the destination                      [-]
%arcs         [Ax2]     Matrix with the list of arcs               [-]
%pred         [Nx1]     List of each node predecessors             [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%path         [px1]     Vector of ordered nodes                    [-]

function path = select_path_wrt_arcs(o, d, arcs, pred)

last_node = d;
path = zeros(size(arcs,1),1);
k = 1;
path(1) = d;

[pred, arcs] = compress_arcs(pred, arcs);
delta_minus = entering_arcs(arcs,last_node);
plus_arc = [delta_minus(1,1), last_node];

while last_node ~= o
    j = find_arc_index(plus_arc,arcs);
    path(k+1) = plus_arc(1,1);
    path(k+2) = pred(j);
    last_node = pred(j);
    plus_arc = [last_node, plus_arc(1,1)];
    k = k + 1;
end

path = delete_null_rows(path);
path = flip_vector(path);

end
            