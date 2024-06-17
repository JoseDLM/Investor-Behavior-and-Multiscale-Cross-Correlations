%% Plot the standardized data in a single graphical window


data_new=T(w+1:end,:); % skip the first rolling window



dataStandard=(data_new-mean(data_new))./std(data_new);



plot(days(w+1:end),dataStandard)
ylim([-4,4])
ylabel('Standardized prices')
legend(symbol,'Location','northwest')