%The function set_intersection brings the concept of intersection between 
%two sets. For each set the elements of the set are defined row-wise, that 
%is each row is an element of the set (such as, for example, arcs). The
%algorithm returns the set intersection AiB.
%
%-------------------------------------------------------------------------
%Input arguments:
%A            [nxm]     Set A described through a matrix           [-]
%B            [nxm]     Set B described through a matrix           [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%test         [1x1]     Logical value                              [-]
%C            [pxq]     Set resulting from the intersection        [-]

function [test, C] = set_intersection(A,B)

[n,m] = size(A);
[o,p] = size(B);

if m ~= p
    printf('Error: the matrices are not compatible');
end

C = zeros(n,m);
test = 0;

for i = 1:n
    for j = 1:o
        if A(i,1) == B(j,1) && A(i,2) == B(j,2)
            C(i,1) = A(i,1);
            C(i,2) = A(i,2);
            test = 1;
        end
    end
end
        
end