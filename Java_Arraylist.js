/*
Sometimes it's better to use dynamic size arrays. Java's Arraylist can provide you this feature. Try to solve this problem using Arraylist.

You are given  lines. In each line there are zero or more integers. You need to answer a few queries where you need to tell the number located in  position of  line. 

Take your input from System.in.

Input Format
The first line has an integer . In each of the next  lines there will be an integer  denoting number of integers on that line and then there will be  space-separated integers. In the next line there will be an integer denoting number of queries. Each query will consist of two integers  and .

Constraints






Each number will fit in signed integer.
Total number of integers in  lines will not cross 100000.

Output Format
In each line, output the number located in  position of  line. If there is no such position, just print "ERROR!"

Sample Input

5
5 41 77 74 22 44
1 12
4 37 34 36 52
0
3 20 22 33
5
1 3
3 4
3 1
4 3
5 5
Sample Output

74
52
37
ERROR!
ERROR!
*/

import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        sc.nextLine();
        ArrayList<ArrayList<Integer>> a = new ArrayList<ArrayList<Integer>>(n);
        for(int i = 0; i < n; i++){
            int n1 = sc.nextInt();
            ArrayList<Integer> a1 = new ArrayList<Integer>(n1);
            for(int j = 0; j < n1; j++){
                a1.add(j,sc.nextInt());
            }
            a.add(i,a1);
            sc.nextLine();
        }
        
        int ntest = sc.nextInt();
        sc.nextLine();
        for(int i = 0; i < ntest; i++){
            int nrow = sc.nextInt();
            int ncol = sc.nextInt();
            sc.nextLine();
            if(nrow>a.size()){
                System.out.println("ERROR!");
                continue;
            }
            if(ncol>a.get(nrow-1).size()){
                System.out.println("ERROR!");
                continue;
            }
            System.out.println(a.get(nrow-1).get(ncol-1));
        }
        
    }
}