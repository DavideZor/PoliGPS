%The delete_null_rows function is a function that takes as input a matrix
%of any dimension and it returns the same matrix without the rows where all
%the elements were equal to zero. If there are no null rows in the input
%matrix the algorithm returns the same matrix without any modification.
%
%-------------------------------------------------------------------------
%Input arguments:
%N            [nxm]     Generic nxm matrix                         [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%M            [pxq]     Matrix with all zero rows deleted          [-]

function M = delete_null_rows(N)

[n, m] = size(N);
M = zeros(n,m);
nullrow = ones(n,1);

for i = 1:n
    for j = 1:m
        if N(i,j) ~= 0
            nullrow(i) = 0;
        end
    end
end

zerorows = sum(nullrow);
nonzerorows = n - zerorows;
k = 1;

for i = 1:n
    if nullrow(i) == 0
        M(k,:) = N(i,:);
        k = k + 1;
    end
end

M = M(1:nonzerorows,:);

end