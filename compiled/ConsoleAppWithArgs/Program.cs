using System;
using System.Linq;

namespace ConsoleAppWithArgs
{
    class Program
    {
        static void Main(string[] args)
        {            
            if(args.Length == 0)
            {
                Console.WriteLine("No arguments provided!");
            }
            else
            {
                // loop through each argument passed in and write it to the console
                foreach (var arg in args)
                {
                    Console.WriteLine($"Argument: {arg}");
                }
            }            
        }
    }
}
