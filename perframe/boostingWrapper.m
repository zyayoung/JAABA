function [allDataModel,outScores,stats] = boostingWrapper(data,labels,obj,binVals,bins,params,str)
% [allDataModel,outScores,stats] = boostingWrapper(data,labels,obj,binVals,bins,params)
% labels: integer label vec. Currently, labels are either 1 (positive, 
% behavior present, etc) or any other value (negative)

if nargin<7,
  str = '';
end

assert(isvector(labels) && numel(labels)==size(data,1));
assert(all(labels==1 | labels==2));

boostIterations = params.iter;
% Learn classifier with all the data.
numEx = size(data,1);
posEx = labels == 1;
negEx = ~posEx;
numPos = sum(posEx);
numNeg = sum(negEx);

if numPos<1 || numNeg<1,
  allDataModel = struct('dim',1,'error',0.5,'dir',1,'tr',0,'alpha',0);
  outScores = zeros(1,numEx);
  return;
end

modLabels = sign( (labels==1)-0.5);
wt = getWeights(modLabels);

[outScores, allDataModel] = loglossboostLearnRandomFeatures(data,modLabels,boostIterations,wt,binVals,bins,params,obj,str);

if nargout >= 3,
  % compute some statistics of how well training worked
  stats = ComputeBoostingStats(outScores,labels);
end

return;


