function new_state = Hopfield( weights, states )

[R,W] = size(states);
new_state = sign(weights*states);
new_state = new_state + (new_state==0) .* (2*randi([0,1],R,W)-1);

end

