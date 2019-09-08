%The find_arc_index function gives the first row index where the input arc
%v (a duplet) is equal to one arc of the W arcs matrix.
%
%-------------------------------------------------------------------------
%Input arguments:
%v            [1x2]     Duplet describing an arc                   [-]
%W            [Ax2]     Matrix of arcs                             [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%i            [1x1]     First row index                            [-]

function i = find_arc_index(v, W)

if size(v,1) ~= 1 || size(v,2) ~= 2
    error('The input vector v is not a 1x2 vector describing an arc');
elseif size(W,2) ~= 2
    error('The arc matrix must be a double-column matrix');
end

i = 0; %There could be no index

a = find_node_index(v(1), W(:,1));
b = find_node_index(v(2), W(:,2));

if a ~= b
    m = min([a,b]);
    for k = 1:m
        W(k,1) = v(1) + v(2) + 1;
        W(k,2) = v(2) + v(2) + 1;
    end 
    i = find_arc_index(v, W);
else
    i = a;
end

end