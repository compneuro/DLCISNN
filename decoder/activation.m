function actvOut=activation(Out)
% Using softmax classifier to find value of each node
actvOut= 1 / (1 + exp(-Out));
