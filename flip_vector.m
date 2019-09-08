%The function flip_vector takes as input any vector v and it returns its
%reversed w. In formal terms: v(i) = w(n-i+1) for all i = 1,...,n.
%
%-------------------------------------------------------------------------
%Input arguments:
%v            [nx1]     Vector                                     [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%w            [nx1]     Reversed vector                            [-]

function w = flip_vector(v)

if size(v,1) ~= 1 && size(v,2) ~= 1
    error('The input is not a vector');
end

n = length(v);
w = v;

for i = 1:n
    w(i) = v(n-i+1);
end

end
    