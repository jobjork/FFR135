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

states = zeros(N,tmax);
state_0 = patterns(:,1);
states(:,1)= state_0;

m(1,iteration) = 1/N * (state_0'*state_0);

for t=1:tmax-1
   states(:,t+1) = StochasticUpdate(beta, states(:,t), weights);
   m(t+1,iteration) = 1/N * states(:,t+1)'*state_0;
end


end

figure(1)
subplot(211)
plot(m)
title('Order parameter m, p = 5')
xlabel('time')
ylabel('order parameter')
axis([1 tmax -1 1])



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

m(1,iteration) = 1/N * (state_0'*state_0);

for t=1:tmax-1
   states(:,t+1) = StochasticUpdate(beta, states(:,t), weights);
   m(t+1,iteration) = 1/N * states(:,t+1)'*state_0;
end

end

subplot(212)
plot(m)
title('Order parameter m, p = 40')
xlabel('time')
ylabel('order parameter')
axis([1 tmax -1 1])


