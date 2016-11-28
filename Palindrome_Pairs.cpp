/*
336. Palindrome Pairs  QuestionEditorial Solution  My Submissions
Total Accepted: 9448
Total Submissions: 43812
Difficulty: Hard
Given a list of unique words. Find all pairs of distinct indices (i, j) in the given list, so that the concatenation of the two words, i.e. words[i] + words[j] is a palindrome.

Example 1:
Given words = ["bat", "tab", "cat"]
Return [[0, 1], [1, 0]]
The palindromes are ["battab", "tabbat"]
Example 2:
Given words = ["abcd", "dcba", "lls", "s", "sssll"]
Return [[0, 1], [1, 0], [3, 2], [2, 4]]
The palindromes are ["dcbaabcd", "abcddcba", "slls", "llssssll"]

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google Airbnb
Hide Tags Hash Table String Trie
Hide Similar Problems (M) Longest Palindromic Substring (H) Shortest Palindrome
*/




/* time complexity O(m * n ^ 2) where m is the length of the list and the n is the length of the word
use HashMap to store the words and its position, key is words[i], value is i
check each substring [0,i], and [i to size] for "each word" 
reverse the remain wordstring, check if this reverse is contians in the words by using map.containsKey()
*/

//C++
////////////////////////////////////////////////////////////////////////////////////////////////
class Solution {
public:
    vector<vector<int>> palindromePairs(vector<string>& words) {
        vector<vector<int> > ret;
        if(words.empty() || words.size()<2){
            return ret;
        }
        
        unordered_map<string, int> mymap;
        for(int i = 0; i < words.size(); i++){
            mymap[words[i]] = i;
        }
        
        for(int i = 0; i < words.size(); i++){
            for(int j = 0; j <= words[i].size(); j++){ // notice it should be "j <= words[i].size()"
                int wsize = words[i].size();
                string str1 = words[i].substr(0,j);
                string str2 = words[i].substr(j,wsize-j);
                if(isPalindrome(str1)){
                    string str2rvs = str2;
                    reverse(str2rvs.begin(), str2rvs.end());
                    // cout << str2 << " " << str2rvs << endl;
                    if(mymap.find(str2rvs) != mymap.end() && mymap[str2rvs] != i){
                        ret.push_back({mymap[str2rvs], i});
                    }
                }
                if(isPalindrome(str2)){
                    string str1rvs = str1;
                    reverse(str1rvs.begin(), str1rvs.end());
                    // check "str.size() != 0" to avoid duplicates
                    if(mymap.find(str1rvs) != mymap.end() && mymap[str1rvs] != i && str2.size() != 0){
                        ret.push_back({i, mymap[str1rvs]});
                    }
                }
            }
        }
        
        return ret;
    }
    
    bool isPalindrome(string str){
        int left = 0;
        int right = str.size()-1;
        while(left<=right){
            if(str[left++]!=str[right--]){
                return false;
            }
        }
        return true;
    }
};







//java
////////////////////////////////////////////////////////////////////////////////////////////////
public class Solution {
    public List<List<Integer>> palindromePairs(String[] words) {
        List<List<Integer> > ret = new ArrayList<>();
        if(words == null || words.length < 2){
            return ret;
        }
        
        //store words in the map
        Map<String, Integer> mymap = new HashMap<String, Integer>();
        for(int i = 0; i < words.length; i++){
            mymap.put(words[i], i);
        }
        
        for(int i = 0; i < words.length; i++){
            //check each words
            for(int j = 0; j <= words[i].length(); j++){ // notice it should be "j <= words[i].length()"
                String str1 = words[i].substring(0,j);
                String str2 = words[i].substring(j);

                if(isPalindrome(str1)){
                    String str2rvs = new StringBuilder(str2).reverse().toString();
                    if(mymap.containsKey(str2rvs) && mymap.get(str2rvs) != i){
                        List<Integer> mylist = new ArrayList<Integer>();
                        mylist.add(mymap.get(str2rvs)); //first add str2 reverse
                        mylist.add(i);
                        ret.add(mylist);
                    }
                }

                if(isPalindrome(str2)){
                    String str1rvs = new StringBuilder(str1).reverse().toString();
                    // check "str.length() != 0" to avoid duplicates
                    if(mymap.containsKey(str1rvs) 
                        && mymap.get(str1rvs) != i &
                        & str2.length() != 0){
                        List<Integer> mylist = new ArrayList<Integer>();
                        mylist.add(i);  //first add i
                        mylist.add(mymap.get(str1rvs));
                        ret.add(mylist);
                    }
                }
            }
        }
        
        return ret;
    }
    
    private boolean isPalindrome(String str){
        int left = 0;
        int right = str.length()-1;
        while(left<=right){
            if(str.charAt(left++) != str.charAt(right--)){
                //remember ++ and --
                return false;
            }
        }
        
        return true;
    }
}