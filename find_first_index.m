%The find_firs_index function gives the position of the first non-zero
%element of a vector v.
%
%-------------------------------------------------------------------------
%Input arguments:
%v            [nx2]     Vector                                     [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%i            [1x1]     First non-zero element position            [-]

function i = find_first_index(v)

[n,m] = size(v);

if n ~= 1 && m ~= 1
    error('The input is not a vector (one dimension should be 1)');
end
    
test = 0; %Truth test
k = 1; %Counter

while test == 0
    if v(k) ~= 0
        i = k;
        test = 1;
    end
    k = k + 1;
end

end