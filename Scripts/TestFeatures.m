%%%%%% dummy data
    classLabel = '';
    ifScaled = 0;
    featureClass = 0;
    
    I = [3338, 3711, 521, 3742, 2591, 400, 1141, 2241, 3922, 3953, 646, 3976, 3921, 1989, 3278, 582, 1728, 3751, 3245, 3931, 2686, 147, 3479, 3826, 2781, 3104, 3044, 1607, 2685, 702, 2892, 131, 1135, 190, 398, 3373, 2847, 1299, 3893, 142, 1798, 1563, 3136, 3258, 766, 2007, 1826, 2648, 2906, 3092, 1131, 2785, 2684, 667, 488, 2042, 3932, 1395, 2398, 917, 3078, 1045, 2073, 2864, 3650, 3930, 2242, 568, 612, 1055, 3444, 1042, 3336, 998, 3807, 1434, 806, 1029, 2524, 1939, 1441, 3404, 2398, 2252, 3757, 1171, 3102, 3088, 1559, 2326, 311, 221, 2175, 3192, 3826, 533, 2330, 1923, 49, 1381, 665, 3254, 1275, 2165, 679, 2466, 1078, 2680, 2824, 3065, 1846, 344, 938, 3742, 625, 3383, 2206, 4081, 321, 1814, 437, 3940, 19, 3175, 3348, 3559, 346, 1638, 1065, 3278, 1768, 3731, 745, 1081, 597, 558, 3561, 2375, 2253, 594, 3495, 2548, 1438, 2103, 1646, 312, 983, 506, 754, 983, 1710, 204, 3698, 3870, 2011, 2004, 1384, 3687, 1513, 456, 3196, 1597, 990, 1655, 396, 541, 3859, 3917, 2357, 245, 962, 1447, 3364, 64, 177, 693, 2659, 2998, 2654, 1847, 2241, 1214, 3051, 774, 2814, 752, 1510, 2563, 3196, 333, 3807, 3178, 1994, 1786, 1831, 1255, 2083, 2093, 3350, 3256, 2640, 1551, 3325, 2183, 1437, 3847, 3588, 2254, 2550, 2405, 851, 1234, 1929, 945, 3459, 798, 926, 700, 933, 1785, 1275, 3783, 1763, 758, 3707, 4014, 1798, 456, 1058, 1675, 2437, 1075, 2470, 2914, 909, 481, 1216, 1306, 1738, 2081, 351, 1076, 3281, 120, 3805, 2992, 2002, 2370, 972, 1880, 3945, 2240, 2135, 949, 2003, 2557, 2228, 2954, 2141, 4071, 896, 434, 450, 261, 1658, 1837, 1499, 3128, 2572, 3163, 3821, 3985, 787, 569, 2852, 385, 2153, 2173, 3528, 1986, 1612, 2751, 3037, 2131, 1425, 615, 2401, 1074, 183, 3093, 995, 1813, 2818, 1472, 3017, 1617, 2800, 2884, 1812, 81, 1356, 1738, 1108, 808, 3366, 1761, 3637, 1603, 3151, 1626, 3312, 3093, 1546, 885, 3238, 3889, 1342, 2750, 1797, 3415, 3150, 686, 3531, 4055, 2108, 3623, 2409, 634, 819, 1667, 3067, 3382, 3236, 1305, 2188, 369, 458, 559, 2780, 2029, 778, 2028, 605, 226, 3485, 2297, 3808, 2854, 2388, 3340, 3601, 4051, 3, 3545, 2510, 4055, 2162, 1965, 3283, 934, 2041, 3690, 2354, 3462, 3026, 2401, 1011, 2730, 342, 2564, 2708, 2990, 3649, 4024, 3150, 2382, 3803, 2377, 70, 496, 3534, 1984, 3461, 858, 2263, 2581, 132, 2518, 1485, 203, 2006, 789, 505, 842, 601, 775, 175, 2602, 1155, 2207, 2848, 2045, 2195, 1824, 508, 2009, 3494, 3580, 1108, 854, 2315, 2623, 1709, 844, 3883, 337, 433, 582, 682, 2544, 2350, 214, 3815, 2985, 3023, 260, 3525, 3828, 4033, 3519, 3218, 2103, 728, 1633, 549, 127, 3847, 1235, 1211, 1364, 1914, 2656, 104, 3450, 2290, 3499, 1425, 1827, 223, 726, 2715, 1356, 3681, 484, 4049, 2212, 2896, 4094, 1180, 1698, 1904, 3130, 3352, 411, 730, 1474, 233, 2138, 1376, 720, 856, 3708, 2767, 1919, 3737, 427, 3054, 3016, 2302, 755, 2447, 1229, 550, 871, 3666, 293, 994, 221, 1810, 55, 3675, 806, 383, 1259, 1869, 417, 4078, 1361, 1218, 255, 1222, 190, 2071, 3119, 2585, 369, 332, 3184, 3708, 2187, 448, 3383];
    Q = [2782, 1621, 1506, 4047, 155, 3626, 3741, 3262, 405, 1073, 1374, 2785, 560, 2955, 438, 2678, 2025, 3191, 2929, 3702, 3650, 1369, 2863, 811, 126, 3048, 2049, 1966, 3706, 2499, 2530, 3521, 3300, 2363, 750, 983, 3632, 118, 2007, 688, 4009, 2920, 2050, 1930, 245, 2794, 174, 293, 2137, 397, 3352, 3349, 2960, 614, 2702, 2125, 3986, 2659, 3279, 1859, 1772, 3381, 342, 546, 711, 1602, 3406, 3291, 248, 1636, 2159, 1708, 2691, 2573, 1196, 1769, 64, 4031, 685, 436, 1526, 812, 2006, 1391, 3898, 3770, 216, 3023, 1103, 1732, 2245, 3862, 1712, 4027, 1235, 2872, 2730, 2209, 2860, 2731, 730, 525, 4093, 701, 134, 2299, 3613, 2741, 781, 1512, 1888, 4021, 641, 3505, 2641, 1542, 783, 1755, 1975, 495, 2415, 927, 1576, 2388, 1032, 1190, 2528, 1087, 3377, 4025, 2992, 1409, 2393, 442, 3713, 3604, 3350, 1068, 2435, 93, 1742, 1281, 662, 733, 1733, 386, 2452, 1929, 2851, 2867, 2616, 138, 282, 1310, 2175, 2681, 1670, 3359, 2943, 3968, 2177, 1332, 433, 2503, 3190, 1735, 373, 1092, 630, 1151, 1803, 2160, 1874, 3586, 2122, 3866, 2613, 3923, 986, 2770, 1185, 2752, 2848, 279, 1044, 918, 2736, 3459, 1411, 3198, 2767, 28, 2467, 1585, 3752, 5, 1895, 1739, 1888, 3155, 1321, 3215, 1931, 147, 721, 2957, 1940, 626, 1398, 2488, 786, 3025, 995, 3758, 1103, 3136, 773, 1178, 374, 2361, 2800, 2239, 1744, 2640, 2653, 2782, 2605, 3872, 856, 2906, 968, 490, 2488, 1844, 1879, 2712, 3156, 1435, 2712, 1705, 3449, 3412, 1051, 2513, 2385, 2215, 3564, 1085, 1303, 489, 3850, 2645, 1964, 2619, 2232, 2652, 1385, 1205, 3057, 43, 199, 2736, 2472, 2155, 2989, 2897, 3201, 1180, 2837, 2281, 1625, 253, 3196, 1383, 2490, 3037, 430, 524, 2251, 1988, 3648, 3273, 3008, 211, 299, 363, 3271, 3863, 2801, 542, 2961, 453, 482, 2625, 1347, 2679, 3069, 2389, 3032, 962, 3011, 3976, 3551, 354, 1501, 1513, 2806, 2450, 3234, 1506, 844, 355, 3162, 843, 1591, 2261, 938, 2630, 1985, 622, 3203, 413, 1205, 973, 2175, 375, 1661, 430, 460, 3214, 1195, 2473, 3951, 1772, 2846, 3106, 1773, 2685, 450, 3825, 768, 1091, 3268, 1998, 3150, 1623, 1118, 153, 2758, 1760, 1851, 2498, 244, 1294, 3166, 2853, 514, 534, 379, 33, 1734, 2686, 2962, 2176, 446, 2588, 519, 551, 404, 582, 690, 804, 1301, 1297, 892, 1029, 3658, 2881, 2277, 756, 869, 317, 3743, 2895, 2285, 1284, 681, 2550, 4047, 699, 1056, 1626, 304, 2803, 1649, 4026, 1648, 2543, 633, 1562, 661, 3106, 3569, 1437, 2808, 1205, 2174, 3410, 2448, 1374, 1226, 1854, 1732, 1473, 2287, 3042, 1739, 1759, 512, 101, 1189, 1301, 2678, 3920, 3833, 1876, 985, 3129, 3111, 3034, 3047, 434, 2792, 1898, 870, 404, 3374, 717, 670, 2728, 3664, 2116, 2879, 630, 3906, 2216, 2785, 150, 3315, 3067, 493, 2151, 1335, 2239, 1634, 1701, 741, 1047, 85, 3784, 2678, 3820, 670, 3773, 3255, 2366, 1803, 1056, 3080, 937, 263, 3143, 2750, 2930, 2630, 1717, 1601, 3343, 1301, 3337, 3233, 3491, 2072, 2604, 3895, 1819, 246, 3551, 2586, 1455, 4084, 919, 2673, 2479, 1587, 583, 103, 1725, 755, 2973, 1518, 3448, 3008, 2339, 725, 3922, 1087, 3788, 917, 1531, 359, 2622];
    I=I'; Q=Q';
    Data = (I-2048) + i*(Q-2048);
    
    
    
%     bkfFleName = 'C:\Users\he\Documents\Dropbox\MyMatlabWork\radar\IIITDemo\Data\Noise\noise2.data';
%     [I,Q,~] = Data2IQ(ReadBin(bkfFleName));
%     BkData = (I-median(I)) + i*(Q-median(Q));
    
    
    Rate=256;
    FftWindow = Rate;
    FftStep = round(1/4*FftWindow);
    
    Freq = FftFreq(FftWindow, Rate);
    
    if (~isempty(BkData))
        BackStats = ComputeBack(BkData, FftWindow,FftStep);
    else
        BackStats = ComputeBack(Data, FftWindow,FftStep);
    end
    meanBack = BackStats(1:FftWindow);
    stdBack = BackStats(FftWindow+1:2*FftWindow);
    
    
    % generate the thr used in c#
    tmp = ((meanBack+3*stdBack)/16).^2   % *40
    %GenerateArrInCsharp
    
   Img = AnomImage(Data, FftWindow, FftStep, Rate, meanBack, stdBack*50, 3)
   
   
   M=2;
   N=8;
   Result = FreqWidthMeas(Img, M, N)