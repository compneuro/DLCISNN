#README for a Cerebellum-Inspired Deep Learning Algorithm
---------------------------------------------------------
Cerebellum-inspired spiking neural network(DLCISNN), a hybrid of Spiking Neural Network and Deep learning networks with the architecture and firing behaviour inspired from cerebellar microcircuitry. This README includes the software requirements and instructions to test the algorithm.

---------------------------------------------------------
Developed by Asha Vijayan and Shyam Diwakar
Amrita Mind Brain Center & Amrita School of Biotechnology, 
Amrita Vishwa Vidyapeetham, Kollam, Kerala, India.
http://www.amrita.edu/center/mind-brain/
Last updated on 28-November 2022

---------------------------------------------------------

# Required software and Instructions
1. MATLAB
	Install MATLAB 2014 or higher
	
	Download all the .m files and the decoder folder into a single folder
	
	Add 'decoder' folder to path in MATLAB. 
	
		Right clicking the 'decoder' folder; 
		
		Click on 'Add to path'; 
		
		Click 'Selected folders and subfolder'.
		
2. Dataset

	Provide a dataset of format .xlsx with feature label and class label as first row.
	
	Followed by the datapoints have to be numerical(Categorical data has to be represented as numbers). 	Zero cannot be used as a number/ label
	
	This folder has 4 datasets.
	
		1. ASD_adolescent.xlsx
		
		2. ASD_adult.xlsx
		
		3. ASD_child.xlsx
		
		4. Iris.xlsx
		

---------------------------------------------------------
# How to compile the program

1. Open the main program (DLCISNN.m) and submit the filename in line 12

2. If the classification involves more than 2 class label like in Iris dataset, Open the folder 'decoder'; Open the decoding program, comment the conditional statements under the heading 'For 2 class labels' and uncomment the statements under 'For 3 class labels'

---------------------------------------------------------

# Contact Email:ashavijayan@am.amrita.edu;shyam@amrita.edu





 







