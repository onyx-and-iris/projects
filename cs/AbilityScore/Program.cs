using System;

namespace AbilityScore
{
    class Program
    {
        static void Main(string[] args)
        {
            AbilityScoreCalculator calculator = new AbilityScoreCalculator();
            while (true)
            {
                calculator.Roll = ReadInt(calculator.Roll, "Starting 4d6 roll");
                calculator.DivideBy = ReadDouble(calculator.DivideBy, "Divide by");
                calculator.AddAmount = ReadInt(calculator.AddAmount, "Add amount");
                calculator.Minimum = ReadInt(calculator.Minimum, "Minimum");
                calculator.CalculateAbilityScore();

                Console.WriteLine(String.Format("Calculated ability score: {0}", calculator.Score));
                Console.WriteLine("Press Q to quit, any other key to continue");
                char keyChar = Console.ReadKey(true).KeyChar;
                if ((keyChar == 'Q') || (keyChar == 'q')) return;
            }
        }

        /// <summary>
        /// Write a prompt and reads an int value from stdin.
        /// </summary>
        /// <param name="lastUsedValue"></param>
        /// <param name="prompt"></param>
        /// <returns></returns>
        private static int ReadInt(int lastUsedValue, string prompt)
        {
            Console.WriteLine(String.Format("{0} [{1}]:", prompt, lastUsedValue));
            string value = Console.ReadLine();
            if (int.TryParse(value, out int result)){
                Console.WriteLine(String.Format("Using value {0}", value));
                return result;
            }
            else
            {
                Console.WriteLine(String.Format("Using default value {0}", lastUsedValue));
                return lastUsedValue;
            }
        }

        /// <summary>
        /// Write a prompt and reads a double value from stdin.
        /// </summary>
        /// <param name="lastUsedValue"></param>
        /// <param name="prompt"></param>
        /// <returns></returns>
        private static double ReadDouble(double lastUsedValue, string prompt)
        {
            Console.WriteLine(String.Format("{0} [{1}]:", prompt, lastUsedValue));
            string value = Console.ReadLine();
            if (double.TryParse(value, out double result))
            {
                Console.WriteLine(String.Format("Using value {0}", value));
                return result;
            }
            else
            {
                Console.WriteLine(String.Format("Using default value {0}", lastUsedValue));
                return lastUsedValue;
            }
        }
    }
}
