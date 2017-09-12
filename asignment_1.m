%% 1
%1 b)
clf;
p = [1, (20:20:400)]';
N = 200;
num_bits = 100000;

p_err = zeros(length(p),1);

for i=1:length(p)
   tic
   p_err(i) = OSEP(p(i), N, num_bits);
   toc
end

plin = linspace(1,400); % for plotting resolution
erf_vec = 0.5*(1 - erf( (plin+N)./(sqrt(2*plin*N)) ) );

hold on
plot(p/N,p_err,'*')
plot(plin/N, erf_vec, '-')
xlabel('\alpha = p/N')
ylabel('P_{err}')
legend('Experiment data','Theoretical model')