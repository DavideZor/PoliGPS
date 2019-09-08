%The random_OD function generates an origin and a destination within a
%given size. The size can be small (1), medium (2) or large (3) and it is
%also possible to choose a mode in order to generate data randomly
%according to a uniform disribution (mode = 1, origin and destination 
%probably near the edges) or to a Gaussian distribution (mode = 2, origin
%and destionation probably near the centre).
%
%-------------------------------------------------------------------------
%Input arguments:
%nodes        [Nx1]     Matrix with nodes IDs and coordinates      [m]
%Size         [1x1]     Instances size                             [-]
%mode         [1x1]     Random generation mode                     [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%OD           [2x3]     Couple of Origin and Destination           [-]


function OD = random_OD(nodes, Size, mode)

s_min = 0; %m
s_max = 5*1e3; %m
m_min = 5*1e3; %m
m_max = 15*1e3; %m
l_min = 15*1e3; %m
l_max = 30*1e3; %m

X = nodes(:,2);
Y = nodes(:,3);

minX = min(X); maxX = max(X); mX = mean(X);
minY = min(Y); maxY = max(Y); mY = mean(Y);

d = 1000; %1 km from the exact centre 

%Origin generation

if mode == 1 %Completely random distribution (more likely to happen on the edge)
    X_O = minX + round((maxX - minX) * rand(1,1));
    Y_O = minY + round((maxY - minY) * rand(1,1));
elseif mode == 2 %Gaussian distribution (more likely to happen in the centre)
    X_O = maxX + 1; Y_O = maxY + 1;
    while X_O > maxX || Y_O > maxY
        X_O = mX + d * randn(1,1);
        Y_O = mY + d * randn(1,1);
    end
end

O = find_nearest_node([X_O, Y_O], nodes);

if Size == 1
    radius = s_max - s_min;
elseif Size == 2
    radius = m_max - m_min;
elseif Size == 3
    radius = l_max - l_min;
end

angle = 2 * pi * rand(1,1);

X_D = 1 + maxX; %To enter the while cycle
Y_D = 1 + maxY;
D = [0,0,0];

while X_D > maxX || Y_D > maxY || D(1,1) == O(1,1)
    X_D = X_O + ceil(round(radius * cos(angle)));
    Y_D = Y_O + ceil(round(radius * sin(angle)));
    D = find_nearest_node([X_D, Y_D], nodes);
end 

OD = [O; D];

end