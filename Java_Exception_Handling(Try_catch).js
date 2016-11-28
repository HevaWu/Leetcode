/*
Exception handling is the process of responding to the occurrence, during computation, of exceptions – anomalous or exceptional conditions requiring special processing – often changing the normal flow of program execution. (Wikipedia)
Java has built-in mechanism to handle exceptions. Using the try statement we can test a block of code for errors. The catch block contains the code that says what to do if exception occurs.

This problem will test your knowledge on try-catch block.

You will be given two integers  and  as input, you have to compute x/y. If x and y are not 32 bit signed integers or if y is zero, exception will occur and you have to report it. Read sample Input/Output to know what to report in case of exceptions.

Sample Input 1:

10
3
Sample Output 1:

3
Sample Input 2:

10
Hello
Sample Output 2:

java.util.InputMismatchException
Sample Input 3:

10
0
Sample Output 3:

java.lang.ArithmeticException: / by zero
Sample Input 4:

23.323
0
Sample Output 4:

java.util.InputMismatchException
*/

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner sc = new Scanner(System.in);
        
        try{
            int n1 = sc.nextInt();
            int n2 = sc.nextInt();
            int res = n1/n2;
            System.out.println(res);
        }catch(InputMismatchException e){
            System.out.println(e.getClass().getName());
        }catch(Exception e){
           System.out.println(e) ;
        }
    }
}