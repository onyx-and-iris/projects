using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace RandomMenu
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();

            MakeTheMenu();
        }
        /// <summary>
        /// Generate a random menu, for items 3 and 4 initialize bagel field.
        /// </summary>
        private void MakeTheMenu()
        {
            MenuItem[] menuItems = new MenuItem[5];
            for (int i = 0; i < 5; i++)
            {
                if (i < 3)
                {
                    menuItems[i] = new MenuItem();
                } else {
                    menuItems[i] = new MenuItem()
                    {
                        Breads = new string[] { "plain bagel", "onion bagel",
                            "pumpernickel bagel", "everything bagel" }
                    };
                }
            }

            item1.Text = menuItems[0].GenerateMenuItem();
            price1.Text = menuItems[0].RandomPrice();
            item2.Text = menuItems[0].GenerateMenuItem();
            price2.Text = menuItems[0].RandomPrice();
            item3.Text = menuItems[0].GenerateMenuItem();
            price3.Text = menuItems[0].RandomPrice();
            item4.Text = menuItems[0].GenerateMenuItem();
            price4.Text = menuItems[0].RandomPrice();
            item5.Text = menuItems[0].GenerateMenuItem();
            price5.Text = menuItems[0].RandomPrice();

            MenuItem specialMenuItem = new MenuItem()
            {
                Proteins = new string[] { "Organic ham", "Mushroom patty", "Mortadella" },
                Breads = new string[] { "a gluten free roll", "a wrap", "pita" },
                Condiments = new string[] { "dijon mustard", "miso dressing", "au jus" }
            };

            item6.Text = specialMenuItem.GenerateMenuItem();
            price6.Text = specialMenuItem.RandomPrice();

            guacomole.Text = String.Format("Add guacomole for {0}", specialMenuItem.RandomPrice());
        }
    }
}
