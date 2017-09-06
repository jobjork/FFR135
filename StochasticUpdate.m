function update = StochasticUpdate( beta, state, weights )


b = Hopfield(weights, state);
g = sigmf(b,[2*beta 0]);
update = 2*(rand(length(state),1)>g)-1;

end

