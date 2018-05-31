#define _precision 20 // Q11.20
#define _fx_one (1 << _precision) // 0x100000

#include "DecisionFunction.h"
#include <cmath>
#include <iostream>
using namespace std;

void DecisionFunction::Normalize(float* featureVector, uint32_t* features_normalized)
{
	for (uint8_t i = 0; i < nFeature; i++)
	{
		features_normalized[i] = Double_to_Fixed((featureVector[i] - feature_min[i]) * scalingFactors[i]);
	}
}

float DecisionFunction::Kernel(uint32_t *sv, uint32_t* features_normalized)
{
	float res = 0;
	uint64_t sum = 0;

	for (uint8_t i = 0; i < nFeature; i++)
	{
		int32_t tmp = features_normalized[i] - sv[i];
        uint64_t prod_fixed = Fixed_Point_Mult(tmp, tmp);
        cout << "prod_fixed: " << prod_fixed << "\t tmp: " << (int64_t)tmp <<endl;
        sum += prod_fixed;
	}
    //cout << "sum:" << sum << endl;
	double d_sum = Fixed_to_Double(sum);
	//cout << "d_sum:" << d_sum << endl;
	res = (float)exp(-gamma*d_sum);
    //cout << "res: " << res << "\t d_sum: " << d_sum << "\t gamma: " << gamma << endl;
	return res;
}

double DecisionFunction::Decide(uint32_t* features_normalized)
{
	double decision = -rho;
	uint32_t sv1row[nFeature];

	for (uint16_t i = 0; i < nSV; i++) {
		for (uint16_t j = i*nFeature, k = 0; j < (i + 1)*nFeature; j++, k++) {
			sv1row[k] = sv1dArr[j];
		}
		decision += weight[i] * Kernel(sv1row, features_normalized);
	}

	return decision;
}

int32_t DecisionFunction::Double_to_Fixed(double d) {

	double temp = d * _fx_one;
	temp += (temp >= 0) ? 0.5f : -0.5f;
	return (int32_t)temp;
}

uint64_t DecisionFunction::Fixed_Point_Mult(int32_t tmp, int32_t tmp2) {
	uint64_t product = ((int64_t)tmp * (int64_t)tmp2) >> _precision;
	return product;
}

double DecisionFunction::Fixed_to_Double(uint64_t l) {
	return (double)l / _fx_one;
}

int main(int argc, const char* argv[])
{
	float features[] =
		//{ 7685023.382569,63512.589939,215,26,10.410714,128,11,127,125,11,122,0.666667 }; // some random cow
	//{ 241121557.202754,136690.225172,4114,105,119.045884,128,3.676471,128,128,99,128,0.205882 }; // osu_farm_meadow_may24_1_cut39.data
		//{ 40898322.636344,113291.752455,1909,115.5,69.829167,127,12.454545,123,118,314,101,2.636364 }; // osu_farm_meadow_may24_1_cut992.data
		//{ 47231863.105222, 118079.657763, 2606, 153, 37.220588, 128, 13.666667, 126, 126, 581, 81, 3.583333 }; // Darree fields human 1
		//{ 371255481.575173,168064.95318,8351,192.5,291.050211,128,5.589744,128,128,3980,102,3.384615 }; // Darree fields human 2
	//{ 9233365.291093,76308.804059,214,26.5,35.071429,125,11.333333,125,39,8,-1,0.333333 }; // Darree fields human 3 -- misclassified
	//{ 59781810.85877,135559.661811,3102,173,168.117647,128,14.923077,128,127,1240,79,7.461538 }; // Darree fields human 4
	//{ 98152552.104718,157044.083368,3425,161.5,416.893939,128,10.823529,126,125,1075,79,4.882353 }; // Darree fields human 5
	//{ 52207336.55521,203934.908419,473,38,118.25641,112,6.5,58,53,54,49,0.75 };	// Single human 1
	//{ 111153078.66534, 252047.797427, 858, 59.5, 487.411765, 77, 6, 75, 58, 129, 52, 1.230769 };	// Single human 2 -- misclassified
	//{ 92784390.901157, 231960.977253, 457, 26, 35.610294, 73, 3, 67, 66, 34, 56, 0.5 };	// Gym ball 1
	//{ 167137534.571501, 173920.431396, 1154, 41.5, 139.730159, 124, 2.826087, 108, 65, 235, 55, 0.652174 };	// Gym ball 2
	//{ 317805058.264072,180161.597655,5468,139,78.009447,128,4.705882,125,124,735,100,0.794118 }; // osu_farm_meadow_may24_1_cut761.data
	//{ 17335144.679568,67715.408905,2790,252,2323.923077,128,32,128,128,1883,128,31.875 }; // Single human 3
	 
	/*eMote - 15 second snippet features (displacement detection short-circuited by setting IQR to 0)*/
	//{ 19440,5,7373,131,29.6961231,128,2.65384626,126,118,1984,62,0.884615362 }; //  osu_farm_meadow_may24_1_cut992.data
	//{ 34920,9,7659,137,85.6654129,128,2.86538458,128,128,449,110,0.288461536 }; // osu_farm_meadow_may24_1_cut761.data
	//{ 8640,8,5088,175,38.6132851,128,7.875,128,128,1285,100,2.29166675 }; // Darree_Fields_grass_17_Oct_2016_cut2.data
	//{ 3760,9,1512,104,2536.43408,127,12.833333,126,95,486,79,4.91666651 }; // 4503-032_cut1.data -- misclassified

	/*Austere human sets*/
	{153726636.293502,132981.519285,2086,81,842.346237,113,3.846154,96,96,710,73,1.538462};
	//{212512620.808148,183834.447066,1965,45608,4,88,0.3,72,72,155,48,0.1};
	//{279775956.759226,242020.72384,1535,45608,3,88,0.266667,72,72,153,48,0.1}; //Dec: 0.015521
	//{43754378.309318,170915.540271,442,6600,2,48,0.5,40,40,25,-1,0.083333};
	//{57878305.081753,295297.474907,125,3280,0,40,0.8,40,40,0,-1,0};
	//{225053121.871711,250059.024302,995,23992,2,72,0.307692,72,56,95,32,0.076923};
	//{287873104.375032,249025.176795,1395,36968,3,96,0.266667,64,56,135,48,0.1};
	//{432869508.265375,245390.877701,2044,56896,3,96,0.236842,72,64,190,48,0.078947};
	//{577285772.35899,250558.06092,2565,76816,4,88,0.204545,72,72,175,56,0.090909};
	//{805129107.56863,239336.833403,2801,83320,3,88,0.185185,88,80,142,48,0.055556};
	//{909203632.264781,252556.564518,3036,96216,3,88,0.196429,80,72,170,56,0.035714};
	//{204815565.252777,227572.850281,1531,45904,3,88,0.423077,72,72,90,48,0.076923};


	uint32_t features_norm[nFeature];

	DecisionFunction::Normalize(features, features_norm);

	/*for (int i = 0; i < 12; i++)
		cout << "featureVector[" << i << "]=" << features_norm[i] << endl;*/

	double dec = DecisionFunction::Decide(features_norm);

	cout << "The decision is " << dec << endl;
	//system("PAUSE");
	return 0;
}
