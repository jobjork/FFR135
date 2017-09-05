%function p_err = OSEP(p, N , numBits)

p = 1220;
N = 2000;
num_bits = 10000000;

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end

for i=1:N
    weights(i,i) = 0;
end

avg_errors = 0;
count = 0;
while num_bits > 0
    count = count + 1;
    state_ind = ceil(p*rand);
    state = patterns(:, state_ind);
    new_state = sign(weights*state);
    avg_errors = avg_errors + sum(new_state~=state)/N;
    num_bits = num_bits - p*N;
end

p_err = avg_errors/count
%end

