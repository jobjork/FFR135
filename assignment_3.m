train_data = load('train_data_2017.txt');
val_data = load('valid_data_2017.txt');

for i = 1:2
   train_data(:,i) = (train_data(:,i)-mean(train_data(:,i)))/std(train_data(:,i));
end

train_pat = train_data(:,1:2);
train_ans = train_data(:,3);
lr = 0.02;
beta = 1/2;

%% 3a

iterations = 1e6;
w = rand(2,1)*0.4-0.2; % weights
bias = rand(1,1)*2-1; % biases
energy = zeros(iterations/1000,1);

for iter = 1:iterations
    
% 1: pick random pattern
pat_ind = randperm( length( train_data ) , 1);
xi = train_pat( pat_ind , :)';
zeta = train_ans(pat_ind);

% 2: feed forward values
b = w'*xi - bias;
output = tanh(beta*b);


%%%%%%%%%%%%%%%%INTERLUDE%%%%%%%%%%%%%%%%%%%%
if mod(iter,1000) == 0
    for i = 1:length(train_data)
        out_temp = tanh( beta * (w'*train_pat(i,:)' - bias ));
        energy(iter/1000) = energy(iter/1000) + 0.5*(train_ans(i) - out_temp)^2;
    end
end
%%%%%%%%%%%%%%%%INTERLUDE%%%%%%%%%%%%%%%%%%%%

% 3: update the weights
w = w + lr*beta*(1 - tanh(beta*b)^2)*(zeta-output).*xi;
bias = bias - lr*beta*(1 - tanh(beta*b)^2)*(zeta-output);

% 4: and do it all again
end

plot(energy)

%%also plot line from weights in space of patterns

%% 3b)

% weights
w_in = rand(4,2)*0.4-0.2; 
w_out = rand(4,1)*0.4-0.2;
% biases
bias_in = rand(4,1)*2-1; 
bias_out = rand(1,1)*2-1;

iterations = 1e6;
energy = zeros(iterations/1000,1);

for iter = 1:iterations
% 1: Pick a random pattern
pat_ind = randperm( length( train_data ) , 1);
xi = train_pat( pat_ind , :)';
zeta = train_ans(pat_ind);
                                             % k = 1..2, j = 1..4, i = 1
% 2: Feed forward values
b_V = w_in*xi - bias_in;
V = tanh(beta*b_V);

b_out = w_out'*V - bias_out;
O = tanh(beta*b_out); 

%%%%%%%%%%%%%%%%INTERLUDE%%%%%%%%%%%%%%%%%%%%
if mod(iter,1000) == 0
    for i = 1:length(train_data)
        xi_temp = train_pat(i,:)';
        V_temp = tanh(beta*(w_in*xi_temp - bias_in ));
        b_out_temp = w_out'*V_temp - bias_out;
        O_temp = tanh(beta*b_out_temp);
        energy(iter/1000) = energy(iter/1000) + 0.5*(train_ans(i) - O_temp)^2;
    end
end
%%%%%%%%%%%%%%%%INTERLUDE%%%%%%%%%%%%%%%%%%%%

% 3: Update the weights (and bias) 
delta_i = beta*(zeta - O)*(1 - O.^2);
delta_j = delta_i * w_out .* (1 - V.^2);

dw_out = lr * delta_i * V;
dw_in = lr * delta_j .* xi';
dbias_out = -lr * delta_i;
dbias_in = -lr * delta_j;

w_in = w_in + dw_in;
w_out = w_out + dw_out;
bias_in = bias_in + dbias_in;
bias_out = bias_out + dbias_out;

% 4: And do it all again
end
%%
plot(energy)