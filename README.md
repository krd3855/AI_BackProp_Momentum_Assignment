# AI_BackProp_Momentum_Assignment
This repo contrains Matlab classifier code to classify Wine data set from UCI dataset, (using Backpropogation with Momentum technique)
# Network Architecture
           1. Number of Input layers = 14

           2. Number of Hidden layers = 4

           3. Number of Output = 3

           4. Learning Rate = 0.7

           5. Alpha = 0.8 (Back prop with momentum technique)

           6. Epoch = 100

           7. Shuffled Training Data = 40

           8. Testing Data = 20+
# Trainig Error
Trainig Squared Error is 0.000041
Number of misclassified output = 0

# Steps to Run
1. Clone the repo and add this folder to matlab path.
2. Drag and drop "BackPropAlgorithm.m".
3. This will automatically load, Normalize, Shuffle, Split and Train the Network.
4. The weights are automatically saved as Weights.mat.
5. TestingBackProp.m will be automatically launched when you call BackPropAlgorithm.m file (you can run it saperately after you run BackPropAlgorithm.m atlease once).
6. This will automatically load the saved weights and use trainind data to predict the outputs and it will show number of misclassified classes(if any).

Thank you.


Author : Krihsna Satish D S.