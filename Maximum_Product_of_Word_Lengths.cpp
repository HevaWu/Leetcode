/*318. Maximum Product of Word Lengths  QuestionEditorial Solution  My Submissions
Total Accepted: 31826
Total Submissions: 77570
Difficulty: Medium
Given a string array words, find the maximum value of length(word[i]) * length(word[j]) where the two words do not share common letters. You may assume that each word will contain only lower case letters. If no such two words exist, return 0.

Example 1:
Given ["abcw", "baz", "foo", "bar", "xtfn", "abcdef"]
Return 16
The two words can be "abcw", "xtfn".

Example 2:
Given ["a", "ab", "abc", "d", "cd", "bcd", "abcd"]
Return 4
The two words can be "ab", "cd".

Example 3:
Given ["a", "aa", "aaa", "aaaa"]
Return 0
No such pair of words.

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Bit Manipulation
*/



/*1, we sort the array according to the length of each words
 2, record which lower case letter occurs in each word, using ocur[i] |= 1 << (c-'a')
 for example, if words[i] contains 'abcd' ocur[i] should be 0000...01111, since int is 32 bits, and lower case letters only have 26 letters, so, we can store this into 'int'
 3, from the longest words, we compare if these two words have common letters(using & operator), if they have, jump out of the loop, if not, check the max length of 
 words[i]*words[j] 
 optimize: before we compare the common letters, we can check words[i]*words[i]<=max, since the length of last i-1 words are shorter than words[i], if it is really less than max, break the loop, and we do not need to compare the last i-1 words.*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int maxProduct(vector<string>& words) {
        int ret = 0;
        
        //sort the words
        std::sort(words.begin(), words.end(), [](string a, string b){return a.size()>b.size();});
        
        vector<int> ocur(words.size());
        for(int i = 0; i < words.size(); ++i){
            for(char c: words[i]){
                ocur[i] |= 1 << (c-'a');  //record which lower case letter occurs in words[i]
            }
        }
        
        for(int i = 0; i < words.size(); ++i){
            if(words[i].size()*words[i].size() <= ret) break;//the last i-1 words has shorter length than words[i]
            
            for(int j = i+1; j < ocur.size(); ++j){
                if((ocur[i]&ocur[j]) == 0){//check if there are common letters between words[i] and words[j]
                    ret = std::max(ret, (int)(words[i].size()*words[j].size()));//mark the (int) type
                    break;
                }
            }
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
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