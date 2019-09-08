%The compress_arcs function is a function that takes as input a vector v, 
%a double-column matrix V that describes a set of arcs and it returns a
%vector w and a double-column matrix W where all the rows where v was equal
%to zero or the arriving node of an arc is equal to v are eliminated. 
%This function is extremely useful for eliminating nonsense predecessors
%and arcs during the shortest path evaluation.
%
%-------------------------------------------------------------------------
%Input arguments:
%v            [nx1]     Vector of arc predecessors                 [-]
%W            [mx2]     Arc matrix                                 [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%w            [px1]     Compressed vector of arc predecessors      [-]
%W            [qx2]     Compressed arc matrix                      [-]

function [w, W] = compress_arcs(v, V)

[n,m] = size(v);
[r,s] = size(V);

if n ~= r
    error('The vector and the matrix dimensions are not compatible');
elseif m ~= 1
    error('The first input argument must be a (column) vector');
elseif s ~= 2
    error('The arc matrix must be a double-column matrix');
end

for i = 1:n
    if v(i,1) == 0 || v(i,1) == V(i,2)
        v(i,1) = 0;
        V(i,1) = 0;
        V(i,2) = 0;
    end
end

w = delete_null_rows(v);
W = delete_null_rows(V);

end