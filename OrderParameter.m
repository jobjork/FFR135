function [ m ] = OrderParameter( states, true_state )
[N, tmax] = size(states);
m = zeros(tmax,1);
for i=1:tmax
    m(i,1) = 1/N * states(:,i)'*true_state;
end

