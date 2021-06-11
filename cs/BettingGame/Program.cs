using System;
using System.Collections.Generic;

namespace Betting
{
    class Program
    {
        static void Main(string[] args)
        {
            int MAX_PLAYERS = 3;
            double odds = 0.75;
            SortedList<int, string> playerList = new SortedList<int, string>()
            {
                { 0, "Bob" },
                { 1, "Bill" },
                { 2, "Joe" },
            };
            Guy[] players = InitializeArray<Guy>(MAX_PLAYERS);

            for ( int i = 0; i < MAX_PLAYERS; ++i )
            {
                players[i] = new Guy() { name = playerList[i], cash = 100 };
            }

            Console.WriteLine(String.Format("Welcome to the casino. The odds are {0}", odds));
            startBets(MAX_PLAYERS, odds, players);
        }

        /// <summary>
        /// Helper method:
        /// Initialize an array of type T objects as well as each element.
        /// </summary>
        /// <typeparam name="T">
        /// Placeholder for array of type T.
        /// </typeparam>
        /// <param name="length">
        /// Number of elements in the array.
        /// </param>
        /// <returns>
        /// An array of type T
        /// </returns>
        static T[] InitializeArray<T>(int length) where T : new()
        {
            T[] array = new T[length];
            for (int i = 0; i < length; ++i)
            {
                array[i] = new T();
            }

            return array;
        }

        static void startBets(int MAX_PLAYERS, double odds, Guy[] players)
        {
            Random random = new Random();
            int playersRemaining = MAX_PLAYERS;

            while (playersRemaining > 0)
            {
                for (int i = 0; i < MAX_PLAYERS; ++i)
                {
                    if (players[i].cash > 0) {
                        Console.WriteLine(String.Format("Player {0} has {1} bucks left to bet", players[i].name, players[i].cash));
                        Console.Write(String.Format("How much would {0} like to bet? (or 'q' to quit) ", players[i].name));
                        string amount = Console.ReadLine();
                        if (amount == "q") return;

                        if (int.TryParse(amount, out int result))
                        {
                            int pot = 2 * result;

                            if (random.NextDouble() > odds)
                            {
                                players[i].TakeCash(pot);
                            }
                            else
                            {
                                players[i].GiveCash(result);
                            }
                        }
                        else
                        {
                            Console.WriteLine("Error, please enter numeric value");
                        }

                        if (players[i].cash == 0)
                        {
                            Console.WriteLine("Sorry, you're out of luck today, see you next time!");
                            --playersRemaining;
                        }
                    }
                }
            }
        }
    }
}
