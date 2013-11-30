% Get Yahoo Data Function
% Larry Stratton
% April 18, 2013
function [StockData,CellStockSymbolList] = GetYahooStockData(StockSymbolList,...
    InitialDay,InitialMonth,InitialYear,...
    FinalDay,FinalMonth,FinalYear,PlotData)

InitialDate = datestr([InitialMonth '-' InitialDay '-' InitialYear]);
FinalDate = datestr([FinalMonth '-' FinalDay '-' FinalYear]);

numTradingDays = daysact(InitialDate,FinalDate); % Number of days
    % way overestimates number of trading days
    % deletes excess space after first stock is queried
numStocks = sum(isspace(StockSymbolList))+1;  % Number of stocks to query

StockData = zeros(numTradingDays,numStocks+1); % preallocation for speed

%% Symbol Processing
CellStockSymbolList = cell(numStocks,1);
InitialSymbolLetter = find(StockSymbolList==' ');
CellStockSymbolList{1,1} = StockSymbolList(1:InitialSymbolLetter(1)-1);
    for i = 2:numStocks-1
        CellStockSymbolList{i,1} = StockSymbolList(...
        InitialSymbolLetter(i-1)+1:InitialSymbolLetter(i)-1);
    end
    CellStockSymbolList{end,1} = StockSymbolList(...
        InitialSymbolLetter(end)+1:end);


%% First Stock Query Loop
StockSymbol = CellStockSymbolList{1,1};
urlText = GetYahooWebAddress(StockSymbol,...
    InitialDay,InitialMonth,InitialYear,...
    FinalDay,FinalMonth,FinalYear);

% Get query timestamp using ISO 8601 format
TimeStamp = datestr(now,30); 
FileName = ['data/' StockSymbol '_' TimeStamp '.csv']; % Create filename
urlwrite(urlText,FileName); % Get Data from Yahoo and save it in FileName

% Import CSV file into Matlab
newData1 = importdata(FileName);
TradingDates = cell2mat(newData1.textdata(2:end,1));
TradingDates = datenum(TradingDates);
[revisedNumTradingDays,~] = size(TradingDates);

% Correct data structure for number of trading days
if (revisedNumTradingDays < numTradingDays)     
    StockData(revisedNumTradingDays+1:end,:)=[];
end
StockData(:,1) = TradingDates;
StockData(:,2) = newData1.data(1:end,6);

% Delete excess data from variable space
clear newData1 TradingDates;

%% Every Stock Query Loop after

% Add parfor loop here for data query

for i = 2:numStocks
    
    % Get Stock Symbol
    StockSymbol = CellStockSymbolList{i,1};
    % Create Yahoo Address
    urlText = GetYahooWebAddress(StockSymbol,...
        InitialDay,InitialMonth,InitialYear,...
        FinalDay,FinalMonth,FinalYear);
    % Get query timestamp using ISO 8601 format
    TimeStamp = datestr(now,30); 
    % Create filename
    FileName = ['data/' StockSymbol '_' TimeStamp '.csv'];
    % Get Data from Yahoo and save it in FileName
    urlwrite(urlText,FileName); 
    % Import CSV file into Matlab
    newData1 = importdata(FileName);
    % Extract relevant data into StockData (Adjusted close data)
    StockData(:,i+1) = newData1.data(1:end,6);
    % Delete unused data from variable space
    clear newData1;
    
end

%% Plot Data if desired

if PlotData == 1
    plot(StockData(:,1),StockData(:,2:end));
    datetick('x','mmm-yy');
    legend(CellStockSymbolList(:,1),'Location','EastOutside');
end