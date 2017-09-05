function patterns = GeneratePatterns( p ,N )

patterns = randi([0,1], N ,p); % Generate random patterns
patterns = 2*patterns-1;

end

