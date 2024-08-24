namespace Week1_Lab.Q2
{
    class Program
    {
        static void Loop(int size)
        {
            int total = 0;
            for (int i = 0; i <= size; i++)
            {
                total += i;
            }

            Console.WriteLine($"The total is {total}");
        }

        static void Main()
        {
            Console.WriteLine("Enter the size of the number: ");
            int temp = int.Parse(Console.ReadLine()); 
            Loop(temp);
        }
    }
}
