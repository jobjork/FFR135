function p_err = OSEP(p, N , num_bits)

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end

iterations = ceil(num_bits/(p*N));
error_vector = zeros(p*N,iterations);

for i = 1:iterations
    for j = 1:p
       state = patterns(:,j);
       new_state = Hopfield(weights, state);
       error_vector((j-1)*N+1:j*N,i) = new_state~=state;
    end
end
error_vector=error_vector(:); 

index = randperm(length(error_vector));
p_err = sum(error_vector(index(1:num_bits)))/num_bits;

end