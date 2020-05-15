# DL-RBCsegmentation-MalariaDetection

This is a Digital Pathology System (DPS) for malaria detection with the use of neural networks. It accepts as input digital images of peripheral blood (PB) smears and outputs the potentially infected Red Blood Cells (RBCs). The DPS consists of a three-stages pipeline: (1) a Segmentation Neural Network (SNN) segments the RBCs of the smears; (2) a mathematical morphology-based algorithm crops and masks the RBCs; and (3) a Convolutional Neural Network (CNN) classifies each RBC into malaria parasitised or not.

DOI: 10.5281/zenodo.3828050

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

The code runs on [MATLAB](https://www.mathworks.com/products/new_products/latest_features.html) (The MathWorks Inc., MA) - Version 9.8.0.1359463 (R2020a). It requires the [Deep Learning Toolbox](https://www.mathworks.com/products/deep-learning.html) and [Image Processing Toolbox](https://www.mathworks.com/products/image.html).

### Installing

1) Download the following files and make sure they are in the same folder:
	* [cnn.mat](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/cnn.mat)
	* [extract_rbc.m](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/extract_rbc.m)
	* [get_patch.m](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/get_patch.m)
	* [main](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/main.m)
	* [mask_central_rbc](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/mask_central_rbc.m)
	* [predictMalaria.m](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/predict_malaria.m).
	* [snn.mat](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/snn.mat)
2) Open [main.m](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/main.m) and RUN the code.
3) A browser of your computer will pop up. Select the folder that contains the wide field blood smears that you would like to analyse.
4) Wait for the results to be displayed:
	* All the cropped and masked RBCs from your slides will be saved in a folder in this same folder.
	* The percentage of RBCs predicted as potentially infected will be displayed in the command window.
	* The potentially infected RBCs will appear in the screen.

## Built With

* [MATLAB](https://www.mathworks.com/company/newsroom/mathworks-announces-release-2018a-of-the-matlab-and-simulink-product-families.html) - Version 9.4.0.813654 (R2018a)

## Complementary Material
The following datasets were used to train, validate and test this DPS:
* Delgado-Ortet, Maria; Molina, Angel; Alférez, Santiago; Rodellar, José; Merino, Anna (2020), “Dataset A: 186 digital images of MGG-stained blood smears from five patients with hereditary spherocytosis”, Mendeley Data, v1. http://dx.doi.org/10.17632/c37wnbbd3c.1
* Delgado-Ortet, Maria; Molina, Angel; Alférez, Santiago; Rodellar, José; Merino, Anna (2020), “Dataset B: 331 digital images of MGG-stained blood smears from five malaria-infected patients”, Mendeley Data, v1. http://dx.doi.org/10.17632/2v6h4j48cx.1
* Rajaraman S, Antani SK, Poostchi M, Silamut K, Hossain MA, Maude, RJ, Jaeger S, Thoma GR. (2018), "Malaria Datasets", https://ceb.nlm.nih.gov/malaria-datasets/

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/mariadeor/DL-RBCSegmentation-MalariaDetection-v01/blob/master/LICENSE) file for details.

Copyright (c) 2020 Maria Delgado-Ortet (github.com/mariadeor)
