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
theta = rand(2,1)*2-1; % biases

for iter = 1:1
% 1: pick random pattern
pat_ind = randperm( length( train_data ) , 1);
pattern = train_pat( pat_ind , :)';

% 2: feed forward values
output = sign(w'*pattern);
output = output + (output==0) * (2*randi([0,1]) -1); % to deal with sign(0)

% 3: back-propagation

% 4: update the weights

% 5: and do it all again
end