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


for k = 1:length(symbol); 
       
    data = getMarketDataViaYahoo(symbol{k}, initDate, endDate,integral);
    
    ts(k) = timeseries(data.Close, datestr(data(:,1).Date));
    
    tsout = resample(ts(k),ts(1).Time);
    
    T(:,k) = tsout.Data;
    
end

writematrix(T,'data.xlsx');

timeseries2timetable(tsout);

indices = tsout.Time + 1;
 
days = dates(indices);  



%%