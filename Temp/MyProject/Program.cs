namespace MyProject
{
        internal class Program
        {
            static void Main()
            {
                System.Console.WriteLine("Hello, World!");
            




            // Exercise 1
            int myInt = 8 ;
            double myDouble = 7.89;
            bool myBool = true;

            Console.WriteLine(Convert.ToString(myInt));
            Console.WriteLine(Convert.ToDouble(myInt));
            Console.WriteLine(Convert.ToInt32(myDouble));
            Console.WriteLine(Convert.ToString(myBool));

            // Exercise 2
            Console.WriteLine("Enter The Number");
            string Number = Console.ReadLine();
            int Number_Convert = Convert.ToInt32(Number);
            if (Number_Convert % 2 == 0)
            {
                Console.WriteLine("The Number is Even");
            }
            else
            {
                Console.WriteLine("The Number is Odd");
            
            }

            // // Exercise 3

            // Console.WriteLine("Enter The Age");
            // string Age = Console.ReadLine();
            // int Age_Convert = Convert.ToInt32(Age);
            // if (Age_Convert >= 18)
            // {
            //     Console.WriteLine("Your are eligible to vote");

            // }
            // else
            // {
            //     Console.WriteLine("Your are not eligible to vote");
            // }

            // // Exercise 4
            // Console.WriteLine("Enter The Year");
            // string Year = Console.ReadLine();
            // int Year_Convert = Convert.ToInt32(Year);
            // if (Year_Convert % 4 == 0 && Year_Convert % 100 != 0 || Year_Convert % 400 == 0)
            // {
            //     Console.WriteLine("The Year is Leap Year");
            // }
            // else
            // {
            //     Console.WriteLine("The Year is not Leap Year");
            // }

        }
        }
}
