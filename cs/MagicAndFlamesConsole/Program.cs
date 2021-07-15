using System;

namespace MagicAndFlames
{
    class Program
    {
        static void Main(string[] args)
        {
            Random random = new Random();
            SwordDamage swordDamage = new SwordDamage();

            while (true)
            {
                Console.Write("0 for no magic/flaming, 1 for magic, 2 for flaming, " +
                    "3 for both, anything else to quit: ");

                char key = Console.ReadKey().KeyChar;

                char[] opts = { '0', '1', '2', '3' };
                if (!Array.Exists(opts, x => x == key)) return;

                int roll = 0;
                for (int i = 0; i < 3; ++i)
                {
                    roll += random.Next(1, 7);
                }

                swordDamage.Roll = roll;
                swordDamage.SetMagic(key == '1' || key == '3');
                swordDamage.SetFlaming(key == '2' || key == '3');

                Console.WriteLine(String.Format("\nRolled {0} for {1} HP\n", roll, swordDamage.Damage));
            }
        }
    }
}
