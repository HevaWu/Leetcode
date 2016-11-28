/*
In computer science, a set is an abstract data type that can store certain values, without any particular order, and no repeated values(Wikipedia). {1,2,3} is an example of a set, but {1,2,2} is not a set. Today you will learn how to use sets in java by solving this problem.

You are given n pairs of strings. Two pairs (a,b)(a,b) and (c,d)(c,d) are identical if a=ca=c and b=db=d. That also implies (a,b)(a,b) is not same as (b,a)(b,a). After taking each pair as input, you need to print number of unique pairs you currently have.

Note: Brute force solution will not earn full points.

Hints: Solve Java Comparator problem first!

Input Format

In the first line, there will be an integer TT denoting number of pairs. Each of the next T lines will contain two strings seperated by a single space.

Constraints:
1<=T<=1000001<=T<=100000
Length of each string is atmost 5 and will consist lower case letters only.
The testcases were generated randomly.

Output Format

Print TT lines. In the ithith line, print number of unique pairs you have after taking ithith pair as input.

Sample Input

5
john tom
john mary
john tom
mary anna
mary anna
Sample Output

1
2
2
3
3
Explanation

After taking the first input, you have only one pair: (john,tom)
After taking the second input, you have two pairs: (john, tom) and (john, mary)
After taking the third input, you still have two unique pairs.
After taking the fourth input, you have three unique pairs: (john,tom), (john, mary) and (mary, anna)
After taking the fifth input, you still have three unique pairs.
*/

import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        sc.nextLine();
        HashSet myset = new HashSet();
        for(int i = 0; i < n; i++){
            String total = sc.nextLine();
            //String[] s = total.split(' ');
            myset.add(total);
            System.out.println(myset.size());
        }
        
    }
}