%% 1
%1 b)
clf;
p = [1, (20:20:400)]';
N = 200;
num_bits = 10000;

p_err = zeros(length(p),1);

for i=1:length(p)
   tic
   p_err(i) = OSEP(p(i), N, num_bits);
   disp(['Iteration number ', num2str(i)])
   toc
end

%erf_vec = 0.5*(1 - erf( (p+N)./(p*sqrt(2)) ) );
erf_vec = 0.5*(1 - erf( (p*N)./(sqrt(2*p*N)) ) );
% sigma är p/N, inte variansen

hold on
plot(p/N,p_err,'*')
plot(p/N, erf_vec, 'o')
xlabel('p/N')
ylabel('OSEP')