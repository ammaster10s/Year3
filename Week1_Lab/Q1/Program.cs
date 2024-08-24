using System;

namespace Week1_Lab.Q1
{
    internal class Program
    {
        static void Main()
        {   
            Console.WriteLine("Enter The First Number");
            string F1_Number = Console.ReadLine();
            Console.WriteLine("Enter The Second Number");
            string F2_Number = Console.ReadLine();

            int F1_Convert = Convert.ToInt32(F1_Number);
            int F2_Convert = Convert.ToInt32(F2_Number);
	        

            Console.WriteLine(F1_Convert + F2_Convert);
            Console.WriteLine(F1_Convert - F2_Convert);
            Console.WriteLine(F1_Convert * F2_Convert);
            Console.WriteLine(F1_Convert / F2_Convert);
        }
    }
}
