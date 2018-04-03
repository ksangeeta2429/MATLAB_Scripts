%Histogram of gradient features
%input - Image
%output - featurevectore 1 X N and visualisation which can be displayed
%using plot()
function [featureVector,hogVisualization] = HOG(img)
    [featureVector,hogVisualization] = extractHOGFeatures(img);
end