%The function generalized_potential simply evaluates the generalized
%potential for each node, given the weight each criterion is characterized 
%from, the mono-criterion potentials and the normalization constants.
%
%-------------------------------------------------------------------------
%Input arguments:
%lambda       [1x3]     Row vector of weights                      [-]
%rho_t        [Nx1]     Column vector of time costs                [-]
%T            [1x1]     Normalization constant for the time        [s]
%rho_c        [Nx1]     Column vector of costs                     [-]
%G            [1x1]     Normalization constant for the costs       [€]
%rho_r        [Nx1]     Column vector of risks                     [-]
%R            [1x1]     Normalization constant for the risks       [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%rho          [Nx1]     Generalized potential for each node        [-]

function rho = generalized_potential(lambda, rho_t, T, rho_c, G, rho_r, R)

rho = lambda(1)*rho_t/T + lambda(2)*rho_c/G + lambda(3)*rho_r/R;

end