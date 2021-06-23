using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AbilityScore
{
    class AbilityScoreCalculator
    {
        public int Roll = 14;
        public double DivideBy = 1.75;
        public int AddAmount = 2;
        public int Minimum = 3;
        public int Score;

        public void CalculateAbilityScore()
        {
            // Divide the starting roll
            double divided = Roll / DivideBy;

            // Add to the result
            int added = AddAmount + (int)divided;

            // Make sure it's greater than the minimum
            if (added < Minimum)
                Score = Minimum;
            else
                Score = added;
        }
    }
}
