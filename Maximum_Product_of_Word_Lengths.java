/*
Given a string array words, return the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. If no such two words exist, return 0.



Example 1:

Input: words = ["abcw","baz","foo","bar","xtfn","abcdef"]
Output: 16
Explanation: The two words can be "abcw", "xtfn".
Example 2:

Input: words = ["a","ab","abc","d","cd","bcd","abcd"]
Output: 4
Explanation: The two words can be "ab", "cd".
Example 3:

Input: words = ["a","aa","aaa","aaaa"]
Output: 0
Explanation: No such pair of words.


Constraints:

2 <= words.length <= 1000
1 <= words[i].length <= 1000
words[i] consists only of lowercase English letters.
*/

/*
Solution 1:
- sort words by descending size
- record which char appears by using occur[i] |= 1 << Int(c.asciiValue! - ascii_a)
- iterate words, check if we can extend res

Time Complexity: O(nlogn + nm + n*n)
Space Complexity: O(n+26)
*/
public class Solution {
    public int maxProduct(String[] words) {
        int ret = 0;
        if(words.length==0) return ret;

        //sort the array according to their length
        Arrays.sort(words, new Comparator<String>(){
            public int compare(String a, String b){
                return b.length() - a.length();  //use '-' since return int type, b-a
            }
        });

        //mark which character appears in each word
        int[] ocur = new int[words.length];
        for(int i = 0; i < words.length; ++i){
            for(char c: words[i].toCharArray()){//remember toCharArray
                ocur[i] |= 1 << (c-'a');
            }
        }

        //find the largest product of two words
        for(int i = 0; i < words.length; ++i){
            if(words[i].length()*words[i].length() <= ret) break;
            for(int j = i+1; j < ocur.length; ++j){
                if( (ocur[i]&ocur[j]) == 0){ // use (occur[i]&occur[j])
                    ret = Math.max(ret, words[i].length()*words[j].length());
                    break;
                }
            }
        }

        return ret;
    }
}