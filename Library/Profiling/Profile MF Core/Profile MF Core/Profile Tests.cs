using System;
using Microsoft.SPOT;

namespace Samraksh.Profiling.Core {
    public partial class Program {
        private static long ProfileLoop() {
            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileIntAdd() {
            var result = 0;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA + paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }

        private static long ProfileIntSubtract() {
            var result = 0;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA - paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileIntMultiply() {
            var result = 0;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA * paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileIntDivide() {
            var result = 0;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA / paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileIntComparison() {
            bool result;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA < paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileIf() {
            bool result;
            var paramA = 100;
            var paramB = 200;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                if (true) ;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileAnd() {
            bool result;
            var paramA = true;
            var paramB = false;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA && paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
        private static long ProfileOr() {
            bool result;
            var paramA = true;
            var paramB = false;

            var startTime = DateTime.Now.Ticks;
            for (var i = 0; i < Iterations; i++) {
                result = paramA || paramB;
            }
            var endTime = DateTime.Now.Ticks;
            return endTime - startTime;
        }
    }


}
