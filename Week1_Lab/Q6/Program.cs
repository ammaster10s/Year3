using System;
using System.Collections.Generic;

namespace Week1_Lab.Q6
{
    class Program
    {
        static void Main()
        {
            Console.WriteLine("===== Student Management System =====");
            Console.WriteLine("1. Add a new Student");
            Console.WriteLine("2. Display all Students");
            Console.WriteLine("3. Search student by ID");
            Console.WriteLine("4. Exit");

            List<int> ID = new List<int>();
            List<string> Name = new List<string>();
            List<int> Age = new List<int>();

            while (true)
            {
                Console.Write("Enter your choice: ");
                int choice = int.Parse(Console.ReadLine());

                switch (choice)
                {
                    case 1:
                        Console.Write("Enter student's name: ");
                        Name.Add(Console.ReadLine());

                        Console.Write("Enter student's age: ");
                        Age.Add(int.Parse(Console.ReadLine()));

                        ID.Add(ID.Count + 1);

                        Console.WriteLine("Student added successfully!");
                        break;

                    case 2:
                        for (int i = 0; i < ID.Count; i++)
                        {
                            Console.Write($"ID: {ID[i]}, ");
                            Console.Write($"Name: {Name[i]}, ");
                            Console.Write($"Age: {Age[i]}");
                            Console.WriteLine();
                        }
                        break;

                    case 3:
                        Console.Write("Enter student ID to search: ");
                        int search = int.Parse(Console.ReadLine());

                        if (ID.Contains(search))
                        {
                            int index = ID.IndexOf(search);
                            Console.WriteLine("----- List of Students -----");
                            Console.Write($"ID: {ID[index]}, ");
                            Console.Write($"Name: {Name[index]}, ");
                            Console.Write($"Age: {Age[index]}");
                            Console.WriteLine();
                        }
                        else
                        {
                            Console.WriteLine("Student not found");
                        }
                        break;

                    case 4:
                        return; 

                    default:
                        Console.WriteLine("Invalid choice, please try again.");
                        break;
                }
            }
        }
    }
}
