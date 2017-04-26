package weka.attributeSelection.userExtensions;

import java.util.Arrays;
import java.util.Random;

import weka.attributeSelection.ASEvaluation;
import weka.attributeSelection.ASSearch;
import weka.attributeSelection.AttributeSelection;
import weka.attributeSelection.InfoGainAttributeEval;
import weka.attributeSelection.Ranker;
import weka.classifiers.AbstractClassifier;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;
import weka.classifiers.functions.LibSVM;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.Utils;
import weka.filters.Filter;
import weka.filters.supervised.attribute.Discretize;
import weka.filters.unsupervised.attribute.NumericToBinary;

public class CustomMIToolbox {
	/**
	 * Selects optimal k features according to the mRMR-D algorithm from
	 * "Feature Selection Based on Mutual Information: Criteria of
	 * Max-Dependency, Max-Relevance, and Min-Redundancy" by H. Peng et al.
	 * (2005)
	 * 
	 * @param k
	 *            number of features to be selected
	 * @param data
	 *            training data
	 * @return int[] answerFeatures
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static int[] mRMR_D(int k, Instances data) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures : k;

		int[] answerFeatures = new int[noOfAnswerFeatures];

		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);

		double[][] featureMIMatrix = new double[noOfAnswerFeatures][noOfFeatures];
		for (double[] row : featureMIMatrix)
			Arrays.fill(row, -1);

		double[] infoGains = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			infoGains[(int) selectionMatrix[i][0]] = selectionMatrix[i][1];
		}

		// The first feature is the one with the highest information gain
		answerFeatures[0] = infoGainRanking[0];
		unselectedFeatures[answerFeatures[0]] = false;

		// Discretize input data before proceeding
		Instances discrete_data;
		if (!evaluator.getBinarizeNumericAttributes()) {
			Discretize disTransform = new Discretize();
			disTransform.setUseBetterEncoding(true);
			disTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, disTransform);
		} else {
			NumericToBinary binTransform = new NumericToBinary();
			binTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, binTransform);
		}

		for (int i = 1; i < answerFeatures.length; i++) {
			double score = -100;
			int currentHighestFeature = -1;
			int numSelectedSoFar = i;

			for (int j = 0; j < noOfFeatures; j++) {
				if (!unselectedFeatures[j])
					continue;

				double currentMIScore = 0;
				for (int m = 0; m < numSelectedSoFar; m++) {
					if (featureMIMatrix[m][j] == -1) {
						featureMIMatrix[m][j] = getMutualInformation(j, answerFeatures[m], discrete_data);
					}
					currentMIScore += featureMIMatrix[m][j];
				}
				double currentScore = infoGains[j] - currentMIScore / numSelectedSoFar; // MRMR_D
																						// step
				if (currentScore > score) {
					score = currentScore;
					currentHighestFeature = j;
				}
			}

			if (score < 0) {
				System.out.println("At selection " + noOfFeatures + ", mRMRD is negative with value " + score);
			}

			// Include most suitable feature from this iteration
			answerFeatures[i] = currentHighestFeature;
			unselectedFeatures[answerFeatures[i]] = false;
		}

		return answerFeatures;
	}

	/**
	 * Creates a relevance map of features when running the mRMR algorithm from
	 * "Feature Selection Based on Mutual Information: Criteria of
	 * Max-Dependency, Max-Relevance, and Min-Redundancy" by H. Peng et al.
	 * (2005)
	 * 
	 * @param data
	 *            training data
	 * @return double[] relevanceFeatures
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static double[] mRMR_RelevanceMap(Instances data) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		// int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures
		// : k;

		int[] answerFeatures = new int[noOfFeatures];
		double[] relevanceFeatures = new double[noOfFeatures];

		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);

		double[][] featureMIMatrix = new double[noOfFeatures][noOfFeatures];
		for (double[] row : featureMIMatrix)
			Arrays.fill(row, -1);

		double[] infoGains = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			infoGains[(int) selectionMatrix[i][0]] = selectionMatrix[i][1];
		}

		// The first feature is the one with the highest information gain
		answerFeatures[0] = infoGainRanking[0];
		unselectedFeatures[answerFeatures[0]] = false;
		relevanceFeatures[answerFeatures[0]] = selectionMatrix[0][1];

		// Discretize input data before proceeding
		Instances discrete_data;
		if (!evaluator.getBinarizeNumericAttributes()) {
			Discretize disTransform = new Discretize();
			disTransform.setUseBetterEncoding(true);
			disTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, disTransform);
		} else {
			NumericToBinary binTransform = new NumericToBinary();
			binTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, binTransform);
		}

		for (int i = 1; i < answerFeatures.length; i++) {
			double score = -100;
			int currentHighestFeature = -1;
			int numSelectedSoFar = i;

			for (int j = 0; j < noOfFeatures; j++) {
				if (!unselectedFeatures[j])
					continue;

				double currentMIScore = 0;
				for (int m = 0; m < numSelectedSoFar; m++) {
					if (featureMIMatrix[m][j] == -1) {
						featureMIMatrix[m][j] = getMutualInformation(j, answerFeatures[m], discrete_data);
					}
					currentMIScore += featureMIMatrix[m][j];
				}
				double currentScore = infoGains[j] - currentMIScore / numSelectedSoFar; // MRMR_D
																						// step
				if (currentScore > score) {
					score = currentScore;
					currentHighestFeature = j;
				}
			}

			if (score < 0) {
				System.out.println("At selection " + noOfFeatures + ", mRMRD is negative with value " + score);
			}

			// Include most suitable feature from this iteration
			answerFeatures[i] = currentHighestFeature;
			unselectedFeatures[answerFeatures[i]] = false;
			relevanceFeatures[answerFeatures[i]] = score;
		}

		return relevanceFeatures;
	}

	/**
	 * Creates a relevance map of features when running the Information Gain
	 * feature selection algorithm
	 * 
	 * @param data
	 *            training data
	 * @return double[] relevanceFeatures
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static double[] InfoGain_RelevanceMap(Instances data) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		// int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures
		// : k;

		double[] relevanceFeatures = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			relevanceFeatures[(int) selectionMatrix[i][0]] = selectionMatrix[i][1];
		}

		return relevanceFeatures;
	}

	/**
	 * Selects optimal k features according to the dispersion-sensitive mRMR
	 * (mRMRMAD-D) algorithm
	 * 
	 * @param k
	 *            number of features to be selected
	 * @param data
	 *            training data
	 * @param featureMADs
	 *            cross-environmental normalized variances of the features in
	 *            sequence
	 * @return int[] answerFeatures
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static int[] mRMRMAD_D(int k, Instances data, double alpha, double[] featureMADs) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures : k;

		int[] answerFeatures = new int[noOfAnswerFeatures];

		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);

		double[][] featureMIMatrix = new double[noOfAnswerFeatures][noOfFeatures];
		for (double[] row : featureMIMatrix)
			Arrays.fill(row, -1);

		double[] infoGain_minus_MAD = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			// MAD accounting
			infoGain_minus_MAD[(int) selectionMatrix[i][0]] = selectionMatrix[i][1]
					- alpha * featureMADs[(int) selectionMatrix[i][0]];
		}

		/*
		 * // The first feature is the one with the highest information gain
		 * answerFeatures[0] = infoGainRanking[0];
		 * unselectedFeatures[answerFeatures[0]] = false;
		 */

		// Discretize input data before proceeding
		Instances discrete_data;
		if (!evaluator.getBinarizeNumericAttributes()) {
			Discretize disTransform = new Discretize();
			disTransform.setUseBetterEncoding(true);
			disTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, disTransform);
		} else {
			NumericToBinary binTransform = new NumericToBinary();
			binTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, binTransform);
		}

		for (int i = 0; i < answerFeatures.length; i++) {
			double score = -100;
			int currentHighestFeature = -1;
			int numSelectedSoFar = i;

			for (int j = 0; j < noOfFeatures; j++) {
				if (!unselectedFeatures[j])
					continue;

				double currentMIScore = 0;
				for (int m = 0; m < numSelectedSoFar; m++) {
					if (featureMIMatrix[m][j] == -1) {
						featureMIMatrix[m][j] = getMutualInformation(j, answerFeatures[m], discrete_data);
					}
					currentMIScore += featureMIMatrix[m][j];
				}
				double currentScore = (numSelectedSoFar == 0) ? infoGain_minus_MAD[j]
						: infoGain_minus_MAD[j] - currentMIScore / numSelectedSoFar;
				if (currentScore > score) {
					score = currentScore;
					currentHighestFeature = j;
				}
			}

			/*
			 * if (score < 0) { System.out.println("At selection " +
			 * noOfFeatures + ", mRMRD is negative with value " + score); }
			 */

			// Include most suitable feature from this iteration
			answerFeatures[i] = currentHighestFeature;
			unselectedFeatures[answerFeatures[i]] = false;
		}

		return answerFeatures;
	}

	/**
	 * Selects optimal k features according to the dispersion-sensitive InfoGain
	 * algorithm (InfoGainMAD)
	 * 
	 * @param k
	 *            number of features to be selected
	 * @param data
	 *            training data
	 * @param featureMADs
	 *            cross-environmental normalized variances of the features in
	 *            sequence
	 * @return int[] answerFeatures
	 * @throws Exception
	 */
	@SuppressWarnings("unused")
	public static int[] InfoGainMAD(int k, Instances data, double alpha, double[] featureMADs) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures : k;

		int[] answerFeatures = new int[noOfAnswerFeatures];

		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);

		double[] infoGain_minus_MAD = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			// MAD accounting
			infoGain_minus_MAD[(int) selectionMatrix[i][0]] = selectionMatrix[i][1]
					- alpha * featureMADs[(int) selectionMatrix[i][0]];
		}

		for (int i = 0; i < answerFeatures.length; i++) {
			double score = -100;
			int currentHighestFeature = -1;
			int numSelectedSoFar = i;

			for (int j = 0; j < noOfFeatures; j++) {
				if (!unselectedFeatures[j])
					continue;

				double currentScore = infoGain_minus_MAD[j];
				if (currentScore > score) {
					score = currentScore;
					currentHighestFeature = j;
				}
			}

			/*
			 * if (score < 0) { System.out.println("At selection " +
			 * noOfFeatures + ", mRMRD is negative with value " + score); }
			 */

			// Include most suitable feature from this iteration
			answerFeatures[i] = currentHighestFeature;
			unselectedFeatures[answerFeatures[i]] = false;
		}

		return answerFeatures;
	}

	@SuppressWarnings("unused")
	public static int[] mRMRV_D_norm(int k, Instances data, double alpha, double[] varianceScores) throws Exception {
		int classIndex = data.classIndex();
		int noOfTraining = data.numInstances();
		int noOfFeatures = data.numAttributes() - 1;
		int noOfAnswerFeatures = (k > noOfFeatures || k == -1) ? noOfFeatures : k;

		int[] answerFeatures = new int[noOfAnswerFeatures];

		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);

		double[][] featureMIMatrix = new double[noOfAnswerFeatures][noOfFeatures];
		for (double[] row : featureMIMatrix)
			Arrays.fill(row, -1);

		double[] infoGains = new double[noOfFeatures];

		AttributeSelection selector = new AttributeSelection();
		InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
		Ranker ranker = new Ranker();

		selector.setEvaluator(evaluator);
		selector.setSearch(ranker);
		selector.SelectAttributes(data);

		int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
		int[] infoGainRanking = new int[noOfFeatures];
		for (int i = 0; i < infoGainRanking.length; i++)
			infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];

		double[][] selectionMatrix = selector.rankedAttributes();

		for (int i = 0; i < noOfFeatures; i++) {
			infoGains[(int) selectionMatrix[i][0]] = selectionMatrix[i][1];
		}

		double[] normInfoGains = featureScalingNormalize(infoGains);

		// The first feature is the one with the highest information gain
		answerFeatures[0] = infoGainRanking[0];
		unselectedFeatures[answerFeatures[0]] = false;

		// Discretize input data before proceeding
		Instances discrete_data;
		if (!evaluator.getBinarizeNumericAttributes()) {
			Discretize disTransform = new Discretize();
			disTransform.setUseBetterEncoding(true);
			disTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, disTransform);
		} else {
			NumericToBinary binTransform = new NumericToBinary();
			binTransform.setInputFormat(data);
			discrete_data = Filter.useFilter(data, binTransform);
		}

		for (int i = 1; i < answerFeatures.length; i++) {
			double score = -100;
			int currentHighestFeature = -1;
			int numSelectedSoFar = i;

			for (int j = 0; j < noOfFeatures; j++) {
				if (!unselectedFeatures[j])
					continue;

				for (int m = 0; m < numSelectedSoFar; m++) {
					if (featureMIMatrix[m][j] == -1) {
						featureMIMatrix[m][j] = getMutualInformation(j, answerFeatures[m], discrete_data);
					}
					// currentMIScore += featureMIMatrix[m][j];
				}

				double[] featureMIMatrixRow = new double[numSelectedSoFar];

				for (int i1 = 0; i1 < featureMIMatrixRow.length; i1++) {
					featureMIMatrixRow[i1] = featureMIMatrix[i1][j];
				}

				double[] normFeatureMIMatrixRow = featureScalingNormalize(featureMIMatrixRow);

				double currentNormMIScore = 0;
				for (int i1 = 0; i1 < normFeatureMIMatrixRow.length; i1++) {
					currentNormMIScore += normFeatureMIMatrixRow[i1];
				}

				double currentScore = normInfoGains[j] - currentNormMIScore / numSelectedSoFar
						- alpha * varianceScores[j]; // MRMRV_D step
				System.out.println("currentScore " + currentScore);

				if (currentScore > score) {
					score = currentScore;
					currentHighestFeature = j;
				}
			}

			if (score < 0) {
				System.out.println("At selection " + noOfFeatures + ", mRMRD is negative with value " + score);
			}

			// Include most suitable feature from this iteration
			answerFeatures[i] = currentHighestFeature;
			unselectedFeatures[answerFeatures[i]] = false;
		}

		return answerFeatures;
	}

	@SuppressWarnings("unused")
	public static int[] mRMR_D_minEnvs(int k, Instances[] data) throws Exception {
		double[][][] featureMIMatrix;
		int classIndex = data[0].classIndex();
		int noOfFeatures = data[0].numAttributes() - 1;
		int noOfAnswerFeatures = k > noOfFeatures || k == -1 ? noOfFeatures : k;
		int[] answerFeatures = new int[noOfAnswerFeatures];
		boolean[] unselectedFeatures = new boolean[noOfFeatures];
		Arrays.fill(unselectedFeatures, Boolean.TRUE);
		double[][][] arrd = featureMIMatrix = new double[data.length][noOfAnswerFeatures][noOfFeatures];
		int n = arrd.length;
		int n2 = 0;
		while (n2 < n) {
			double[][] mtrx;
			double[][] arrd2 = mtrx = arrd[n2];
			int n3 = arrd2.length;
			int n4 = 0;
			while (n4 < n3) {
				double[] row = arrd2[n4];
				Arrays.fill(row, -1.0);
				++n4;
			}
			++n2;
		}
		double[][] infoGains = new double[data.length][noOfFeatures];
		int env = 0;
		while (env < data.length) {
			AttributeSelection selector = new AttributeSelection();
			InfoGainAttributeEval evaluator = new InfoGainAttributeEval();
			Ranker ranker = new Ranker();
			selector.setEvaluator((ASEvaluation) evaluator);
			selector.setSearch((ASSearch) ranker);
			selector.SelectAttributes(data[env]);
			int[] infoGainRankingIncludingClassIndex = selector.selectedAttributes();
			int[] infoGainRanking = new int[noOfFeatures];
			int i = 0;
			while (i < infoGainRanking.length) {
				infoGainRanking[i] = infoGainRankingIncludingClassIndex[i];
				++i;
			}
			double[][] selectionMatrix = selector.rankedAttributes();
			int i2 = 0;
			while (i2 < noOfFeatures) {
				infoGains[env][(int) selectionMatrix[i2][0]] = selectionMatrix[i2][1];
				++i2;
			}
			++env;
		}
		double[] infoGainMin = new double[noOfFeatures];
		int f = 0;
		while (f < noOfFeatures) {
			double[] infoGainEnvs = new double[data.length];
			int e = 0;
			while (e < data.length) {
				infoGainEnvs[e] = infoGains[e][f];
				++e;
			}
			infoGainMin[f] = CustomMIToolbox.minElementDoubleArray(infoGainEnvs);
			++f;
		}
		answerFeatures[0] = CustomMIToolbox.findIndex(infoGainMin, CustomMIToolbox.maxElementDoubleArray(infoGainMin));
		unselectedFeatures[answerFeatures[0]] = false;
		Instances[] discrete_data = new Instances[data.length];
		int env2 = 0;
		while (env2 < discrete_data.length) {
			Discretize disTransform = new Discretize();
			disTransform.setUseBetterEncoding(true);
			disTransform.setInputFormat(data[env2]);
			discrete_data[env2] = Filter.useFilter((Instances) data[env2], (Filter) disTransform);
			++env2;
		}
		int i = 1;
		while (i < answerFeatures.length) {
			int numSelectedSoFar = i;
			double[][] envRelScore = new double[discrete_data.length][noOfFeatures];
			int j = 0;
			while (j < noOfFeatures) {
				if (unselectedFeatures[j]) {
					int env3 = 0;
					while (env3 < discrete_data.length) {
						double currentMIScore = 0.0;
						int m = 0;
						while (m < numSelectedSoFar) {
							if (featureMIMatrix[env3][m][j] == -1.0) {
								featureMIMatrix[env3][m][j] = CustomMIToolbox.getMutualInformation(j, answerFeatures[m],
										discrete_data[env3]);
							}
							currentMIScore += featureMIMatrix[env3][m][j];
							++m;
						}
						envRelScore[env3][j] = infoGains[env3][j] - currentMIScore / (double) numSelectedSoFar;
						++env3;
					}
				}
				++j;
			}
			double[] minRelevance = new double[noOfFeatures];
			int f2 = 0;
			while (f2 < noOfFeatures) {
				if (!unselectedFeatures[f2]) {
					minRelevance[f2] = -999.0;
				} else {
					double[] relEnvs = new double[discrete_data.length];
					int e = 0;
					while (e < discrete_data.length) {
						relEnvs[e] = envRelScore[e][f2];
						++e;
					}
					minRelevance[f2] = CustomMIToolbox.minElementDoubleArray(relEnvs);
				}
				++f2;
			}
			answerFeatures[i] = CustomMIToolbox.findIndex(minRelevance,
					CustomMIToolbox.maxElementDoubleArray(minRelevance));
			unselectedFeatures[answerFeatures[i]] = false;
			++i;
		}
		return answerFeatures;
	}

	private static int findIndex(double[] arr, double el) throws Exception {
		int i = 0;
		while (i < arr.length) {
			if (arr[i] == el) {
				return i;
			}
			++i;
		}
		throw new Exception("Element" + el + "not found!");
	}

	private static double[] featureScalingNormalize(double[] arr) {
		if (arr.length == 1)
			return arr;

		double arr_max = maxElementDoubleArray(arr);
		double arr_min = minElementDoubleArray(arr);

		if ((arr_max - arr_min) == 0)
			return arr;

		double[] normArr = new double[arr.length];
		for (int i = 0; i < arr.length; i++) {
			normArr[i] = (arr[i] - arr_min) / (arr_max - arr_min);
		}
		return normArr;
	}

	private static double minElementDoubleArray(double[] arr) {
		double min = arr[0];
		for (double d : arr)
			if (d < min)
				min = d;
		return min;
	}

	private static double maxElementDoubleArray(double[] arr) {
		double max = arr[0];
		for (double d : arr)
			if (d > max)
				max = d;
		return max;
	}

	/**
	 * Computes I(X;Y)
	 * 
	 * @param posX
	 *            index of att X
	 * @param posY
	 *            index of att Y
	 * @param data
	 *            training data
	 * @return int[] list of selected k features
	 * @throws Exception
	 */
	public static double getMutualInformation(int posX, int posY, Instances data) {
		// get number of states per attribute
		int nx = data.attribute(posX).numValues();
		int ny = data.attribute(posY).numValues();

		// compute necessary distributions
		double[] px = getMarginalProb(posX, data);
		double[] py = getMarginalProb(posY, data);
		double[][] pxy = getJointXY(posX, posY, data);

		// compute mutual information
		double mi = 0.0;
		for (int y = 0; y < ny; y++)
			for (int x = 0; x < nx; x++)
				if (pxy[x][y] == 0.0)
					mi += 0.0;
				else
					mi += (pxy[x][y] * Utils.log2(pxy[x][y] / (px[x] * py[y])));

		return mi;
	}

	/**
	 * Computes marginal probability for attribute with index pos, in data
	 * 
	 * @return double[] marginal probabilities of index pos
	 */
	public static double[] getMarginalProb(int pos, Instances data) {
		int nv = data.attribute(pos).numValues();
		double[] prob = new double[nv];
		double tot = data.numInstances();

		Instance row = null;
		for (int j = 0; j < data.numInstances(); j++) {
			row = data.instance(j);
			prob[(int) row.value(pos)]++;
		}

		// normalize
		for (int i = 0; i < nv; i++)
			prob[i] /= tot;

		return prob;
	}

	/**
	 * Compute joint probability por attribute pX and pY in data
	 * 
	 * @return double[][] joint probabilities
	 */
	public static double[][] getJointXY(int pX, int pY, Instances data) {
		int nvX = data.attribute(pX).numValues();
		int nvY = data.attribute(pY).numValues();
		double[][] prob = new double[nvX][nvY];
		double tot = data.numInstances();

		for (int i = 0; i < nvX; i++)
			for (int j = 0; j < nvY; j++)
				prob[i][j] = 0.0;

		Instance row = null;

		for (int j = 0; j < data.numInstances(); j++) {
			row = data.instance(j);
			prob[(int) row.value(pX)][(int) row.value(pY)]++;
		}

		// normalize
		for (int i = 0; i < nvX; i++)
			for (int j = 0; j < nvY; j++) {
				prob[i][j] /= tot;
			}

		return prob;
	}

	/**
	 * Compute joint probability por attribute pX, pY and pZ in data
	 * 
	 * @return double[][] joint probabilities
	 */
	protected double[][][] getJointXYZ(int pX, int pY, int pZ, Instances data) {
		int nvX = data.attribute(pX).numValues();
		int nvY = data.attribute(pY).numValues();
		int nvZ = data.attribute(pZ).numValues();
		double[][][] prob = new double[nvX][nvY][nvZ];
		double tot = data.numInstances();

		for (int i = 0; i < nvX; i++)
			for (int j = 0; j < nvY; j++)
				for (int k = 0; k < nvZ; k++)
					prob[i][j][k] = 0.0;

		Instance row = null;
		for (int j = 0; j < data.numInstances(); j++) {
			row = data.instance(j);
			prob[(int) row.value(pX)][(int) row.value(pY)][(int) row.value(pZ)]++;
		}

		// normalize
		for (int i = 0; i < nvX; i++)
			for (int j = 0; j < nvY; j++)
				for (int k = 0; k < nvZ; k++) {
					prob[i][j][k] /= tot;
				}

		return prob;
	}
	
	public static double evaluateSVM(Instances train, Instances test, double c, double gamma) throws Exception{
		
		LibSVM classifier = new LibSVM();
		String options = "-S 0 -K 2 -D 3 -G " + gamma + " -R 0.0 -N 0.5 -M 40.0 -C " + c + " -E 0.001 -P 0.1 -W \"1.0 1.0\" -seed 1";
		classifier.setOptions(weka.core.Utils.splitOptions(options));
		classifier.buildClassifier(train);
		
		Evaluation eval = new Evaluation(train);
		eval.evaluateModel(classifier, test);
		
		return eval.pctCorrect();
	}
	
	public static double[] crossValidateFoldStats(String classname, Instances data, int folds, String[] options, Random rand) throws Exception
	{
		Instances randData = new Instances(data);
		randData.randomize(rand);
	    if (randData.classAttribute().isNominal())
	      randData.stratify(folds);
	    
	    Classifier cls = (Classifier) Utils.forName(Classifier.class, classname, options);
	    
	    double[] accFolds = new double[folds];
	    Evaluation evalAll = new Evaluation(randData);
	    for (int n = 0; n < folds; n++) {
	      Evaluation eval = new Evaluation(randData);
	      Instances train = randData.trainCV(folds, n);
	      Instances test = randData.testCV(folds, n);
	      // the above code is used by the StratifiedRemoveFolds filter, the
	      // code below by the Explorer/Experimenter:
	      // Instances train = randData.trainCV(folds, n, rand);

	      // build and evaluate classifier
	      Classifier clsCopy = AbstractClassifier.makeCopy(cls);
	      clsCopy.buildClassifier(train);
	      eval.evaluateModel(clsCopy, test);
	      evalAll.evaluateModel(clsCopy, test);
	      accFolds[n] = eval.pctCorrect();
	      // output evaluation
	      //System.out.println();
	      //System.out.println(eval.toMatrixString("=== Confusion matrix for fold " + (n+1) + "/" + folds + " ===\n"));
	    }
	    
	    System.out.println("Overall result="+evalAll.pctCorrect());
	    
		return accFolds;
	}
	
}
