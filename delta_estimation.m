%The delta_estimation function simply estimates the delta factor taking as
%inputs the distances and the generalized costs previously evaluated.
%
%-------------------------------------------------------------------------
%Input arguments:
%distances    [nx1]     Distances among arcs vector                [km]
%g_costs      [nx1]     Generalized costs vector                   [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%delta        [1x1]     Delta factor                               [km]

function delta = delta_estimation(distances, g_costs)

delta = max(max(distances./g_costs));

end