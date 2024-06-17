%% Compute and plot the time evolution of the densities of the DCCA distances.
%%  Furthermore, compute the time evolution the first four moments of the densities.


rho_DCCA_range = linspace(0, 2, 100);


% Preallocate output matrix
density_over_timeI = zeros(length(rho_DCCA_range), size(rho_DCCA_matrixdist, 3));

% Iterate over each time window
for i = 1:size(rho_DCCA_matrixdist, 3)
    % Extract the rho_DCCA values for this time window
    rho_DCCA_valuesI = A2_matrix(:, :, i);
    
    % Get the upper triangular part of the matrix without diagonal
    rho_DCCA_valuesI = triu(rho_DCCA_valuesI, 1);
    
    % Convert to vector and remove NaN and zero values
    rho_DCCA_valuesI = rho_DCCA_valuesI(:);
    rho_DCCA_valuesI(rho_DCCA_valuesI == 0 | isnan(rho_DCCA_valuesI)) = [];
    
    % Create a KDE object for this time window
    if ~isempty(rho_DCCA_valuesI)  % Ensure the input data is not empty
        kde = fitdist(rho_DCCA_valuesI,'Kernel','Kernel','normal');
    
        % Compute the density for each value in rho_DCCA_range
        density_over_timeI(:, i) = pdf(kde, rho_DCCA_range');
    end
end


stepSize = 10; % Adjust as needed. 
selectedIndices = 1:stepSize:size(density_over_timeI, 2);


% Select corresponding dates
selectedDays_chart = selectedDays(selectedIndices);

% Create a grid of x (rho_DCCA_range) and y (time) values for selected indices
[X, Y] = meshgrid(rho_DCCA_range, 1:length(selectedIndices));

% Create the 3D plot with transparency
figure;
surf(X, Y, density_over_timeI(:, selectedIndices)', 'FaceAlpha', 0.5);


xlabel('DCCA distances on the MST');
ylabel('Date');
zlabel('pdf');


% Replace y-axis labels with dates
nLabels = 10; % Adjust this as needed, only show 10 dates, otherwise too messy
ytickIndices = round(linspace(1, length(selectedIndices), nLabels));
yticks(ytickIndices);
yticklabels(datestr(selectedDays_chart(ytickIndices), 'yyyy-mm'));
for i=1:size(rho_DCCA_matrixdist, 3)

    averageI(i)=mean(density_over_timeI(:, i));

    secondI(i)=std(density_over_timeI(:, i));

    thirdI(i)=skewness(density_over_timeI(:, i));

    fourthI(i)=kurtosis(density_over_timeI(:, i));


end

figure
subplot(4,1,1)
plot(days(w+1:end),averageI,LineWidth=2)
title('mean')

subplot(4,1,2)
plot(days(w+1:end),secondI,LineWidth=2)
title('standard deviation')


subplot(4,1,3)
plot(days(w+1:end),thirdI,LineWidth=2)
title('skewness')


subplot(4,1,4)
plot(days(w+1:end),fourthI,LineWidth=2)
title('kurtosis')