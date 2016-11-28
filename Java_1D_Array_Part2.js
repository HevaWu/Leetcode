/*
You are playing a game on your cellphone. You are given an array of length nn, indexed from 00 to n−1n−1. Each element of the array is either 00 or 11. You can only move to an index which contains 00. At first you are at the 0th0th position. In each move you can do one of the following things:

Walk one step forward or backward.
Make a jump of exactly length mm forward.
That means you can move from position xx to x+1x+1, x−1x−1 or x+mx+m in one move. The new position must contain 0. Also you can move to any position greater than n-1.

You can't move backward from position 00. If you move to any position greater than n−1n−1, you win the game.

Given the array and the length of the jump, you need to determine if it's possible to win the game or not.

Input Format

In the first line there will be an integer TT denoting the number of test cases. Each test case will consist of two lines. The first line will contain two integers, nn and mm. On the second line there will be nn space-separated integers, each of which is either 00 or 11.

Constraints:

1<=T<=50001<=T<=5000
2≤n≤1002≤n≤100
0≤m≤1000≤m≤100
The first integer of the array is always 00.

Output Format

For each case output "YES" if it's possible to win the game, output "NO" otherwise.

Sample Input

4
5 3
0 0 0 0 0
6 5
0 0 0 1 1 1
6 3
0 0 1 1 1 0
3 1
0 1 0
Sample Output

YES
YES
NO
NO
Explanation

In the first case you can just walk to reach the end of the array.
In the second case, you can walk to index 1 or 2 and jump from there. In the third case, jump length is too low, you can't reach the end of the array. In the fourth case, jump length is 1, so it doesn't matter if you jump or walk, you can't reach the end.
*/

import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) {
        /* Enter your code here. Read input from STDIN. Print output to STDOUT. Your class should be named Solution. */
        Scanner sc = new Scanner(System.in);
        int ncase = sc.nextInt();
        //System.out.println(ncase);
        for(int i = 0; i < ncase; i++){
            int n = sc.nextInt();
            int m = sc.nextInt();
            int[] a = new int[n];
            for(int j = 0; j < n; j++)
                a[j] = sc.nextInt();
            
            boolean judge = isPass(m,a,0);
            if(judge == true)
                System.out.println("YES");
            else if(judge == false)
                System.out.println("NO");
        }   
        
    }
    
    private static boolean isPass(int m, int[] a, int i){
        //System.out.println(i);
        if(i<0 || a[i]==1)
            return false;
        if((i==a.length-1) || (i+m>a.length-1))
            return true;
        a[i] = 1;
        return (isPass(m,a,i+1) || isPass(m,a,i-1) || isPass(m,a,i+m));
    }
}