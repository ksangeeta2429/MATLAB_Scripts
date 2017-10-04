"""
Author: Will Wolf
Source: http://willwolf.io/2015/11/18/so-you-want-to-implement-a-custom-loss-function/
Jupyter Notebook link: http://nbviewer.jupyter.org/github/cavaunpeu/automatic-differentiation/blob/master/automatic_differentiation.ipynb#Define-X,-y,-initial-weights,-and-epsilon
"""

from autograd import grad
import autograd.numpy as np
import time

def wTx(w, x):
    return np.dot(x, w)


def sigmoid(z):
    return 1. / (1 + np.exp(-z))


def logistic_loss(y, y_predicted):
    return -(y * np.log(y_predicted) - (1 - y) * np.log(1 - y_predicted) ** 2).mean()


def logistic_predictions(w, x):
    predictions = sigmoid(wTx(w, x))
    return predictions.clip(eps, 1 - eps)


def logistic_loss_given_weights(w, x, y):
    y_predicted = logistic_predictions(w, x)
    return logistic_loss(y, y_predicted)


gradient = grad(logistic_loss_given_weights)
eps = 1e-15

if __name__ == "__main__":
    # Test code
    X = np.array([
        [0.3213, 0.4856, 0.2995, 2.5044],
        [0.3005, 0.4757, 0.2974, 2.4691],
        [0.5638, 0.8005, 0.3381, 2.3102],
        [0.5281, 0.6542, 0.3129, 2.1298],
        [0.3221, 0.5126, 0.3085, 2.6147],
        [0.3055, 0.4885, 0.289, 2.4957],
        [0.3276, 0.5185, 0.3218, 2.6013],
        [0.5313, 0.7028, 0.3266, 2.1543],
        [0.4728, 0.6399, 0.3062, 2.0597],
        [0.3221, 0.5126, 0.3085, 2.6147]
    ])
    y = np.array([1., 1., 0., 0., 1., 1., 1., 1., 0., 0.])

    weights = np.zeros(X.shape[1])

    start_time = time.time()
    for i in range(100000):
        if i % 10000 == 0:
            print('Iteration %-4d | Loss: %.4f' % (i, logistic_loss_given_weights(weights, X, y)))
        weights -= gradient(weights, X, y) * .01  # .01 being the learning rate
    end_time = time.time()

    print("Elapsed time was %g seconds" % (end_time - start_time))
    print('Final weights: ', weights)