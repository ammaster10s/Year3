using System;
using System.Collections.Generic;
using System.Linq; // Add using directive for System.Linq namespace

namespace Week1_Lab.Q6
{
    class StudentDBMS
    {
        static List<int> ID = new List<int>();
        static List<string> Name = new List<string>();
        static List<int> Age = new List<int>();

        public static void Addstudent(string name, int age)
        {   
            if (name == "" || age.ToString() == "")
            {
                Console.WriteLine("Please enter a valid name and age");
                return;
            }
            else if (age < 0)
            {
                Console.WriteLine("Please enter a valid age");
                return;
            }
            
            ID.Add(ID.Count + 1);
            Name.Add(name);
            Age.Add(age);
            Console.WriteLine("Student added successfully!");
        }

        public static void DisplayAllStudents()
        {
            for (int i = 0; i < ID.Count; i++)
            {
                Console.Write($"ID: {ID[i]}, ");
                Console.Write($"Name: {Name[i]}, ");
                Console.Write($"Age: {Age[i]}");
                Console.WriteLine();
            }
        }

        public static void SearchStudentByID(int id)
        {
            if (ID.Contains(id))
            {
                int index = ID.IndexOf(id);
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
        }
    }

    class Student
    {
        public static void Main()
        {
            
            Console.WriteLine("===== Student Management System =====");
            Console.WriteLine("1. Add a new Student");
            Console.WriteLine("2. Display all Students");
            Console.WriteLine("3. Search student by ID");
            Console.WriteLine("4. Exit");

            while (true)
            {
                
                Console.WriteLine("Enter your choice: ");

                int choice = int.Parse(Console.ReadLine());

                switch (choice)
                {
                    case 1:
                        Console.WriteLine("Enter the name of the student: ");
                        string name = Console.ReadLine();
                        Console.WriteLine("Enter the age of the student: ");
                        int age = int.Parse(Console.ReadLine());
                        StudentDBMS.Addstudent(name, age);
                        break;
                    case 2:
                        StudentDBMS.DisplayAllStudents();
                        break;
                    case 3:
                        Console.WriteLine("Enter the ID of the student: ");
                        int search = int.Parse(Console.ReadLine());
                        StudentDBMS.SearchStudentByID(search);
                        break;
                    case 4:
                        Environment.Exit(0);
                        break;
                    default:
                        Console.WriteLine("Invalid choice");
                        break;
                }
            }
        }
    }
}