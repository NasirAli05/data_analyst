# Brain-Tumor-Detection-Using-Python
This code is an implementation of a machine learning model for detecting brain tumors using images. The code is written in Python and uses the TensorFlow and Keras libraries for building and training the model. Here's a breakdown of what the code does:

1. **Imports and Initial Setup**: The code starts with importing necessary libraries such as `numpy`, `tensorflow`, and `keras`, along with various components from these libraries. It also sets up some configurations for the environment. This section ensures that the required packages are available and properly configured for use.

2. **Data Preparation**: The code then prepares the data for training and testing. It creates directories for training, validation, and testing sets. It moves image files into these directories and organizes them into classes based on the type of brain tumor (classes 1, 2, and 3).

3. **VGG-16 Model**: The code utilizes a pre-trained VGG-16 model for transfer learning. It loads the VGG-16 model and modifies it slightly. The last layer of the VGG-16 model (a classification layer) is removed, and a new output layer is added to match the number of classes (3 classes for brain tumor types). The VGG-16 model's layers are then set to be non-trainable, except for the newly added output layer.

4. **Training the VGG-16 Model**: The modified VGG-16 model is compiled with an optimizer, loss function, and accuracy metric. It is then trained on the training data while validating on the validation data. This process is repeated for a specified number of epochs.

5. **Predictions and Confusion Matrix**: After training, the model is used to predict the tumor types on the test dataset. The predicted labels are then compared with the actual test labels to generate a confusion matrix, which helps visualize the model's performance in classifying different tumor types.

6. **MobileNets Model**: Similar steps are repeated using the MobileNets architecture. The code loads a pre-trained MobileNets model, modifies it by adding a new output layer, and freezes certain layers for transfer learning. The model is compiled and trained using the same approach as with VGG-16.

7. **Predictions and Confusion Matrix (MobileNets)**: After training the MobileNets model, predictions are made on the test dataset, and a confusion matrix is generated to evaluate the model's performance on classifying brain tumor types.

Overall, the code demonstrates how to utilize pre-trained neural network models (VGG-16 and MobileNets) for brain tumor classification tasks. It involves data preprocessing, model modification, training, and evaluation using confusion matrices. The final output provides insights into how well the models are performing in identifying different types of brain tumors.
