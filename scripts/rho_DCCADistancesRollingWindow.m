%% Use the rolling window to compute the DCCA coefficients and the DCCA distances over time and check for missing data
%% 
% output:
% 
% rho_DCCA_matrixdist  - DCCA distances for each pair of stocks, returned as a numeric matrix
% 
% rho_DCCA_matrixnodist  - DCCA coefficients for each pair of stocks, returned as a numeric matrix



n = size(Tf, 2); % Total number of stocks
T = size(Tf, 1); % Total number of time points



rho_DCCA_matrixdist = NaN(n, n, T - w + 1); 

rho_DCCA_matrixnodist = NaN(n, n, T - w + 1); 


% Loop over all pairs of stocks
for i = 1:n
    for j = i+1:n
        % Select the two stocks
        stock1 = Tf(:, i);
        stock2 = Tf(:, j);
    
        % Slide window across data
        for t = 1:(T - w + 1)
            % Select the data in the current window
            x = stock1(t:t+w-1);
            y = stock2(t:t+w-1);
        
           
            rho_DCCA_matrixdist(i, j, t) =sqrt(2*(1-DCCA(x, y, s))); 
         rho_DCCA_matrixnodist(i, j, t) =DCCA(x, y, s);
        end
    end
end


% Identify if any rho_DCCA is NaN
% Create a mask for the upper triangle (excluding the diagonal) to only
% consider 1s in the upper triangle of matrix

mask = repmat(triu(ones(n, n), 1), [1, 1, T - w + 1]);

% Check for NaN values in the upper triangle
linearIndices = find(isnan(rho_DCCA_matrixdist) & mask);

linearIndicesnodist = find(isnan(rho_DCCA_matrixnodist) & mask);


% Convert linear indices to subscripts
[stock1_indices, stock2_indices, times] = ind2sub(size(rho_DCCA_matrixdist), linearIndices);

% Convert linear indices to subscripts
[stock1_indicesnodist, stock2_indices, times] = ind2sub(size(rho_DCCA_matrixnodist), linearIndices);

% If no NaN values are detected, print the message
if isempty(stock1_indices)
    fprintf('no NaN found\n');
else
    % Print each NaN value's information
    for k = 1:length(stock1_indices)
        fprintf('NaN detected for Stock %d and Stock %d at time %d\n', stock1_indices(k), stock2_indices(k), times(k));
    end
end
end