/*358. Rearrange String k Distance Apart   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 6634
Total Submissions: 20882
Difficulty: Hard
Contributors: Admin
Given a non-empty string str and an integer k, rearrange the string such that the same characters are at least distance k from each other.

All input strings are given in lowercase letters. If it is not possible to rearrange the string, return an empty string "".

Example 1:
str = "aabbcc", k = 3

Result: "abcabc"

The same letters are at least distance 3 from each other.
Example 2:
str = "aaabc", k = 3

Answer: ""

It is not possible to rearrange the string.
Example 3:
str = "aaadbbcc", k = 2

Answer: "abacabcd"

Another possible answer is: "abcabcda"

The same letters are at least distance 2 from each other.
Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Hash Table Heap Greedy
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Greedy problem
O(n) time
use hashMap or int[26] array
use int[26] is faster than use hashMap
1. search the array, and store each char into hashmap
	(key is the char, value is the appearance of this char)
2. each time, find the largest appearance char, and insert it into the new string
	if we cannot find this char, return ""
	use validMap<Character, Integer> to make sure the next character is at k distance to the same character before
	use countMap to count the appearance times of the same character in the string */

/////////////////////////////////////////////////////////////////////////////////////
//Java
/*hashMap*/
public class Solution {
    public String rearrangeString(String str, int k) {
        if(str.length() == 0) return "";
        Map<Character, Integer> countMap = new HashMap<>(); //countMap check the appearance of the character in this string
        Map<Character, Integer> validMap = new HashMap<>(); // validMap help check the k distance of the next current character
        for(char c : str.toCharArray()){
            if(!countMap.containsKey(c)){
                countMap.put(c, 0);
                validMap.put(c, 0);
            }
            countMap.put(c, countMap.get(c)+1);
        }

        StringBuilder ret = new StringBuilder();
        for(int i = 0; i < str.length(); ++i){
            Character cret = findMax(countMap, validMap, i); //use Character to check null situation
            //System.out.println(cret);
            if(cret == null) return "";
            validMap.put(cret, validMap.get(cret)+k); //make sure k distance
            countMap.put(cret, countMap.get(cret)-1); //minus one to current character
            ret.append(cret); //add current char to the return string
        }

        return ret.toString(); //change stringBuilder to string
    }

    //each time find the valid charcter in the countMap
    public Character findMax(Map<Character, Integer> countMap, Map<Character, Integer> validMap, int index){
        Character cret = null; //init it to null
        Set<Character> myset = countMap.keySet();
        int count = 0;
        for(char c : myset){
            if(countMap.get(c) > 0 && countMap.get(c) > count && index >= validMap.get(c)){
                count = countMap.get(c);
                cret = c;
            }
        }
        return cret;
    }

}




/*use array int[]*/
public class Solution {
    public String rearrangeString(String str, int k) {
        if(str.length() == 0) return "";
        int[] count = new int[26];
        int[] valid = new int[26];
        for(char c : str.toCharArray()){
            count[c-'a']++;
        }

        StringBuilder ret = new StringBuilder();
        for(int i = 0; i < str.length(); ++i){
            int cret = findMax(count, valid, i);
            //System.out.println(cret);
            if(cret == -1) return ""; //check if this character is exist
            valid[cret] = valid[cret] + k;
            count[cret]--;
            ret.append((char)(cret+'a')); //remember +'a',transfer int to char
        }

        return ret.toString();
    }

    public int findMax(int[] count, int[] valid, int index){
        int cret = -1;;
        int max = 0;
        for(int i = 0; i < 26; ++i){
            if(count[i] > 0 && count[i] > max && index >= valid[i]){
                max = count[i];
                cret = i;
            }
        }
        return cret;
    }

}
