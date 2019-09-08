%The function path_cost_calculator is a function that evaluates the cost of
%a path by simply summing the costs of the arcs the path is made of.
%
%-------------------------------------------------------------------------
%Input arguments:
%path         [px1]     Succession of nodes the path is made of    [-]
%arcs         [Ax1]     Matrix with the list of arcs               [-]
%costs        [Ax1]     Column vector of costs                     [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%cost         [1x1]     Total cost of the path                     [-]

function cost = path_cost_calculator(path, arcs, costs)

n = length(path);
cost = 0;

for i = 1:n-1
    a = path(i);
    b = path(i+1);
    arc = [a, b];
    j = find_arc_index(arc, arcs);
    cost = cost + costs(j);
end

end
    