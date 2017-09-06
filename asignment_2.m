% Stochastic Hopfield

N = 200;
p = 5;
beta = 2;
iterations = 20;
tmax = 100;

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end

state_0 = patterns(:,1);
states = zeros(N,tmax);
states(:,1)= state_0;

for t=1:tmax-1
   states(:,t+1) = StochasticUpdate(beta, states(:,t), weights);
end

