/*
Write an Adder class that inherits from a superclass named Arithmetic in your editor below. Then write an add method in the Adder class that takes  integers as a parameter and returns their sum.

Note: Because both classes are being written in the same file, you must not use access modifiers (e.g.: ) or your code will not execute.

Input Format

You are not responsible for reading any input from stdin; a hidden code checker will test your submission by calling the add method on an Adder object and passing it  integer parameters.

Output Format

You are not responsible for printing anything to stdout. Your add method must return the sum of its parameters.

Sample Input

We will append a Solution class to your submitted code, which checks for inheritance and passes the necessary arguments to your add method:

class Solution{
    public static void main(String []args){
        // Create a new Adder object
        Adder a = new Adder();
        
        // Print the name of the superclass on a new line
        System.out.println("My superclass is: " + a.getClass().getSuperclass().getName());	
        
        // Print the result of 3 calls to Adder's `add(int,int)` method as 3 space-separated integers:
        System.out.print(a.add(10,32) + " " + a.add(10,3) + " " + a.add(10,10) + "\n");
     }
}
You do not need to write a Solution class.

Sample Output

The main method in the Solution class above should print the following:

My superclass is: Arithmetic
42 13 20
*/

//Write your code here
class Arithmetic{ }

class Adder extends Arithmetic{
    int add(int a, int b){
        return a+b;
    }
}