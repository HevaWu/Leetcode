/*131. Palindrome Partitioning   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 85483
Total Submissions: 275022
Difficulty: Medium
Contributors: Admin
Given a string s, partition s such that every substring of the partition is a palindrome.

Return all possible palindrome partitioning of s.

For example, given s = "aab",
Return

[
  ["aa","b"],
  ["a","a","b"]
]
Hide Company Tags Bloomberg
Hide Tags Backtracking
Hide Similar Problems (H) Palindrome Partitioning II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 1 is faster

Solution 1: Backtracking and DFS
1. backtrack the string, start from 0
2. check if the last string is palindrome string
3. if it is, check until the end, and push them into the currList
4. after check the last string, remove the last elements

Solution 2: DP
use a ret[] for List<List<String>>
then at the end return the ret[len], len = s.length()
ret[i] store from the begining until current index i, all possible partitions
use a pair to check if the substring is a pal, if pair[i][j] is true,
means the substring from i to j is pal, which means i to j is palindrome.
 */
public class Solution {
    private List<List<String>> retList = new ArrayList<List<String>>();
    private List<String> curList = new ArrayList<String>();

    public List<List<String>> partition(String s) {
        backTrack(s, 0);
        return retList;
    }

    public void backTrack(String s, int index){
        if(curList.size()>0 && index>=s.length()) { //have already get one solution, add it to return list
            List<String> temp = new ArrayList<>(curList);
            retList.add(temp);
        }

        for(int i = index; i < s.length(); ++i){
            if(isPalindrome(s, index, i)){
                String str = s.substring(index, i + 1);
                curList.add(str);
                backTrack(s, i + 1);
                /*System.out.println("curList: ");
                for(String s1 : curList){
                    System.out.println(s1 + " ");
                }*/
                curList.remove(curList.size()-1); //remember to remove the last element
            }
        }
    }

    //check if (index, i) is palindrome in string s
    public boolean isPalindrome(String s, int s1, int e1){
        for(int a = s1, b = e1; a < b; a++, b-- ){
            if(s.charAt(a) != s.charAt(b)){
                return false;
            }
        }
        return true;
    }
}

//Solution 2
public class Solution {
    public List<List<String>> partition(String s) {
        if(s.length() <= 0) return new ArrayList<>();

        int len = s.length();
        List<List<String>>[] ret = new List[len+1];
        ret[0] = new ArrayList<List<String>>();
        ret[0].add(new ArrayList<String>());

        boolean[][] pair = new boolean[len][len]; //help check if the former string is palindrome
        for(int i = 0; i < len; ++i){
            ret[i+1] = new ArrayList<List<String>>();
            for(int left = 0; left <= i; ++left){
                if(s.charAt(left) == s.charAt(i) && (i-left<=1 || pair[left+1][i-1]==true)){ //remember left+1, i-1, donot change the plus or minus
                    pair[left][i] = true;
                    String str = s. substring(left, i + 1); //get the current palindrome string
                    for(List<String> r : ret[left]){
                        List<String> temp = new ArrayList<String>(r); //construct a list contains the element in the r
                        temp.add(str);
                        ret[i+1].add(temp);
                    }
                }
            }
        }

        return ret[len];
    }
}

