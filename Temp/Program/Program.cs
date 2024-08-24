using System;

public class Program
{
    public static void GreetUser(string name)
    {
        Console.WriteLine($"Hello, {name}! Welcome");

    }
    public static void Main()
    {
        string userName = "John";
        GreetUser(userName);
    }
}
