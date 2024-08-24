using System;
using System.Collections.Generic;
using System.Linq;

// See https://aka.ms/new-console-template for more information
namespace Week1_Lab.Q4
{
    class Program
    {
        static void Loop(int size)
        {

            List<int> templist = new List<int>();

            int total = 0;
            for (int i = 0; i < size; i++)
            {
               Console.WriteLine($"Enter the score for student {i + 1}: ");
               templist.Add(int.Parse(Console.ReadLine()));
            }

         
            Console.WriteLine($"The class average is: {templist.Sum() / (double)templist.Count}");
        }

        static void Main()
        {
            Console.WriteLine("Enter the number of students: ");
            int temp = int.Parse(Console.ReadLine()); 
            Loop(temp);
        }
    }

}
