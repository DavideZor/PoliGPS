%The function set_difference brings the concept of difference between two
%sets. For each set the elements of the set are defined row-wise, that is
%each row is an element of the set (such as, for example, arcs). The
%algorithm returns the set difference A\B.
%
%-------------------------------------------------------------------------
%Input arguments:
%A            [nxm]     Set A described through a matrix           [-]
%B            [nxm]     Set B described through a matrix           [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%C            [pxq]     Set resulting from the difference          [-]

function C = set_difference(A, B)

[n,m] = size(A);
[o,p] = size(B);

if m ~= p
    printf('Error: the matrices are not compatible');
end

C = A;

for i = 1:n
    for j = 1:o
        if A(i,1) == B(j,1) && A(i,2) == B(j,2)
            C(i,1) = 0;
            C(i,2) = 0;
        end
    end
end

end