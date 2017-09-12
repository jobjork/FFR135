function update = StochasticUpdate( beta, state, weights )

b = Hopfield(weights, state);
g = Sigmoid(b,2*beta);
update = 2*(rand(length(state),1)<g)-1;

end

