%The function make_grid generates a grid with dimensions 
%distancex x distancey and a total number of nodes equal to nx*ny, in 
%particular nx nodes are on the x axis and ny nodes are on the y axis.
%
%-------------------------------------------------------------------------
%Input arguments:
%distancex    [1x1]     Dimension along the x axis                 [m]
%distancey    [1x1]     Dimension along the y axis                 [m]
%nx           [1x1]     Number of nodes on the x axis              [-]
%ny           [1x1]     Number of nodes on the y axis              [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%nodes        [Nx1]     Matrix with nodes IDs and coordinates      [m]
%arcs         [Ax1]     Matrix with the list of arcs               [-]

function [nodes, arcs] = make_grid(distancex, distancey, nx, ny)

N = nx * ny;

dx = distancex/(nx-1);
dy = distancey/(ny-1);

hx = nx - 1;
hy = ny - 1;

X = zeros(N,1);
Y = zeros(N,1);

for j = 1:N
    X(j) = (j-1-nx*floor((j-1)/nx))*dx;
    Y(j) = floor((j-1)/nx)*dy;
end

ID_nodes = [1:N]';
nodes = [ID_nodes, X, Y];

arcs = zeros(5*N,2);

k = 1;

for j = 1:N
    a = j - nx*floor(j/nx);
    b = floor((j-1)/nx);
    if a ~= 0
        arcs(k,1) = nodes(j,1); arcs(k,2) = nodes(j+1,1);
    end
    if a ~= 0 && b ~= hy
        arcs(k+1,1) = nodes(j,1); arcs(k+1,2) = nodes(j+nx+1,1);
    end
    if b ~= hy
        arcs(k+2,1) = nodes(j,1); arcs(k+2,2) = nodes(j+nx,1);
    end
    if b ~= 0
        arcs(k+3,1) = nodes(j,1); arcs(k+3,2) = nodes(j-nx,1);
    end
    if a ~= 0 && b ~= 0
        arcs(k+4,1) = nodes(j,1); arcs(k+4,2) = nodes(j-nx+1,1);
    end
    k = k + 5;
end

arcs = delete_null_rows(arcs);

end