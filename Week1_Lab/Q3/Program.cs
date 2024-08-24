using System;
using System.Collections.Generic;
using System.Linq;

// See https://aka.ms/new-console-template for more information
namespace Week1_Lab.Q3
{
    class Program
    {
        static void Loop(int size)
        {

            List<int> templist = new List<int>();

            int total = 0;
            for (int i = 0; i < size; i++)
            {
               Console.WriteLine($"Element {i + 1}: ");
               templist.Add(int.Parse(Console.ReadLine()));
            }

            Console.WriteLine($"Sum of elements: {templist.Sum()}");
            Console.WriteLine($"Maximum element: {templist.Max()}");
            Console.WriteLine($"Minimum element: {templist.Min()}");
            Console.WriteLine($"Average of elements: {templist.Sum() / (double)templist.Count}");
        }

        static void Main()
        {
            Console.WriteLine("Enter the number of elements in the array: ");
            int temp = int.Parse(Console.ReadLine()); 
            Loop(temp);
        }
    }

}
