%The delete_same_arcs function is a function that takes as input a double-
%column matrix A with all the arcs as rows and deletes all the duplets that
%actually refers to the same arc. It is very useful when the graph is
%randomly generated and it may happen that two or more couples repeat 
%themselves.
%
%-------------------------------------------------------------------------
%Input arguments:
%A            [nx2]     Arcs matrix                                [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%B            [mx2]     Matrix with all repeated arcs deleted      [-]


function B = delete_same_arcs(A)

[n,m] = size(A);

if m ~= 2
    error('The arcs matrix must be a double-column matrix (nx2)');
end

B = A;

for i = 1:n
    if A(i,1) == A(i,2)
        B(i,1) = 0;
        B(i,2) = 0;
    end
    for j = 1:n
        if j ~= i && all(A(i,:) == A(j,:))
            B(i,1) = 0;
            B(i,2) = 0;
        end
    end
end

B = delete_null_rows(B);

end
        