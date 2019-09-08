%The function generalized_costs simply evaluates the generalized costs for
%each arc, given the weight each criterion is characterized from, the
%mono-criterion costs and the normalization constants.
%
%-------------------------------------------------------------------------
%Input arguments:
%lambda       [1x3]     Row vector of weights                      [-]
%t            [Ax1]     Column vector of time costs                [s]
%T            [1x1]     Normalization constant for the time        [s]
%c            [Ax1]     Column vector of costs                     [€]
%G            [1x1]     Normalization constant for the costs       [€]
%r            [Ax1]     Column vector of risks                     [-]
%R            [1x1]     Normalization constant for the risks       [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%C            [Ax1]     Generalized costs for each arc             [-]

function C = generalized_costs(lambda, t, T, c, G, r, R)

C = lambda(1)*t/T + lambda(2)*c/G + lambda(3)*r/R;

end