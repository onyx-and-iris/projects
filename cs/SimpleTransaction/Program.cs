using System;

namespace Transaction
{
    class Program
    {
        static void Main(string[] args)
        {
            Guy Joe = new Guy() {name = "Joe", cash = 100};
            Guy Bob = new Guy() {name = "Bob", cash = 150};

            while (true)
            {
                Console.Write("Please enter an amount (or 'q' to quit): ");
                string amount = Console.ReadLine();
                if (amount == "q") return;

                if (int.TryParse(amount, out int result))
                {
                    Console.Write("Who should give the cash? ");
                    string cashGiver = Console.ReadLine();

                    int amountGiven = 0;
                    switch (cashGiver)
                    {
                        case "Joe":
                            amountGiven = Joe.GiveCash(result);
                            Bob.TakeCash(amountGiven);
                            break;
                        case "Bob":
                            amountGiven = Bob.GiveCash(result);
                            Joe.TakeCash(amountGiven);
                            break;
                        default:
                            Console.WriteLine("Please enter Joe or Bob");
                            break;
                    }
                    transactionSummary(Joe, Bob, cashGiver, amountGiven);
                }
                else
                {
                    Console.WriteLine("Error: Please enter a numeric value or 'q' to exit");
                }
            }
        }

        static void transactionSummary(Guy Joe, Guy Bob, string cashGiver, int amountTransferred)
        {
            Joe.Summary(cashGiver, amountTransferred);
            Bob.Summary(cashGiver, amountTransferred);
        }
    }
}
