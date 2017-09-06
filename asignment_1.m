%% 1
%1 b)

p = [1, (20:20:400)]';
N = 200;
num_bits = 10000;

p_err = zeros(length(p),1);

for i=1:length(p)
   p_err(i) = OSEP(p(i), N, num_bits);
end

plot(p/N,p_err,'*')