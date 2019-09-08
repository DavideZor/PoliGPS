%The function select_data just loads the necessary data for the GPS Tracker
%experimental campaign, starting from the vehicle type.
%
%-------------------------------------------------------------------------
%Input arguments:
%vehicle      [1x3]     Triplet that refers to the vehicle type    [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%t            [Ax1]     Column vector of time costs                [s]
%c            [Ax1]     Column vector of costs                     [€]
%r            [Ax1]     Column vector of risks                     [-]

function [t, c, r] = select_data(vehicle)

if vehicle(1) == 1
    t = load('H1_MOTORBIKE.txt');
elseif vehicle(1) == 2
    t = load('H2_CAR.txt');
elseif vehicle(1) == 3
    t = load('H3_TRUCK.txt');
end

if vehicle(2) == 1
    c = load('K1_GASOLINE.txt');
elseif vehicle(2) == 2
    c = load('K2_DIESEL.txt');
elseif vehicle(2) == 3
    c = load('K3_ELECTRICAL.txt');
end

if vehicle(3) == 1
    r = load('S1.txt');
elseif vehicle(3) == 2
    r = load('S2.txt');
end

end