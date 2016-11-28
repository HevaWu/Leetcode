/*
In this problem you have to add and multiply huge numbers! These numbers are so big that you can't contain them in any ordinary data types like long integer.

Use the power of Java's BigInteger class and solve this problem.

Input Format

There will be two lines containing two numbers, aa and bb.

Constraints

aa and bb are non-negative integers and can have maximum 200200 digits.

Output Format

Output two lines. The first line should contain a+ba+b, and the second line should contain a×ba×b. Don't print any leading zeros.

Sample Input

1234
20
Sample Output

1254
24680
Explanation

1234+20=12541234+20=1254
1234×20=24680
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
        BigInteger a = sc.nextBigInteger();
        BigInteger b = sc.nextBigInteger();
        System.out.println(a.add(b));
        System.out.println(a.multiply(b));
    }
}