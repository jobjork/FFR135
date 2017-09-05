function new_state = Hopfield( weights, states )

new_state = sign(weights*states);
new_state(find(new_state==0),1) = 2*randi([0,1],length(find(new_state==0)),1) - 1;

end

