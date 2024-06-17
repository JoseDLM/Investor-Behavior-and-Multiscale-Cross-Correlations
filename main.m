%% Computation of filtered Detrended Cross-Correlation distances 
% 
% 
%% *PART I - Data preparation*
% 
% *Step 1. Initializing the parameters*
% 


% *Data collection from Yahoo Finance.*
%% 
% * *Select the assets (tickers), specify the start and end dates, choose the 
% frequency (ranging from daily to quarterly), and indicate whether to  download 
% closing, opening, or adjusted prices (adjustments for this last point can be 
% made  in the file downloadingData).*
% 
%% 
% * *select the rolling window size w*
% * *select the time scale s*
%% 
% 
% Step 2: Data Downloading, cleaning, and exporting
%% 
% * Downloading the data and merging it into a single table
% * Cleaning the data to ensure accuracy and consistency
% * Exporting the cleaned data as a spreadsheet"
% 
% *Step 3. Data preprocessing (* apply a GARCH filter to reduce potential volatility bias across different time windows)
%% 
% * Compute log-returns of the data.
% * Filter the data using GARCH(1,1) to estimate conditional variance.
% * Normalize the results using the transformation formula  $r_{t,f} =r_t \sqrt{h_t 
% }$ , where $h_t$is the conditional variance obtained from GARCH(1,1).
%% 
% 

%Step 1

clear all
close all

% Add functions directory to path. Replace path with user-specific choice
% The genpath function generates a path string that includes the specified directory 
% and all its subdirectories, i.e. all functions under "functions" directory would be called. 

addpath(genpath('C:\Users\YourUsername\Documents\my-matlab-project\functions'));

initDate = '05-Mar-2013';
endDate = '30-May-2023';


dates = datetime(initDate):datetime(endDate);  %time range

interval = '1d'; %frequency of observations (supported: '5d', '1wk', '1mo', '3mo')

symbol = {'^GSPC','^GSPTSE','^FCHI','^GDAXI','FTSEMIB.MI','^N225', '^FTSE','^HSI','IMOEX.ME'}; %stocks tickers

w=250; %rolling window's size

s= 120; %time scale size

%% 
% 
% 
% 

%Step 2

download


%% 
% 
% *Step 2.1 (optional)*
% *Plotting the standardized data*
% 

plotStandData
%% 
% 
% 

%Step 3

preprocessing


%% 
% Step 3.1 Static analysis (optional)
% . 
%% 
% * Computing the detrended cross-correlations over the entire time range and 
% get the matrix of detrended cross-correlations coefficients
%% 
% 


rho_DCCA


%% *PART II - Dynamic analysis and filtering through the MST*
% Step 4.
% 
%% 
% * Computing the dynamic behavior of DCCA coefficients using a sliding window 
% technique.
% Step 5.
%% 
% * Construct the MST using the computed DCCA coefficients and distances.
% * Compute and plot the spectrum of the adjacency matrix representing the network 
% formed by the DCCA coefficients.
%% 
% 
% 

%Step 4

rho_DCCADistancesRollingWindow

%% 
% 

%Step 5

filtering_MST

%% 
% Step 5.1 (optional)
% Compute and plot the time evolution of the density functions of the DCCA distances filtered on the MST. Additionally, include the dynamics of  the first four moments.
% 


plotDensities




%% 
% 
% Step 5.2 (optional)
% Compare the static DCCA distances computed over the entire time range  for each stock with respect to a base stock, considering different time  scales.
% 
% 
% 

s_values = [ 10, 30, 60, 120];  %select the different time scales


number=1; % Select the base stock to correlate with (S&P in the example)


comparison_across_stocks
%% 
%