% Stochastic Hopfield
% 2a)

N = 200;
p = 5;
beta = 2;
iterations = 20;
tmax = 40;
m = zeros(tmax, iterations);

for iteration = 1:iterations

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end
for i=1:N
    weights(i,i)=0;
end

state_0 = patterns(:,1);
states = zeros(N,tmax);
states(:,1)= state_0;

for t=1:tmax-1
   states(:,t+1) = StochasticUpdate(beta, states(:,t), weights);
end

m(:, iteration) = OrderParameter(states, patterns(:,1));

end

figure(1)
subplot(221)
plot(m)
title('Order parameter m, p = 5')
xlabel('time')
ylabel('order parameter')
axis([1 tmax -1 1])

subplot(222)
plot(abs(m))
title('Magnitude of m, p = 5')
xlabel('time')
ylabel('order parameter')
axis([1 tmax 0 1])


% % % % % % % % % % % % % % % % % % % % % % % % %
% 2b)
% % % % % % % % % % % % % % % % % % % % % % % % %


p = 40;
m = zeros(tmax, iterations);

for iteration = 1:iterations

patterns = GeneratePatterns(p, N);

weights = zeros(N,N);
for k=1:p
    weights = weights + 1/N*patterns(:,k) * patterns(:,k)';
end
for i=1:N
    weights(i,i)=0;
end

state_0 = patterns(:,1);
states = zeros(N,tmax);
states(:,1)= state_0;

for t=1:tmax-1
   states(:,t+1) = StochasticUpdate(beta, states(:,t), weights);
end

m(:, iteration) = OrderParameter(states, patterns(:,1));

end

subplot(223)
plot(m)
title('Order parameter m, p = 40')
xlabel('time')
ylabel('order parameter')
axis([1 tmax -1 1])

subplot(224)
plot(abs(m))
title('Magnitude of m, p = 40')
xlabel('time')
ylabel('order parameter')
axis([1 tmax 0 1])