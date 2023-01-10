function [score, TPR, TNR] = f1_score(label, predict)
   M = confusionmat(label, predict);
   TPR = M(2,2) / (M(2,1) + M(2,2)); 
   TNR = M(1,1) / (M(1,1) + M(1,2)); 

   M = M';
   precision = diag(M)./(sum(M,2) + 0.0001); 
   recall = diag(M)./(sum(M,1)+0.0001)';
   precision = mean(precision);
   recall = mean(recall);
   score = 2*precision*recall/(precision + recall);
end