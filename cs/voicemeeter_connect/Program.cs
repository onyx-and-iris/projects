using System;
using System.Text;
using AtgDev.Voicemeeter;
using System.Threading;
using System.Linq;

namespace VoicemeeterConnect
{
    class Program
    {
        public static RemoteApiExtender vmr;

        static void Main(string[] args)
        {
            Console.OutputEncoding = Encoding.UTF8;
            try
            {
                var path = AtgDev.Voicemeeter.Utils.PathHelper.GetDllPath();
                vmr = new RemoteApiExtender(path);
            }
            catch (Exception e)
            {
                // if cannot load dll or procedures
                Console.WriteLine($"{e.GetType()}\n{e.Message}");
                Console.ReadKey();
                Environment.Exit(1);
            }
            var resp = vmr.Login();
            Console.WriteLine($"Login: {resp}");
            if (resp != 0)
            {
                Console.WriteLine("Can't login");
                Console.ReadKey();
                Environment.Exit(1);
            }
            try
            {
                resp = vmr.WaitForNewParams(1000);
                Console.WriteLine($"WaitForUpdate: {resp}");

                foreach (int i in Enumerable.Range(0, 5))
                {
                    Console.WriteLine(String.Format("Setting strip_{0} gain to 1", i));
                    vmr.SetParameter(String.Format("Strip[{0}].Gain", i), 1);
                    SyncParams();

                    Thread.Sleep(100);

                    Console.WriteLine(String.Format("Setting strip_{0} gain to 0", i));
                    vmr.SetParameter(String.Format("Strip[{0}].Gain", i), 0);
                    SyncParams();

                    Thread.Sleep(500);
                }
            }
            finally
            {
                // If exception is thrown program supposed to successfully Logout
                vmr.AudioCallbackUnregister();
                Console.WriteLine($"AUDIO CALLBACK UNREGISTER: {resp}");
                resp = vmr.Logout();
                Console.WriteLine($"Logout {resp}");
                Console.WriteLine("Press any key to exit");
                Console.ReadKey();
            }
        }

        static void SyncParams()
        {
            while (vmr.IsParametersDirty() == 0)
            {
                Thread.Sleep(1);
            }
            while (vmr.IsParametersDirty() == 1)
            {
                Thread.Sleep(1);
            }
        }
    }
}
