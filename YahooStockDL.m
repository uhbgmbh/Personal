% Yahoo Stock Import Function

%% Import Input Data

StockSymbolList = ['NVDA AAPL GOOG XOM ATVI'];
InitialDay = '02';
InitialMonth = '00';
InitialYear = '2012';
FinalDay = '19';
FinalMonth = '03';
FinalYear = '2013';
PlotData = 0;

%% Import Function

tic;
[StockData,CellStockSymbolList] = GetYahooStockData(StockSymbolList,...
    InitialDay,InitialMonth,InitialYear,...
    FinalDay,FinalMonth,FinalYear,PlotData);
toc;

