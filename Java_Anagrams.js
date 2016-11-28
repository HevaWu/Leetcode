/*
Two strings AA and BB are called anagrams if they consist same characters, but may be in different orders. So the list of anagrams of CAT are "CAT", "ACT" , "TAC", "TCA" ,"ATC" and "CTA".

Given two strings, print "Anagrams" if they are anagrams, print "Not Anagrams" if they are not. The strings may consist at most 50 english characters, the comparison should NOT be case sensitive.

This exercise will verify that you are able to sort the characters of a string, or compare frequencies of characters.

Sample Input 1

anagram
margana
Sample Output 1:

Anagrams
Sample Input 2

anagramm
marganaa
Sample Output 2:

Not Anagrams
*/

import java.io.*;
import java.util.*;

public class Solution {

   static boolean isAnagram(String A, String B) {
      //Complete the functio
      if(A == null && B == null)
          return true;
      if(A == null || B == null) {
          return false;
      }
      if(A.length() == 0 && B.length() == 0) {
           return true;
       }
      if(A.length() != B.length()) {
          return false;
      }
      Map<Character, Integer> ma = new HashMap<>();
		 A = A.toLowerCase();
		 B = B.toLowerCase();
		 for(int i = 0; i < A.length(); i++){
			 if(ma.containsKey(A.charAt(i))) {
				 ma.put(A.charAt(i), ma.get(A.charAt(i)) +  1);
			 } else {
				 ma.put(A.charAt(i), 1);
			 }
		 }
		 for(int i = 0; i < B.length(); i++){
			 if(ma.containsKey((B.charAt(i)))){
				 if(ma.get(B.charAt(i)) > 0) {
					 ma.put(B.charAt(i), ma.get(B.charAt(i)) - 1);
				 } else {
					 return false;
				 }
			 }else{
				 return false;
			 }
		 }
		 for(char c : ma.keySet()) {
			 if(ma.get(c) != 0) {
				 return false;
			 }
		 }
	      return true;
	      /* char a[] = A.toLowerCase().toCharArray();
	       char b[] = B.toLowerCase().toCharArray();
	       Arrays.sort(a);
	       System.out.println(a);
	       
	       Arrays.sort(b);
	       System.out.println(b);
	       //return Arrays.equals(a,b);
	       return a.equals(b);*/
	       /*
	  * int res = 0;
	  * for(int i = 0; i < A.length(); i++) {
	  * 	int temp = A.charAt(i).toLowerCase() - 'a' +1 ;
	  * 	res ^= temp;
	  * }
	  * for(int i = 0; i < B.length(); i++){
	  * 	int temp = B.charAt(i).toLowerCase() - 'a' + 1;
	  * 	res ^= temp; 
	  * }
	  * if(res == 0) return true;
	  * else return false;
	  * this method might be wrong when A is "aa", B is "bb";
	  * */
      
   }
    public static void main(String[] args) {
        
        Scanner sc=new Scanner(System.in);
        String A=sc.next();
        String B=sc.next();
        boolean ret=isAnagram(A,B);
        if(ret)System.out.println("Anagrams");
        else System.out.println("Not Anagrams");
        
    }
}
