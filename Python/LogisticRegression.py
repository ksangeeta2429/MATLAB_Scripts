"""
Author: Will Wolf
Source: http://willwolf.io/2015/11/18/so-you-want-to-implement-a-custom-loss-function/
Jupyter Notebook link: http://nbviewer.jupyter.org/github/cavaunpeu/automatic-differentiation/blob/master/automatic_differentiation.ipynb#Define-X,-y,-initial-weights,-and-epsilon
"""

import autograd.numpy as np

def wTx(w, x):
    return np.dot(x, w)


def sigmoid(z):
    return 1. / (1 + np.exp(-z))


def logistic_loss(y, y_predicted):
    return -(y * np.log(y_predicted) - (1 - y) * np.log(1 - y_predicted) ** 2).mean()


def logistic_predictions(w, x, eps):
    predictions = sigmoid(wTx(w, x))
    return predictions.clip(eps, 1 - eps)


def logistic_loss_given_weights(w, x, y):
    y_predicted = logistic_predictions(w, x)
    return logistic_loss(y, y_predicted)

