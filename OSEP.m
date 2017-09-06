%function p_err = OSEP(p, N , numBits)

p = 610;
N = 10000;
num_bits = 10000;

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end

%{
for i=1:N
    weights(i,i) = 0;err_vec
end
%}

avg_errors = 0;
count = 0;

%% TODO: Add all the new_state(index)~=state(index)s in a long vector,
% sample 10000 from this vector and form the p_err


iterations = ceil(num_bits/(p*N));
error_vector = zeros(p*N,iterations);

for i = 1:iterations
    for j = 1:p
       state = patterns(:,p);
       new_state = sign(weights*state);
       error_vector((j-1)*N+1:j*N,i) = new_state~=state;
    end
end
error_vector=error_vector(:); 


%%

if p*N >= num_bits
    index = randperm(1:(p*N));
    index = index(1:num_bits);
    
    count = count + 1;
    state_ind = ceil(p*rand);
    state = patterns(:, state_ind);
    new_state = sign(weights*state);
    avg_errors = avg_errors + sum(new_state(index)~=state(index))/N;
    num_bits = num_bits - p*N;
else  
    while num_bits > 0
        
        count = count + 1;
        state_ind = ceil(p*rand);
        state = patterns(:, state_ind);
        new_state = sign(weights*state);
        avg_errors = avg_errors + sum(new_state~=state)/N;
        num_bits = num_bits - p*N;
    end
    
end


p_err = avg_errors/count
%end

