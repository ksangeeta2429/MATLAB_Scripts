/*-----------------------------------------------------------------------------
    Profile Core MF
-----------------------------------------------------------------------------*/

using System;
using System.Collections;
using System.Reflection;
using System.Text.RegularExpressions;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using Samraksh.AppNote.Utility;
using Math = System.Math;

namespace Samraksh.Profiling.Core {
    public partial class Program {

        private const int Iterations = 100000;
        private static readonly ArrayList TestMean = new ArrayList();
        private static long _loopOverhead;

        public static void Main() {

            Debug.Print("");
            VersionInfo.Init(Assembly.GetExecutingAssembly());
            Debug.Print("Profile MF Core - v. " + VersionInfo.Version + ", " + VersionInfo.BuildDateTime);
            Debug.Print("Iterations per test: " + Iterations);
            Debug.Print("Power level: " + PowerState.CurrentPowerLevel);
            Debug.Print("");

            ProfileIntAdd();    // Do it once to get things started; first one will show longer average

            _loopOverhead = ProfileLoop();
            Debug.Print("Loop Overhead: " + (_loopOverhead / ((double)(TimeSpan.TicksPerMillisecond) / 1000)) / Iterations);
            Debug.Print("");

            ReportMean("Int", "Add", ProfileIntAdd());
            ReportMean("Int", "Subtract", ProfileIntSubtract());
            ReportMean("Int", "Multiply", ProfileIntMultiply());
            ReportMean("Int", "Divide", ProfileIntDivide());
            ReportMean("Int", "Comparison", ProfileIntComparison());
            ReportMean("", "If", ProfileIf());
            ReportMean("Bool", "And", ProfileAnd());
            ReportMean("Bool", "Or", ProfileOr());
            Debug.Print("");

            Debug.Print("");
            foreach (var testMean in TestMean) {
                var tm = (testMean as TestMean);
                if (tm != null) Debug.Print("*," + tm.TestType + "," + tm.TestName + "," + tm.Mean);
            }
            Debug.Print("");
        }

        private static void ReportMean(string testType, string testName, long runTime) {
            runTime -= _loopOverhead;   // subtract loop overhead
            var meanElapsedTime = (runTime / ((double)(TimeSpan.TicksPerMillisecond) / 1000)) / Iterations;
            var fmtElapsedTime = FormatFloat(meanElapsedTime, 3);
            TestMean.Add(new TestMean(testType, testName, fmtElapsedTime));
            Debug.Print(testType + " " + testName + ": Mean " + fmtElapsedTime + " microsec");
        }

        private static string FormatFloat(double meanElapsedTime, int fracDigits) {
            //var fracPow = Math.Pow(10, fracDigits);
            //meanElapsedTime = Math.Round(meanElapsedTime * fracPow) / fracPow;
            var intRem = Regex.Split(@"\.", meanElapsedTime.ToString(), RegexOptions.None);
            var remStr = string.Empty;
            if (intRem.Length > 1) {
                remStr = intRem[1].Substring(0, Math.Min(fracDigits, intRem[1].Length));
            }
            return intRem[0] + (remStr == string.Empty ? "" : "." + remStr);
        }

    }

    class TestMean {
        public string TestType;
        public string TestName;
        public string Mean;

        public TestMean(string testType, string testName, string mean) {
            TestType = testType;
            TestName = testName;
            Mean = mean;
        }

    }
}
