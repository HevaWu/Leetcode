/*
In this problem you will test your knowledge of Java loops. Given three integers a, b, and n, output the following series:

a+20b,a+20b+21b,......,a+20b+21b+...+2n−1b
Input Format

The first line will contain the number of testcases t. Each of the next t lines will have three integers, a, b, and n.

Constraints:

0≤t≤500
0≤a,b≤50
1≤n≤15
Output Format

Print the answer to each test case in separate lines.

Sample Input

2
0 2 10
5 3 5
Sample Output

2 6 14 30 62 126 254 510 1022 2046
8 14 26 50 98
Explanation

In the first case:

1st term=0+1*2=2
2nd term=0+1*2+2*2=6
3rd term=0+1*2+2*2+4*2=14
and so on.
*/
import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner sc=new Scanner(System.in);
        int a,b,n,sum=0,t1;
        t1 = sc.nextInt();
        while(t1>0)
            {
            a = sc.nextInt();  //do not forget the "sc"
            b = sc.nextInt();
            n = sc.nextInt();
            sum = a;  //need to initialize sum as a
            for(int i = 0; i < n; i++)
                {
                sum = sum + (int)Math.pow(2,i)*b;
                System.out.print(sum+" ");
            }
            
            System.out.print("\n");
            sum = 0;
            t1--;
        }
    }
}