%% Filter logarithmic returns through a GARCH(1,1) model,  standardize the data and clean the data 
% 
% 
% output:
% 
% Tf - filtered, standardized and cleaned data as a numeric matrix
% 
% selectedDays - days for the cleaned data
% 
% 
% 
% 



num_stocks = size(T, 2);


          Tf = zeros(size(T) - [1 0]);

          
          garchModel = garch(1,1);  %create a GARCH(1,1) model
    
          for i = 1:num_stocks
          
           r = diff(log(T(:,i)));  % compute logaritmic returns
    
       
      
           estMdl = estimate(garchModel, r, 'Display', 'off'); %Estimate the GARCH model parameters
    
          
           [~, variances] = infer(estMdl, r);  % Simulate the GARCH model to get the conditional variances
    
           
           Tf(:, i) = r ./ sqrt(variances); %filtered returns

          
           Tf(:, i) = (Tf(:, i) - mean(Tf(:, i))) ./ std(Tf(:, i)); %standardize the filtered returns
          end

        selectedDays=days(2:end);



nanRows = any(isnan(Tf), 2);  % Identify rows with at least one NaN


Tf(nanRows, :) = [];  % Remove those rows from Tf 
selectedDays(nanRows) = []; % Remove those rows from selectedDays