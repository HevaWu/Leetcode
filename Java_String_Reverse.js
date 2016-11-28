/*
A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward or forward.(Wikipedia)
Given a string AA, print "Yes" if it is a palindrome, print "No" otherwise. The strings will consist lower case english letters only. The strings will have at most 50 characters.

Some examples of palindromes are "madam", "anna", "reviver".

Sample Input

madam
Sample Output

Yes
*/

import java.io.*;
import java.util.*;

public class Solution {
    public static void main(String[] args) {
        
        Scanner sc=new Scanner(System.in);
        String A=sc.next();
        /* Enter your code here. Print output to STDOUT. */
        /*char[] str=A.toCharArray();
        int ssize = A.length();
        int flag = 1;
        for(int i = 0; i < ssize/2; i++){
            if(str[i]!=str[ssize-i-1]) {
                System.out.println("No");
            flag = 0;
                break;
            }
        }
        if(flag == 1)
        System.out.println("Yes");*/
        
        System.out.println(A.equals(new StringBuilder(A).reverse().toString()) ? "Yes" : "No");
        
    }
}
