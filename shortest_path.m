%The function shortest_path implements the Dijkstra's algorithm in its
%original form (without any heuristic). The algorithm returns the list of
%nodes costs and the predecessors list.
%
%-------------------------------------------------------------------------
%Input arguments:
%ID_nodes     [Nx1]     Vector with nodes IDs                      [-]
%arcs         [Ax2]     Matrix with the list of arcs               [-]
%costs        [Ax1]     Column vector of costs                     [-]
%o            [1x1]     ID of the origin                           [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%L            [Nx1]     List of costs                              [-]
%pred         [Nx1]     List of each node predecessors             [-]

function [L, pred] = shortest_path(ID_nodes, arcs, costs, o)

if any(costs < 0)
    error('Dijkstra algorithm cannot be appliet to negative costs network');
end

n = length(ID_nodes);
S = o;
L = zeros(n,1); %Node costs vector
pred = zeros(n,1); %List of predecessors

while (length(S) ~= n)
    delta_plus = exiting_arcs(arcs, S);
    m = length(delta_plus(:,1));
    temp = zeros(m,1); %It contains the costs of all the exiting arcs
    for k = 1:m
        arc = delta_plus(k,:); %Row vector
        i = find_arc_index(arc, arcs);
        j = find_node_index(arc(1), ID_nodes);
        temp(k) = L(j) + costs(i);
    end
    z = find_first_index(temp == min(temp));
    selected_arc = delta_plus(z, :);
    selected_node = selected_arc(2);
    i = find_arc_index(selected_arc, arcs);
    j = find_node_index(selected_node, ID_nodes);
    q = find_node_index(selected_arc(1), ID_nodes);
    pred(j) = selected_arc(1);
    L(j) = L(q) + costs(i);
    S = [S; selected_node];
end

end