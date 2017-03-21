/*266. Palindrome Permutation Add to List
Description  Submission  Solutions
Total Accepted: 26846
Total Submissions: 48112
Difficulty: Easy
Contributors: Admin
Given a string, determine if a permutation of the string could form a palindrome.

For example,
"code" -> False, "aab" -> True, "carerac" -> True.

Hint:

Consider the palindromes of odd vs even length. What difference do you notice?
Count the frequency of each character.
If each character occurs even number of times, then it must be a palindrome. How about character which occurs odd number of times?
Hide Company Tags Google Uber Bloomberg
Hide Tags Hash Table
Hide Similar Problems (M) Longest Palindromic Substring (E) Valid Anagram (M) Palindrome Permutation II (E) Longest Palindrome
*/






/*
Solution 2 faster than Solution 1

Solution 1: HashMap
also can use a set/array to check, set(even remove, odd add), array(same to hashmap)
for each char, check its current occurance in this string
if this string could rearrange to a palindrome, then the odd char should not appear or only appear once

Solution 2: BitSet
use flip() function to flip current char value to its complement
flip() example:
Bitset1:{0, 1, 2, 3, 4, 5}
Bitset2:{2, 4, 6, 8, 10}
{0, 1, 5} //flip(2,5)
{1, 3, 6, 8, 10}//flip(1,5), 1 unexist, push it, 2 exist, remove

at the end, use cardinality() function to check if only one or zero char is true, which means they are odd
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: HashMap
public class Solution {
    public boolean canPermutePalindrome(String s) {
        if(s.length() == 0) return true;

        Map<Character, Integer> mymap = new HashMap<>();
        for(char c: s.toCharArray()){
            if(!mymap.containsKey(c)){
                mymap.put(c, 0);
            }
            mymap.put(c, mymap.get(c)+1);
        }

        int count = 0; //count the odd char
        for(int value: mymap.values()){
            if(value % 2 == 1){
                count++;
            }
        }
        return count==0 || count==1;
    }
}


//Solution 2: BitSet
public class Solution {
    public boolean canPermutePalindrome(String s) {
        if(s.length() == 0) return true;
        BitSet bs = new BitSet();
        for(byte c: s.getBytes()){ //use byte here, string.getBytes() --- encode string into a sequence of bytes, return a byte[] array
            bs.flip(c);
        }
        return bs.cardinality() < 2;
    }
}
