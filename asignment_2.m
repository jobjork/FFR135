% Stochastic Hopfield

N = 200;
p = 5;
beta = 2;
iterations = 20;
tmax = 20;
m = zeros(tmax, iterations);

for iteration = 1:iterations

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

m(:, iteration) = OrderParameter(states, patterns(:,1));

end

subplot(121)
plot(m)
title('Order parameter m')
xlabel('time')
ylabel('order parameter')

subplot(122)
plot(abs(m))
title('Absolute value of m')
xlabel('time')
ylabel('order parameter')
axis([0 tmax 0 1])