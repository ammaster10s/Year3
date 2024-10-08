﻿using System; 

namespace Week1_Lab.Q5
{
    class Program
    {
        static List<int> templist = new List<int>(); // Declare the templist variable outside of the AddItem method

        static void AddItem(string item , double price)
        {
            switch (int.Parse(item))
            {
                case 1:
                    templist.Add(25);
                    Console.WriteLine("Shirt added to cart");
                    break;
                case 2:
                    templist.Add(50);
                    Console.WriteLine("Jeans added to cart");
                    break;
                case 3:
                    templist.Add(75);
                    Console.WriteLine("Shoes added to cart");
                    break;
            }
        }

        static void DisplayCart() 
        {
            Console.WriteLine("Items in the cart: ");
            int total = 0;

            foreach (var item in templist)
            {
                switch (item) // Fix the variable name in the switch statement
                {
                    case 25:
                        Console.WriteLine("Shirt - $25.00");
                        total += 25;
                        break;
                    case 50:
                        Console.WriteLine("Jeans - $50.00");
                        total += 50;
                        break;
                    case 75:
                        Console.WriteLine("Shoes - $75.00");
                        total += 75;
                        break;
                }
            }
            Console.WriteLine($"Total Price: ${total.ToString("F2")}");
        }

        static void Main()
        {
            Console.WriteLine("Enter the number of items you want to add: ");
            int temp = int.Parse(Console.ReadLine()); 

            for (int i = 0; i < temp; i++)
            {
                Console.WriteLine("Select an item to add to the cart: ");
                Console.WriteLine("1. Shirt - $25.00");
                Console.WriteLine("2. Jeans - $50.00");
                Console.WriteLine("3. Shoes - $75.00");
                Console.Write("Enter your choice (1-3): ");
                int Select = int.Parse(Console.ReadLine());

                AddItem(Select.ToString(), 0); // Call the AddItem method with the correct arguments
            }

            DisplayCart(); // Call the DisplayCart method to show the items in the cart
        }
    }
}
