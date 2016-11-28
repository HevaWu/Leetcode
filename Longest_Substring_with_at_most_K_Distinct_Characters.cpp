/*340. Longest Substring with At Most K Distinct Characters  QuestionEditorial Solution  My Submissions
Total Accepted: 8198 Total Submissions: 20927 Difficulty: Hard
Given a string, find the length of the longest substring T that contains at most k distinct characters.

For example, Given s = “eceba” and k = 2,

T is "ece" which its length is 3.

Hide Company Tags Google
Hide Tags Hash Table String
Hide Similar Problems (H) Longest Substring with At Most Two Distinct Characters
*/



/*use array/hashmap to store each character value
array is more quickly
array --- char is 1 byte = 8 bits = 256 possible values
once this character is not exist before, ++count
once the number is larger than k, delete from the start of string
check the maxLen of the substring for each step*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int lengthOfLongestSubstringKDistinct(string s, int k) {
        vector<int> ss(256);
        int count = 0;
        int i = 0;
        int ret = 0;
        for(int j = 0; j < s.size(); ++j) {
            if(ss[s[j]]++ == 0) count++;
            if(count > k){
                while(--ss[s[i++]] > 0);
                count--;
            }
            ret = max(ret, j-i+1);
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int lengthOfLongestSubstringKDistinct(String s, int k) {
        //array
        int[] ss = new int[256];
        int count = 0;
        int i = 0;
        int ret = 0;
        for(int j = 0; j < s.length(); ++j){
            if(ss[s.charAt(j)]++ == 0) count++;

            if(count >k){
                while(--ss[s.charAt(i++)] > 0);
                count--;
            }
            /*while(count > k){
                char c1 = s.charAt(index);
                if(--str[c1] == 0){
                    count--;
                }
                index++;
            }*/
            ret = Math.max(ret, j-i+1);
        }
        return ret;
    }
}




public class Solution {
    public int lengthOfLongestSubstringKDistinct(String s, int k) {
        //hashmap
        Map<Character, Integer> mymap = new HashMap<>();
        int maxLen = 0;
        int index = 0;
        
        for(int i = 0; i < s.length(); ++i){
            char c = s.charAt(i);
            if(!mymap.containsKey(c)){
                mymap.put(c, 0);
            }
            mymap.put(c, mymap.get(c)+1);
            
            while(mymap.size()>k){
                char c1 = s.charAt(index);
                mymap.put(c1, mymap.get(c1)-1);
                if(mymap.get(c1)==0){
                    mymap.remove(c1);
                }
                index++;
            }
            maxLen = Math.max(maxLen, i-index+1);
        }
        return maxLen;
    }
}
