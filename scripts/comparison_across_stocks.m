%% Compare the time evolution of DCCA coefficients across stocks, using a chosen base stock.
% 

stock1 = Tf(:, number);  

% Preallocate output
n=length(symbol)-1;
rho_DCCA = cell(n, length(s_values)); % n times series with DCCA rhos ans time-scales

for s_index=1:length(s_values)
    s = s_values(s_index);
    for j = 1:size(Tf, 2)
        % Skip the preselected stock
        if j == number
            continue;
        end
        
        % Select the second stock
        stock2 = Tf(:, j);
            
        % Preallocate output for this pair
        rho_DCCA{j, s_index} = NaN(length(stock1) - w + 1, 1);
    
        % Slide window across data
        for i = 1:(length(stock1) - w + 1)
            % Select the data in the current window
            x = stock1(i:i+w-1);
            y = stock2(i:i+w-1);
        
            % Calculate the DCCA for the current window and store the result
            rho_DCCA{j, s_index}(i) =sqrt(2*(1- DCCA(x, y, s)));
        end
    end
end

%%




selectedDays= days(w+1:end); %we start at w+1 as we calculated log returns dropping the first observation

% Create plots for each rho_DCCA
scrsz = get(0,'ScreenSize'); % Get screen size

figure('Position',[1 1 scrsz(3) scrsz(4)]); % Create a new figure for all plots with specified screen size



for j = 1:size(T, 2)
    % Skip the preselected stock
    if j ~= number
   

    % Create a subplot for each pair of plots
    subplot(ceil(size(T, 2)/2), 2, j-1);
    
    % Plot each time series
    for s_idx = 1:numel(s_values)
        plot(selectedDays, rho_DCCA{j, s_idx}, 'DisplayName', ['s = ', num2str(s_values(s_idx))],'LineWidth',2);
        hold on;
    end
    
    title(['DCCA distance', symbol{number}, ' and ', symbol{j}]); % Set the title of the plot
    legend('Location', 'best'); % Add a legend
    datetick('x','mmm-yy','keepticks'); % Change the date format on the x-axis
    hold off
    else
        continue;
    end
end