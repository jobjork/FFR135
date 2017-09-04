%% 1
pmax = 400; % Maximum number of patterns
N = 200; % Number of bits

patterns = randi([0,1],pmax,N); % Generate random patterns
for x=1:pmax
    for y=1:N
        if (patterns(x,y)==0)               % Change 0 to -1
            patterns(x,y)=-1;
        end
    end
end


%1 a)

%1 b)
