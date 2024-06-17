% Detrended cross-correlation coeficcient as in Podobnik, B. & Stanley, H. Detrended cross-correlation analysis: a new method for analyzing two non-stationary time
% series. Phys. Rev. Lett. 100, 084102, DOI: 10.1103/PhysRevLett.100.084102 (2008).

function [rho_DCCA, F_DCCA, F_DFA_X, F_DFA_Y] = DCCA(x, y, s)
    % Input:
    % x, y: vectors of time series data
    % s: the window size
    % Output:
    % rho_DCCA: DCCA coefficient, F_DCCA, F_DFA_X, F_DFA_Y
    
    % Check that x and y are the same length
    assert(length(x) == length(y), 'Time series must be the same length');

    % Check if x or y are column vectors, and if so, transpose them to row vectors
    if size(x,1) > 1
        x = x';
    end
    if size(y,1) > 1
        y = y';
    end

    % Integrated time series
    X = cumsum(x-mean(x));
    Y = cumsum(y-mean(y));

    % Number of overlapping windows, 
    N = length(x) - s + 1;

    % Initialize covariance
    F_DCCA = 0;

    % Initialize DFA
    F_DFA_X = 0;
    F_DFA_Y = 0;

    % Loop over all windows
    for k = 1:N
        % Extract window
        X_win = X(k:k+s-1);
        Y_win = Y(k:k+s-1);

        % Fit linear trends
        p_X = polyfit(1:s, X_win, 1);
        p_Y = polyfit(1:s, Y_win, 1);

        % Detrend
        X_detrend = X_win - polyval(p_X, 1:s);
        Y_detrend = Y_win - polyval(p_Y, 1:s);

        % Update covariance
        F_DCCA = F_DCCA + 1/(s-1)*sum(X_detrend .* Y_detrend); 
        % Update DFA
        F_DFA_X = F_DFA_X + 1/(s-1)*sum(X_detrend.^2);
        F_DFA_Y = F_DFA_Y + 1/(s-1)*sum(Y_detrend.^2);
    end
     F_DCCA = 1/N*(F_DCCA);
     F_DFA_X=1/N*(F_DFA_X);
     F_DFA_X=sqrt(F_DFA_X);
     F_DFA_Y=1/N*(F_DFA_Y);
     F_DFA_Y=sqrt(F_DFA_Y);
    % Compute DCCA coefficient: ρDCCA
    rho_DCCA  = F_DCCA / (F_DFA_X * F_DFA_Y);
end
