%The entering_arcs function lists all the arcs entering (that is pointing)
%into a set of nodes, named ID_nodes, within an arcs matrix.
%
%-------------------------------------------------------------------------
%Input arguments:
%arcs         [nx2]     Matrix with all the arcs                   [-]
%ID_nodes     [nx1]     Set of nodes                               [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%delta_minus  [mx1]     Set of all the entering arcs               [-]

function delta_minus = entering_arcs(arcs, ID_nodes)

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
        if arcs(i,2) == ID_nodes(j) && all(ID_nodes ~= arcs(i,1))
            A(i,j) = arcs(i,1);
        end
    end
end

delta_minus = zeros(sum(sum(A ~= 0)),2);

k = 1;

for j = 1:p
    for i = 1:n
        if A(i,j) ~= 0
            delta_minus(k,1) = A(i,j);
            delta_minus(k,2) = ID_nodes(j);
            k = k + 1;
        end
    end
end
end