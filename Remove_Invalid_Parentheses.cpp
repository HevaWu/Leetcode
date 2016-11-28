/*301. Remove Invalid Parentheses  QuestionEditorial Solution  My Submissions
Total Accepted: 18009
Total Submissions: 53928
Difficulty: Hard
Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

Note: The input string may contain letters other than the parentheses ( and ).

Examples:
"()())()" -> ["()()()", "(())()"]
"(a)())()" -> ["(a)()()", "(a())()"]
")(" -> [""]
Credits:
Special thanks to @hpplayer for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*define left and right to decide if the parentheses are a pair*/
/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> removeInvalidParentheses(string s) {
        unordered_set<string> ret;
        int left = 0;
        int right = 0;
        for(auto c:s){
            if(c == '('){
                ++left;
            }
            
            if(c == ')'){
                if(left != 0){
                    --left;
                } else {
                    ++right;
                }
            }
        }
        
        check(s, 0, left, right, 0, "", ret);
        return vector<string>(ret.begin(), ret.end());
    }
    
private:
    void check(string s, int index, int left, int right, int pair, string path, unordered_set<string>& ret){
        if(index == s.size()){
            if(left == 0 && right == 0 && pair == 0){
                ret.insert(path);
            }
            return;
        }
        
        if(s[index] != '(' && s[index] != ')'){
            check(s, index + 1, left, right, pair, path+s[index], ret);
        } else {
            if(s[index] == '('){
                if(left > 0){
                    check(s, index + 1, left - 1, right, pair, path, ret);
                }
                check(s, index + 1, left, right, pair + 1, path + s[index], ret);
            }
            
            if(s[index] == ')'){
                if(right > 0){
                    check(s, index + 1, left, right - 1, pair, path, ret);
                }
                
                if(pair > 0){
                    check(s, index + 1, left, right, pair - 1, path + s[index], ret);
                }
            }
        }
    }
};





/*Use one count to decide if the parentheses are pairs*/
/*Time complexity:

In BFS we handle the states level by level, in the worst case, we need to handle all the levels, we can analyze the time complexity level by level and add them up to get the final complexity.

On the first level, there's only one string which is the input string s, let's say the length of it is n, to check whether it's valid, we need O(n) time. On the second level, we remove one ( or ) from the first level, so there are C(n, n-1) new strings, each of them has n-1 characters, and for each string, we need to check whether it's valid or not, thus the total time complexity on this level is (n-1) x C(n, n-1). Come to the third level, total time complexity is (n-2) x C(n, n-2), so on and so forth...

Finally we have this formula:

T(n) = n x C(n, n) + (n-1) x C(n, n-1) + ... + 1 x C(n, 1) = n x 2^(n-1).*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> removeInvalidParentheses(String s) {
        List<String> ret = new ArrayList<>();
        if(s==null){
            return ret;
        }
        
        Set<String> S = new HashSet<>();
        Queue<String> Q = new LinkedList<>();
        
        Q.add(s);
        S.add(s);
        
        boolean found = false;
        
        while(!Q.isEmpty()){
            s = Q.poll();
            if(isValid(s)){
                ret.add(s);
                found = true;
            }
            
            if(found) continue;
            
            for(int i = 0; i < s.length(); i++){
                if(s.charAt(i) != '(' && s.charAt(i) != ')') continue;
                String t = s.substring(0,i) + s.substring(i+1);
                if(!S.contains(t)){
                    Q.add(t);
                    S.add(t);
                }
            }
        }
        return ret;
    }
    
    public boolean isValid(String s){
        int count = 0;
        for(int i = 0; i < s.length(); i++){
            char c = s.charAt(i);
            if(c == '(') count++;
            // System.out.println(count);
            if(c == ')' && count-- == 0) return false;
        }
        return count == 0;
    }
}