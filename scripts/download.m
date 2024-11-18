%% Dowload the data from Yahoo Finance. 
% 
% 
% Outputs:
% 
% T  -      is the retrieved  dataset returned as a numeric matrix merging all 
% securitites prices (along the columns). 
% 
% days - corresponding dates
% 
% data - exported spreadsheet (in the current folder)
% 
% 

symbol = {'^GSPC','^GSPTSE','^FCHI','^GDAXI','FTSEMIB.MI','^N225', '^FTSE','^HSI','IMOEX.ME'}; %stocks tickers

% Number of symbols
numSymbols = length(symbol);

% Cell arrays to store data
stockDataCell = cell(numSymbols, 1);
timetablesCell = cell(numSymbols, 1);
% Option to choose date vector
useComprehensiveDates = false;  % Set to true for union of all dates, false to use a specific index's dates

ref_index=1 % the dates to construct the combined data set are taking from the index with order ref_index, e.g., if GSPC is the first index in the set
            % them GSPC dates will be considered the reference to resample
            % all other indicves and have a common dates vector

% Cell arrays to store data
stockDataCell = cell(numSymbols, 1);
timetablesCell = cell(numSymbols, 1);

% Fetch data for each symbol and convert to timetable
for k = 1:numSymbols
    symbol_i = symbol{k};
    fprintf('Fetching data for %s...\n', symbol_i);
    
    try
        % Fetch data using the custom function
        stockData = fetchYahooFinanceData(symbol_i, initDate, endDate, interval, fields);
        
        % Remove time component and set dates to midnight
        stockData.Date = dateshift(stockData.Date, 'start', 'day');
        
        % Rename the 'Close' column to the symbol name
        varName = matlab.lang.makeValidName(symbol_i);
        stockData.Properties.VariableNames{'Close'} = varName;
        
        % Convert to timetable
        tt = table2timetable(stockData, 'RowTimes', 'Date');
        
        % Store the timetable
        timetablesCell{k} = tt(:, varName);  % Only include the price column
    catch ME
        warning('Failed to fetch data for %s: %s', symbol, ME.message);
        timetablesCell{k} = timetable();  % Empty timetable
    end
end

% Remove empty timetables
nonEmpty = ~cellfun(@isempty, timetablesCell);
timetablesCell = timetablesCell(nonEmpty);
symbol = symbol(nonEmpty);


if useComprehensiveDates
    % Use the union of all dates from all indices
    fprintf('Using comprehensive date vector from all indices.\n');
    
    % Collect all unique dates from all indices
    allDates = [];
    for k = 1:length(timetablesCell)
        allDates = [allDates; timetablesCell{k}.Date];
    end
    
    % Get unique sorted dates
    commonDates = unique(allDates);
    commonDates = sort(commonDates);
else
    % Use dates from a specific index
    referenceIndex = ref_index;  % Change this to select a different index
    fprintf('Using date vector from index: %s\n', symbol{referenceIndex});
    
    commonDates = timetablesCell{referenceIndex}.Date;
end

% Resample all timetables to the common dates with interpolation
for k = 1:length(timetablesCell)
    % Resample to common dates with linear interpolation
    timetablesCell{k} = retime(timetablesCell{k}, commonDates, 'linear');
end

% Combine all timetables into one
combinedTimetable = timetablesCell{1};
for k = 2:length(timetablesCell)
    combinedTimetable = synchronize(combinedTimetable, timetablesCell{k}, 'union', 'linear');
end

% Convert timetable to table
combinedData = timetable2table(combinedTimetable);

% Rename the time variable to 'Date'
combinedData.Properties.VariableNames{1} = 'Date';


% Display the first few rows
disp('Combined Data (First 10 Rows):');
disp(head(combinedData, 10));

% Write the combined data to an Excel file
writetable(combinedData, 'StockIndicesData_Interpolated.xlsx');
fprintf('Data with interpolated missing values has been written to StockIndicesData_Interpolated.xlsx\n');

% Extract the data matrix T (excluding the 'Date' column)
T = combinedData{:, 2:end};

% Extract the dates
days = combinedData.Date;
