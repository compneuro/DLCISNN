% ------------------------------------------------------------------------------------------------------------------
% Project:  Spike Encoding for Pattern Recognition: Comparing Cerebellum Granular Layer Encoding and BSA algorithms
% Authors:  Lekshmi Priya R & Ritu Maria Zacharia
% ------------------------------------------------------------------------------------------------------------------

%------------------------WEIGHT INITIALIZATION---------------------------%
function w=initWeight(x,y)
w=0.01*ones(x,y);%randi([-1 1],[x,y]);

%fprintf('weight : %d \n',w);