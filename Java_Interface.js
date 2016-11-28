/*
Problem
Submissions
Leaderboard
Discussions
Editorial 
A Java interface can only contain method signatures and fields. Interface can be used to achieve polymorphism. In this problem you will practice your knowledge on interfaces.

You are given an interface AdvancedArithmetic which contains a method signature public abstract int divisorSum(int n). You need to write a class called MyCalculator which implements the interface.

divisorSum function just takes an integer as input and return the sum of all its divisors. For example divisors of 6 are 1,2,3 and 6, so divisorSum should return 12. Value of n will be at most 1000.

Read the partially completed code in the editor and complete it. You just need to write the MyCalculator class only. Your class shouldn't be public.

Sample Input

6
Sample Output

I implemented: AdvancedArithmetic
12
Explanation

Divisors of 6 are 1,2,3 and 6. 1+2+3+6=12.
*/


import java.util.*;
interface AdvancedArithmetic{
  public abstract int divisorSum(int n);
}

class MyCalculator implements AdvancedArithmetic{
    public int divisorSum(int n){
        int dSum = 0;
        for(int i = 1; i < n/2+1; i++){
            if(n%i==0)
                dSum += i;
        }
        return dSum+n;
    }
}

class Solution{

    public static void main(String []argh)
    {
        MyCalculator my_calculator=new MyCalculator();
        System.out.print("I implemented: ");
        ImplementedInterfaceNames(my_calculator);
        Scanner sc=new Scanner(System.in);
        int n=sc.nextInt();
        System.out.print(my_calculator.divisorSum(n)+"\n");

    }
    /*
     *  ImplementedInterfaceNames method takes an object and prints the name of the interfaces it implemented
     */
    static void ImplementedInterfaceNames(Object o)
    {

        Class[] theInterfaces = o.getClass().getInterfaces();
        for (int i = 0; i < theInterfaces.length; i++)
        {
            String interfaceName = theInterfaces[i].getName();
            System.out.println(interfaceName);
        }
    }
}

