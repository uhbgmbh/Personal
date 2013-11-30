function [StockCorr] = AnalyzeStockCorrelationRanges(...
    CellStockSymbolList,InitialDate,FinalDate)
% AnalyzeCorrRanges
% Larry Stratton
% 4/21/2013

% This function should automate finding the correlations among a set of
% start and end dates.

%% Input

% InitialDate = [InitialDay1 InitialMonth1 InitialYear1;...;
%                InitialDay2 InitialMonth2 InitialYear2;...];
% FinalDate = [FinalDay1 FinalMonth1 FinalYear1;...
%              FinalDay2 FinalMonth2 FinalYear2;...];

%% Output

% StockCorr = n x 2 cell array; where n is the number of Date sets
%   - First column of the array contains the neg correlated stocks
%   - Second column of the array contains the pos correlated stocks
%   - Each row corresponds to the respective date set

%% Dev

%{ 
Pseudo-Code
% Create cell structure rows based on number of Date sets for input
For each Date set, call GetCorrStocks
- Add output to preallocated cell array

% Need to improve Date entry for Stock import function;
% Convert to date mechanism used for this script

%}

