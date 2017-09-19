train_data = load('train_data_2017.txt');
val_data = load('valid_data_2017.txt');

for i = 1:2
   train_data(:,i) = (train_data(:,i)-mean(train_data(:,i)))/std(train_data(:,i));
   val_data(:,i) = (val_data(:,i)-mean(val_data(:,i)))/std(val_data(:,i));

end

train_pat = train_data(:,1:2);
train_ans = train_data(:,3);
val_pat = val_data(:,1:2);
val_ans = val_data(:,3);

lr = 0.02;
beta = 1/2;
%%
class_1 = train_pat(train_ans == 1, :);
class_2 = train_pat(train_ans == -1, :);
hold on
axis equal
plot(class_1(:,1),class_1(:,2), 'r*')
plot(class_2(:,1),class_2(:,2), 'b*')

%% 3a

iterations = 1e6;
w = rand(2,1)*0.4-0.2; % weights
bias = rand(1,1)*2-1; % biases
energy_train = zeros(iterations/1000,1);
energy_val = zeros(iterations/1000,1);
train_end = 1000;
c_err_t = zeros(train_end, 1);
c_err_v = zeros(train_end, 1);
ind_count = 0;

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
        energy_train(iter/1000) = energy_train(iter/1000) + 0.5*(train_ans(i) - out_temp)^2;
    end
    
    for i = 1:length(val_data)
        out_val_temp = tanh( beta * (w'*val_pat(i,:)' - bias ));
        energy_val(iter/1000) = energy_val(iter/1000) + 0.5*(val_ans(i) - out_val_temp)^2;
    end
end

if iterations - iter < train_end
    ind_count = ind_count + 1;
    c_err_t_temp = zeros(train_end,length(train_ans));
    c_err_v_temp = zeros(train_end,length(val_ans));
    
    for i = 1:length(train_data)
        c_err_t_temp(ind_count,i) = tanh( beta * (w'*train_pat(i,:)' - bias ));
    end
    
    for i = 1:length(val_data)
        c_err_v_temp(ind_count,i) = tanh( beta * (w'*val_pat(i,:)' - bias ));
    end
    
    c_err_t(ind_count) = 1/(2*length(train_ans))*sum(abs(train_ans - sign(c_err_t_temp(ind_count,:))'));
    c_err_v(ind_count) = 1/(2*length(val_ans))*sum(abs(val_ans - sign(c_err_v_temp(ind_count,:))'));
end

%%%%%%%%%%%%%%%%INTERLUDE%%%%%%%%%%%%%%%%%%%%

% 3: update the weights
w = w + lr*beta*(1 - tanh(beta*b)^2)*(zeta-output).*xi;
bias = bias - lr*beta*(1 - tanh(beta*b)^2)*(zeta-output);

% 4: and do it all again
end

%%
clf;
subplot(1,2,1)
hold on
axis([0 iterations 0.4 0.6])
iter_vec = linspace(1,iterations,iterations/(10*1000));
plot(iter_vec,energy_train(1:10:end)/length(train_ans), 'r')
plot(iter_vec,energy_val(1:10:end)/length(val_ans), 'b')
legend('Training set','Validation set')
set(gca,'fontsize', 8)
xlabel('Iteration', 'Interpreter', 'LaTex')
ylabel('Normalized Energy', 'Interpreter', 'LaTex')
set(gca,'fontsize', 14)

x_vec = linspace(-2,2, 100);
line1 = bias(1)/w(2) - w(1)/w(2).*x_vec;


subplot(1,2,2)
hold on
axis([-2 2 -2 2])
plot(class_1(:,1), class_1(:,2), 'r*')
plot(class_2(:,1), class_2(:,2), 'bo')
plot(x_vec,line1, 'k')
legend('Class +1',' Class -1', 'Classification boundary')
set(gca,'fontsize', 8)
xlabel('$\xi_1$', 'Interpreter', 'LaTex')
ylabel('$\xi_2$', 'Interpreter', 'LaTex')
set(gca,'fontsize', 12)


%% 3b)

% weights
w_in = rand(4,2)*0.4-0.2; 
w_out = rand(4,1)*0.4-0.2;
% biases
bias_in = rand(4,1)*2-1; 
bias_out = rand(1,1)*2-1;

iterations = 1e6;
energy_train = zeros(iterations/1000,1);
energy_val = zeros(iterations/1000,1);
train_end = 1000;
c_err_t = zeros(train_end, 1);
c_err_v = zeros(train_end, 1);
ind_count = 0;

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
        energy_train(iter/1000) = energy_train(iter/1000) + 0.5*(train_ans(i) - O_temp)^2;
    end
    
    for i = 1:length(val_data)
        xi_temp = val_pat(i,:)';
        V_temp = tanh(beta*(w_in*xi_temp - bias_in ));
        b_out_temp = w_out'*V_temp - bias_out;
        O_temp = tanh(beta*b_out_temp);
        
        energy_val(iter/1000) = energy_val(iter/1000) + 0.5*(val_ans(i) - O_temp)^2;
    end
end

if iterations - iter < train_end
    ind_count = ind_count + 1;
    c_err_t_temp = zeros(train_end,length(train_ans));
    c_err_v_temp = zeros(train_end,length(val_ans));
    
    for i = 1:length(train_data)
        xi_temp = train_pat(i,:)';
        V_temp = tanh(beta*(w_in*xi_temp - bias_in ));
        b_out_temp = w_out'*V_temp - bias_out;
        O_temp = tanh(beta*b_out_temp);
        c_err_t_temp(ind_count,i) = O_temp;
    end
    
    for i = 1:length(val_data)
        xi_temp = val_pat(i,:)';
        V_temp = tanh(beta*(w_in*xi_temp - bias_in ));
        b_out_temp = w_out'*V_temp - bias_out;
        O_temp = tanh(beta*b_out_temp);
        c_err_v_temp(ind_count,i) = O_temp;
    end
    
    c_err_t(ind_count) = 1/(2*length(train_ans))*sum(abs(train_ans - sign(c_err_t_temp(ind_count,:))'));
    c_err_v(ind_count) = 1/(2*length(val_ans))*sum(abs(val_ans - sign(c_err_v_temp(ind_count,:))'));
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
clf;
subplot(1,2,1)
hold on
axis([0 iterations 0 0.5])
iter_vec = linspace(1,iterations,iterations/(10*1000));
plot(iter_vec,energy_train(1:10:end)/length(train_ans), 'r')
plot(iter_vec,energy_val(1:10:end)/length(val_ans), 'b')
legend('Training set','Validation set')
set(gca,'fontsize', 8)
xlabel('Iteration', 'Interpreter', 'LaTex')
ylabel('Normalized Energy', 'Interpreter', 'LaTex')
set(gca,'fontsize', 14)

x_vec = linspace(-2,2, 100);
line1 = bias_in(1)/w_in(1,2) - w_in(1,1)/w_in(1,2).*x_vec;
line2 = bias_in(2)/w_in(2,2) - w_in(2,1)/w_in(2,2).*x_vec;
line3 = bias_in(3)/w_in(3,2) - w_in(3,1)/w_in(3,2).*x_vec;
line4 = bias_in(4)/w_in(4,2) - w_in(4,1)/w_in(4,2).*x_vec;

subplot(1,2,2)
hold on
axis([-2 2 -2 2])
plot(class_1(:,1), class_1(:,2), 'r*')
plot(class_2(:,1), class_2(:,2), 'bo')
plot(x_vec, line1, 'k')
plot(x_vec, line2, 'k')
plot(x_vec, line3, 'k')
plot(x_vec, line4, 'k')
legend('Class +1',' Class -1', 'Classification boundary')
set(gca,'fontsize', 8)
xlabel('$\xi_1$', 'Interpreter', 'LaTex')
ylabel('$\xi_2$', 'Interpreter', 'LaTex')
set(gca,'fontsize', 12)
