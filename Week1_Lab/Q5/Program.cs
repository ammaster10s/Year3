namespace Week1_Lab.Q5
{
    class Program
    {
         static void Loop(int size)
        {

            List<int> templist = new List<int>();

            int total = 0;
            for (int i = 0; i < size; i++)
            {
                Console.WriteLine("Select an item to add to the cart: ");
                Console.WriteLine("1. Shirt - $25.00");
                Console.WriteLine("2. Jeans - $50.00");
                Console.WriteLine("3. Shoes - $75.00");
                Console.Write("Enter your choice (1-3): ");
                int Select = int.Parse(Console.ReadLine());

            switch (Select)
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

            Console.WriteLine($"Sum of elements: ${templist.Sum().ToString("F2")}");
            
        }
        }
        static void Main()
        {
            Console.WriteLine("Enter the number of items you want to add: ");
            int temp = int.Parse(Console.ReadLine()); 
            Loop(temp);
        }
    }
}
