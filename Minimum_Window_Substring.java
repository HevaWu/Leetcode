/*76. Minimum Window Substring Add to List
Description  Submission  Solutions
Total Accepted: 90560
Total Submissions: 374434
Difficulty: Hard
Contributors: Admin
Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

For example,
S = "ADOBECODEBANC"
T = "ABC"
Minimum window is "BANC".

Note:
If there is no such window in S that covers all characters in T, return the empty string "".

If there are multiple such windows, you are guaranteed that there will always be only one unique minimum window in S.

Hide Company Tags LinkedIn Snapchat Uber Facebook
Hide Tags Hash Table Two Pointers String
Hide Similar Problems (H) Substring with Concatenation of All Words (M) Minimum Size Subarray Sum (H) Sliding Window Maximum
*/







/*
Array faster than HashMap

HashMap & pointer
also can use array to achieve hashmap
1. set all char in string s as 0 in the amp,
    set the char in string t as its appearance in t
2. "left" pointer --- the left of the current window
    "right" pointer --- the right of the current window
    "count" --- help check if current window cover all characters in t
    "dis" --- the minimum range of the window, init it as Integer.MAX_VALUE
    "head" --- the head of the minimum range window
3. check if "dis" == Integer.MAX_VALUE,
    if it is, means there is no window exist, return "" empty string
    if not, return the substring of (head, head + dis);
 */

////////////////////////////////////////////////////////////////////////
//Java
//Array
public class Solution {
    public String minWindow(String s, String t) {
        if(t.length() == 0 || s.length() == 0 || t.length() > s.length()) return "";

        int[] mymap = new int[128]; //Ascii code the maximum is 128
        for(char c: t.toCharArray()){
            mymap[c]++;
        }

        int count = t.length();
        int left = 0;
        int right = 0;
        int head = 0;
        int dis = Integer.MAX_VALUE;
        while(right < s.length()){
            if(mymap[s.charAt(right++)]-- > 0){
                count --;
            }

            while(count == 0){
                if(right-left < dis){
                    dis = right - left;
                    head = left;
                }

                if(mymap[s.charAt(left++)]++ == 0){
                    count ++;
                }
            }
        }

        return dis==Integer.MAX_VALUE ? "" : s.substring(head, head + dis);
    }
}


//HashMap
public class Solution {
    public String minWindow(String s, String t) {
        if(t.length() == 0 || s.length() == 0 || t.length() > s.length()) return "";

        //store the appearance of each character in t
        Map<Character, Integer> mymap = new HashMap<>();
        for(char c: s.toCharArray()){
            //first push all character in s into the map
            mymap.put(c, 0);
        }
        for(char c: t.toCharArray()){
            if(!mymap.containsKey(c)){
                //if there is a char in t, but not in s, there is no window
                return "";
            }
            mymap.put(c, mymap.get(c)+1);
        }

        int count = t.length(); //help check whether the substring is a window
        int left = 0; //the left of the substring
        int right = 0; //the right of the substring
        int dis = Integer.MAX_VALUE; //the range of the window, init as the maximum int
        int head = 0; //the head of current window
        while(right < s.length()){ //search string s
            char rightc = s.charAt(right);
            if(mymap.get(rightc) > 0){
                //check if current char is exist in current range
                count--;
            }
            mymap.put(rightc, mymap.get(rightc)-1);
            right++;

            while(count == 0){
                //current range contains a window, valid
                if(right-left < dis){
                    dis = right - left;
                    head = left;
                }

                char leftc = s.charAt(left);
                if(mymap.get(leftc) == 0){
                    //move forward to the next one, make it invalid
                    count ++;
                }
                left++;
                mymap.put(leftc, mymap.get(leftc)+1);
            }
        }

        return dis==Integer.MAX_VALUE ? "" : s.substring(head, head + dis);
    }
}
