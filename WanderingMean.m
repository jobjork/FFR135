function [ WM ] = WanderingMean( m, ts )
tmax = length(m);
iterations = floor(tmax/ts);
WM = zeros(iterations,1);

for i=1:iterations
    T = i*ts;
    WM(i) = mean(m(1:T));
end

end
