function result = Sigmoid( b, beta )
    result = 1 ./ (1 + exp(-b.*beta));
end

