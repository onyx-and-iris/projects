using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RandomMenu
{
    class MenuItem
    {
        public static Random Randomizer = new Random();

        public string[] Proteins = { "Roast beef", "Salami", "Turkey",
        "Ham", "Pastrami", "Tofu" };
        public string[] Condiments = { "yellow mustard", "brown mustard",
        "honey mustard", "mayo", "relish", "french dressing" };
        public string[] Breads = { "rye", "white", "wheat", "pumpernickel", "a roll" };

        public string GenerateMenuItem()
        {
            string randomProtein = Proteins[Randomizer.Next(Proteins.Length)];
            string randomCondiment = Condiments[Randomizer.Next(Condiments.Length)];
            string randomBread = Breads[Randomizer.Next(Breads.Length)];
            return string.Format("{0} with {1} on {2}", randomProtein, randomCondiment, randomBread);
        }

        public string RandomPrice()
        {
            decimal bucks = Randomizer.Next(2, 5);
            decimal cents = Randomizer.Next(1, 98);
            decimal price = bucks = (cents * 0.1M);
            return price.ToString("c");
        }
    }
}
