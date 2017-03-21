/*387. First Unique Character in a String
Description  Submission  Solutions  Add to List
Total Accepted: 42276
Total Submissions: 92728
Difficulty: Easy
Contributors: Admin
Given a string, find the first non-repeating character in it and return it's index. If it doesn't exist, return -1.

Examples:

s = "leetcode"
return 0.

s = "loveleetcode",
return 2.
Note: You may assume the string contain only lowercase letters.

Hide Company Tags Amazon Bloomberg Microsoft
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 1 is faster

Solution 1: array
search the string twice
1. find each character's frequency
2. find the first freq[] == 1 and return it

Solution 2: HashMap
use Map<Character, int[]> mymap to store the string
int[2] is enough,
int[0] store the appear times of current char
int[1] store the first index this char appears
1. push the string into the map
2. search map and find the minimum index, which is the first index of unique char
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int firstUniqChar(String s) {
        if(s.length() <= 0) return -1;

        int[] freq = new int[26];
        for(char c : s.toCharArray()){
            freq[c-'a']++;
        }
        for(int i = 0; i < s.length(); ++i){
            if(freq[s.charAt(i)-'a']==1){
                return i;
            }
        }

        return -1;
    }
}


//Solution 2
public class Solution {
    public int firstUniqChar(String s) {
        if(s.length() <= 0) return -1;

        Map<Character, int[]> mymap = new HashMap<>();
        int ret = -1; //the index of the unique character, if not exist return -1

        for(int i = 0; i < s.length(); ++i){
            char c = s.charAt(i);
            if(!mymap.containsKey(c)){
                int[] temp = new int[2];
                temp[0] = 0;  //first is the appear times of current char
                temp[1] = i;  //second is the first index this char appears
                mymap.put(c, temp);
            }
            int[] temp1 = mymap.get(c);
            temp1[0]++;
            mymap.put(c, temp1);
        }

        //search the keyset of the treeMap, try to find the index of the first unique elements
        for(char c : mymap.keySet()){
            int[] temp = mymap.get(c);
            if(temp[0] == 1){
                ret = ret==-1 ? temp[1] : Math.min(ret, temp[1]);
            }
        }

        return ret;
    }
}

