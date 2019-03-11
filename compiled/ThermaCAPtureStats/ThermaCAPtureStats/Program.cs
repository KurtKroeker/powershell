using System;
using System.Collections.Generic;

namespace ThermaCAPtureStats
{
    class Program
    {
        static void Main(string[] args)
        {            
            Dictionary<string, string> namedArgs = new Dictionary<string, string>();

            if(args.Length > 0)
            {
                // Args must come in pairs
                if (args.Length % 2 != 0)
                {
                    throw new ArgumentException("Every argument requires its name to be set and may have only 1 value");
                }
                for (int i = 0; i < args.Length; i += 2)
                {
                    namedArgs.Add(args[i].ToLower(), args[i + 1]);
                }
            }

            var search = (namedArgs.ContainsKey("-search")) ? namedArgs["-search"] : "sensor";

            var client = new ThermaCaptureClient();
            var status = client.GetStats(search);

            Console.WriteLine($"Current temperature for sensor {status.SensorName} is {status.CurrentTemperature} with status {status.Status}");
            Console.WriteLine();
            Console.WriteLine("Press any key to exit...");
            Console.ReadKey();
        }
    }
}
