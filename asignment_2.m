% Stochastic Hopfield
% 2a)
clf; clear all;
N = 20000;
p = 500;
beta = 2;
iterations = 20;
tmax = 400;
m = zeros(tmax, iterations);
ts = 10;
Tmax = floor(tmax/ts);
WM = zeros(Tmax,iterations);

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

if mod(iteration, 1)== 0
    disp('Helloooo!')
end

WM(:,iteration) = WanderingMean(m(:,iteration), ts);
end
WM = [m(1,:) ; WM];


plot(ts*(0:Tmax),WM)
title('Order parameter m, p = 5', 'Interpreter', 'LaTeX')
xlabel('time [iterations]', 'Interpreter', 'LaTeX')
ylabel('order parameter', 'Interpreter', 'LaTeX')
set(gca,'fontsize', 14)
axis([1 tmax 0.9 1])
box off;

%%
% % % % % % % % % % % % % % % % % % % % % % % % %
% 2b)
% % % % % % % % % % % % % % % % % % % % % % % % %

p = 40;
tmax = 20000;
Tmax = floor(tmax/ts);
m = zeros(tmax, iterations);
WM = zeros(Tmax,iterations);

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

WM(:,iteration) = WanderingMean(m(:,iteration), ts);
end
WM = [m(1,:) ; WM];

plot(ts*(0:Tmax),WM)
title('Order parameter m, p = 40', 'Interpreter', 'LaTeX')
xlabel('time [iterations]', 'Interpreter', 'LaTeX')
ylabel('order parameter', 'Interpreter', 'LaTeX')
set(gca,'fontsize', 14)
axis([1 tmax -0.1 1])
box off;


