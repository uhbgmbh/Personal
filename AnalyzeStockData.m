% AnalyzeStockData
% Larry Stratton
% April 19, 2013

% Find the difference in stock price between successive days
ChangeInPrice = diff(StockData(:,2:end));
% Find the return for each day
Returns = ChangeInPrice./StockData(1:end-1,2:end);
% Calculate the average over the data time period
AverageReturns = mean(Returns);
% Calculate the std dev over the data time period
StdDevReturns = std(Returns);
% Obtain number of trading days to calculate the Sharpe Ratio
NumTradingDays = size(StockData,1);
% Calculate the Sharpe Ratio
SharpeRatio = sqrt(NumTradingDays)*AverageReturns./StdDevReturns;
% Calculate the Portfolio Covariance and Correlation Coefficients
PortfolioCovariance = cov(StockData(:,2:end));
PortfolioCorrCoef = corrcoef(StockData(:,2:end));
% Keep upper half of the corr coef above the diag, since it is symmetric and
% the auto-correlation is 1.
Upper = triu(PortfolioCorrCoef,1);
% Find the negatively correlated stocks
[StockRow,StockCol] = find(Upper<0);
% Output negatively correlated stocks
fprintf('%s and %s are negatively correlated.\n',...
    CellStockSymbolList{[StockRow,StockCol]'});
% Output list of negatively correlated stocks
NegCorrStockList = [StockRow,StockCol];

fprintf('\n');

% Find the positively correlated stocks
[StockRow,StockCol] = find(Upper>0);
% Output positively correlated stocks
fprintf('%s and %s are positively correlated.\n',...
    CellStockSymbolList{[StockRow,StockCol]'});
% Output list of positively correlated stocks
PosCorrStockList = [StockRow,StockCol];


