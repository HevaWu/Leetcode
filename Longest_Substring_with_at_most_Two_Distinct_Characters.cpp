/*159. Longest Substring with At Most Two Distinct Characters   QuestionEditorial Solution  My Submissions
Total Accepted: 17517 Total Submissions: 45965 Difficulty: Hard Contributors: Admin
Given a string, find the length of the longest substring T that contains at most 2 distinct characters.

For example, Given s = “eceba”,

T is "ece" which its length is 3.

Hide Company Tags Google
Hide Tags Hash Table Two Pointers String
Hide Similar Problems (M) Longest Substring Without Repeating Characters (H) Sliding Window Maximum (H) Longest Substring with At Most K Distinct Characters
*/



/* O(kn) here k=2 O(n) time
use array/hashmap to store value
in at most k distinct characters, we use the array, here we try to use hashmap
and extend it to k distinct

hashmap --- store the appearence of each char, key is char, value is appear times of char
once hashmap.size larger than k(2), remove the leftmost in string s*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int lengthOfLongestSubstringTwoDistinct(string s) {
        if(s.size() < 1) return 0;
        unordered_map<char,int> mymap;
        int j = 0;
        int maxLen = 0;
        for(int i = 0; i < s.size(); ++i){
            mymap[s[i]]++;
            while(mymap.size()>2){
                if(--mymap[s[j]] == 0){
                    mymap.erase(s[j]);
                }
                j++;
            }
            maxLen = max(maxLen, i-j+1);
        }
        return maxLen;
    }
};



/* O(kn) here k=2 O(n) time
use array/hashmap to store value
in at most k distinct characters, we use the array, here we try to use hashmap
and extend it to k distinct

hashmap --- store the appearence of each char, key is char, value is position of char
once hashmap.size larger than k(2), remove the leftmost in string s*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int lengthOfLongestSubstringTwoDistinct(String s) {
        if(s.length() < 1) return 0;
        HashMap<Character, Integer> mymap = new HashMap<>();
        int maxLen = 0;
        int j = 0; // index for removing the left most character
        for(int i = 0; i < s.length(); ++i){
            char c = s.charAt(i);
            if(!mymap.containsKey(c)){
                mymap.put(c,0);
            }
            mymap.put(c, mymap.get(c)+1);
            
            while(mymap.size() > 2){
                //remove the leftmost char in s
                char c2 = s.charAt(j);
                mymap.put(c2, mymap.get(c2)-1);
                if(mymap.get(c2) == 0){
                    mymap.remove(c2);
                }
                j++;
            }
            maxLen = Math.max(maxLen, i-j+1);
        }
        return maxLen;
    }
}



public class Solution {
    public int lengthOfLongestSubstringTwoDistinct(String s) {
        if(s.length() < 1) return 0;
        HashMap<Character, Integer> mymap = new HashMap<>();
        int maxLen = 0;
        int j = 0;
        for(int i = 0; i < s.length(); ++i){
            mymap.put(s.charAt(i), i);
            if(mymap.size() > 2){
                //remove the leftmost char in s
                int leftmost = i;
                for(int v:mymap.values()){
                    leftmost = Math.min(leftmost, v);
                }
                mymap.remove(s.charAt(leftmost));
                j = leftmost+1;
            }
            maxLen = Math.max(maxLen, i-j+1);
        }
        return maxLen;
    }
}
