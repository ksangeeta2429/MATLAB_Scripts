import weka.attributeSelection.userExtensions.CustomMIToolbox;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

public class CustomMIToolboxTest {

	public static void main(String[] args) throws Exception {
		/* WARNING: Do not discretize instances: will be handled in mRMR_D */
		DataSource source = new DataSource(args[0]);
		Instances data = source.getDataSet();

		if (data.classIndex() == -1)
			data.setClassIndex(data.numAttributes() - 1);

		double[] varScores = { 0.008115, 0.148439, 0.350125, 0.296199, 0.123723, 0.147641, 0.192644, 0.255090, 0.358600,
				0.362125, 0.044541, 0.201107, 0.017863, 0.033876, 0.051264, 0.011019, 0.181995, 0.000000, 0.568541,
				0.615695, 0.231163, 1.000000, 0.645966, 0.380110, 0.293929, 0.039734, 0.041742, 0.119716, 0.345925,
				0.444624, 0.054427, 0.785819, 0.622845, 0.196650, 0.545435, 0.090333, 0.066237, 0.114827, 0.516189,
				0.680880, 0.051316, 0.441192, 0.724719, 0.109403, 0.197684, 0.125246, 0.012113, 0.107161, 0.199905,
				0.167074, 0.037318, 0.149254, 0.233731, 0.463853, 0.287611, 0.313900, 0.015525, 0.088075, 0.000000,
				0.263287, 0.094747, 0.079332, 0.034394, 0.150097, 0.109857, 0.027709 };

		//int[] rankedAttributes = CustomMIToolbox.mRMRV_D_norm(20, data, 1.0, varScores);
		int[] rankedAttributes = CustomMIToolbox.mRMR_D(20, data);
		
		for (int i = 0; i < rankedAttributes.length; i++)
			System.out.println(rankedAttributes[i]);
	}

}
