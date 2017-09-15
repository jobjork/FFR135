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
energy = zeros(iterations,1);

for iter = 1:iterations
    
% 1: pick random pattern
pat_ind = randperm( length( train_data ) , 1);
xi = train_pat( pat_ind , :)';
zeta = train_ans(pat_ind);

% 2: feed forward values
b = w'*xi - bias;
output = tanh(beta*b);

% output = output + (output==0) * (2*randi([0,1]) -1) % to deal with sign(0)
for i = 1:length(train_data)
    out_temp = tanh( beta * ( train_pat(i,:)*w - bias ));
    energy(iter) = energy(iter) + 0.5*(train_ans(i) - out_temp)^2;
end

% 3: update the weights
w = w + lr*beta*(1 - tanh(beta*b)^2)*(zeta-output).*xi;
bias = bias - lr*beta*(1 - tanh(beta*b)^2)*(zeta-output);

% w = w - lr*(output-zeta)*beta*(1-(tanh(beta*b))^2)*xi;
% bias = bias - lr*(zeta-output)*beta*(1-(tanh(beta*b))^2);

% 4: and do it all again
end

plot(energy)