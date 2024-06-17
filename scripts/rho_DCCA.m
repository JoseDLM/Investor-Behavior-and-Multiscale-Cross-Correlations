%% Compute the DCCA coefficients using the entire sample
% 
% 
% output:
% 
% coefficients - DCCA coefficients returned as a numeric matrix
% 
% T - table of DCCA coefficients with the tickers 


coefficients=ones(length(symbol),length(symbol));


for index =1:length(symbol);


stock1 = Tf(1:end-1,index);

 for j = 1:size(Tf, 2)
        % Skip the preselected stock
        if j == index
            continue;
        end
        
        % Select the second stock
        stock2 = Tf(1:end-1, j);
            
coefficients(index,j) = DCCA(stock1,stock2, s);

 end
end


T = array2table(coefficients, 'RowNames', symbol, 'VariableNames', symbol)
