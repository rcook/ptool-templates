$cs_copyright
namespace HelloWorld
{
    using System;

    internal static class Program
    {
        internal static void Main(string[] args)
        {
            Console.WriteLine("Hello from $project_name!");

            foreach (var arg in args)
            {
                Console.WriteLine(arg);
            }
        }
    }
}
