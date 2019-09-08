%The function PoliGPS is the main function of the whole project. Basically,
%it implies the Time dependent - A star - Forbidden Turns algorithm,
%proposed by Bruglieri et al. in 2014, in order to solve all the
%Multi-Objective Minimum Path Problems (MOMPPs).
%
%-------------------------------------------------------------------------
%Input arguments:
%o            [1x1]     ID of the origin                           [-]
%d            [1x1]     ID of the destination                      [-]
%arcs         [Ax3]     Matrix with the list of arcs               [-]
%g_costs      [Ax1]     Column vector of generalized costs         [-]
%rho_wrt_arc  [Ax1]     List of node potentials referred to arcs   [-]
%F            [Fx1]     List of forbidden turns (p,q,r)            [-]
%
%--------------------------------------------------------------------------
%Output arguments:
%path         [px1]     Path that minimizes the total cost         [-]

function path = PoliGPS(o, d, arcs, g_costs, rho_wrt_arc, F)

n = size(arcs,1);
m = size(F,1);

L = ones(n,1) * inf; 
pred = zeros(n,1); %Predecessor of the arc

delta_plus_o = exiting_arcs(arcs,o);
delta_minus_d = entering_arcs(arcs,d);

for i = 1:size(delta_plus_o,1)
    k = find_arc_index(delta_plus_o(i,:), arcs);
    L(k) = g_costs(k);
    pred(i) = o;
end

test = 0;

temp_old = L + rho_wrt_arc;
temp = temp_old;
indices_big = zeros(n,1);
indices_small = 0;

while test == 0
    temp_old = temp;
    temp = L + rho_wrt_arc;
    temp_no_U = temp;

    if any(indices_small) ~= 0
        for j = 1:length(indices_small)
            temp(indices_small(j)) = temp_old(indices_small(j));
            temp_no_U(indices_small(j)) = NaN;
        end
    end

    pq = find_first_index(temp_no_U == min(temp_no_U));
    p = arcs(pq,1);
    q = arcs(pq,2);
    U = [p,q];
    
    indices_big(pq) = pq; %Indices of permanently marked arcs
    indices_small = delete_null_rows(indices_big);
    
    delta_plus_q = exiting_arcs(arcs, q);

    for j = 1:size(delta_plus_q,1)
        r = delta_plus_q(j,2);
        qr = find_arc_index([q,r], arcs);
        for k = 1:m
            if F(k,1) ~= p || F(k,2) ~= q || F(k,3) ~= r
                if L(pq) + g_costs(qr) < L(qr)
                    L(qr) = L(pq) + g_costs(qr);
                    pred(qr) = p;
                end
            end
        end
    end
    
    [test, ~] = set_intersection(U, delta_minus_d);

end

path = select_path_wrt_arcs(o,d,arcs,pred);

end