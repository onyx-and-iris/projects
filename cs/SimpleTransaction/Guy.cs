using System;
using System.Collections.Generic;
using System.Text;

namespace Transaction
{
    class Guy
    {
        public Guy()
        {
        }

        public string name { get; set; }
        public int cash { get; set; }

        /// <summary>
        /// Write the transaction summary to console. Included info:
        /// Give/receiver of cash.
        /// Amount each person has after transaction.
        /// Error if transaction was not valid.
        /// </summary>
        /// <param name="giver">The person who gave the cash</param>
        /// <param name="amountTransferred">The amount of cash transferred</param>
        public void Summary(string giver, int amountTransferred)
        {
            Console.WriteLine(
                String.Format("{0} just {1} {2} ", name, giver == name ? "gave" : "accepted", amountTransferred)
                );
            Console.WriteLine("{0} now has {1} bucks", name, cash);
        }

        /// <summary>
        /// Validation method to ensure amount given isn't negative.
        /// </summary>
        /// <param name="amount">
        /// amount of cash given.
        /// </param>
        /// <returns>
        /// amount subtracted from wallet or 0 if invalid number.
        /// </returns>
        public int GiveCash(int amount)
        {
            if (amount <= 0)
            {
                Console.WriteLine(String.Format("Error: {0} cannot hand a negative amount!", name));
                return 0;
            }
            else if (amount > cash)
            {
                Console.WriteLine(String.Format("Error: That is more than {0} can give!", name));
                return 0;
            }
            cash -= amount;
            return amount;
        }

        /// <summary>
        /// Validation method to ensure amount given isn't negative.
        /// </summary>
        /// <param name="amount">
        /// amount added to wallet.
        /// </param>
        public void TakeCash(int amount)
        {
            if (amount <= 0)
            {
                Console.WriteLine(String.Format("Error: {0} will not accept a negative amount!", name));
            }
            else
            {
                cash += amount;
            }
        }
    }
}
