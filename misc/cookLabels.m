function labels=cookLabels(labelsRaw)
% Make sure the labels only contains the fields we want from the raw labels.

nLabels=length(labelsRaw);
labels = ...
  struct('t0s',cell(1,nLabels), ...
         't1s',cell(1,nLabels), ...
         'names',cell(1,nLabels), ...
         'flies',cell(1,nLabels), ...
         'off',cell(1,nLabels), ...
         'timestamp',cell(1,nLabels), ...
         'imp_t0s',cell(1,nLabels), ...
         'imp_t1s',cell(1,nLabels));
fieldNames=fieldnames(labels);       
for i=1:nLabels
  for j=1:length(fieldNames)
    fieldName=fieldNames{j};
    labels(i).(fieldName)=labelsRaw(i).(fieldName);
  end
end
       
end
