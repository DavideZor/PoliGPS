%The NCM2 function is a function that evaluates the normalization constants
%needed for the generalized costs through the NCM2 method.
%
%-------------------------------------------------------------------------
%Input arguments:
%nodes        [Nx1]     Matrix with nodes IDs and coordinates      [m]
%arcs         [Ax1]     Matrix with the list of arcs               [-]
%distances    [Ax1]     List of arcs lengths                       [km]
%t            [Ax1]     Column vector of time costs                [s]
%c            [Ax1]     Column vector of costs                     [€]
%r            [Ax1]     Column vector of risks                     [-]
%turns        [Fx3]     List of forbidden turns (p,q,r)            [-]
%Size         [1x1]     Size of the instances region               [-]
%n            [1x1]     Number of total instances                  [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%T            [Sx1]     Normalization constants for the time       [s]
%G            [Sx1]     Normalization constants for the costs      [€]
%R            [Sx1]     Normalization constants for the risks      [-]

function [T, G, R] = NCM2(nodes, arcs, distances, t, c, r, turns, Size, n)

m = round(n/3);

Tv = zeros(m,1);
Gv = zeros(m,1);
Rv = zeros(m,1);

for i = 1:m
    OD = random_OD(nodes, Size, 2);
    o = OD(1,1); d = OD(2,1);
    [Tv(i), Gv(i), Rv(i)] = NCM1(o, d, distances, nodes, arcs, t, c, r, turns);
end

T = max(Tv);
G = max(Gv);
R = max(Rv);

end