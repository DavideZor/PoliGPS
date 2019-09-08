%The entering_arcs function lists all the arcs exiting (that is emanating)
%from a set of nodes, named ID_nodes, within an arcs matrix.
%
%-------------------------------------------------------------------------
%Input arguments:
%arcs         [nx2]     Matrix with all the arcs                   [-]
%ID_nodes     [nx1]     Set of nodes                               [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%delta_plus  [mx1]     Set of all the exiting arcs                 [-]

function delta_plus = exiting_arcs(arcs, ID_nodes)

[n,m] = size(arcs);
[p,q] = size(ID_nodes);

if m ~= 2
    error('The arc matrix must be a double-column matrix');
elseif q ~= 1
    error('The list of nodes must be a (column) vector');
end

A = zeros(n, p);

for j = 1:p
    for i = 1:n
        if arcs(i,1) == ID_nodes(j) && all(ID_nodes ~= arcs(i,2)) %Exclude the arcs inside the set S
            A(i,j) = arcs(i,2);
        end
    end
end

delta_plus = zeros(sum(sum(A ~= 0)),2);

k = 1;

for j = 1:p
    for i = 1:n
        if A(i,j) ~= 0
            delta_plus(k,1) = ID_nodes(j);
            delta_plus(k,2) = A(i,j);
            k = k + 1;
        end
    end
end

end