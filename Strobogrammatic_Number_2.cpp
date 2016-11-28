/*247. Strobogrammatic Number II   QuestionEditorial Solution  My Submissions
Total Accepted: 13444 Total Submissions: 36567 Difficulty: Medium Contributors: Admin
A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

Find all strobogrammatic numbers that are of length = n.

For example,
Given n = 2, return ["11","69","88","96"].

Hint:

Try to use recursion and notice that it should recurse with n - 2 instead of n - 1.
Hide Company Tags Google
Hide Tags Math Recursion
Hide Similar Problems (E) Strobogrammatic Number (H) Strobogrammatic Number III
*/



/* O(size of string) time
recursive
findPair(int n, int m) --- find n size elements which are strobogrammatic, m is the total size we need to return
	if(n==0) return ""
	if(n==1) return "0""1""8"
	each time find findPair(n-2,m), and recursively add the return value to ret
	*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> findStrobogrammatic(int n) {
        return findPair(n, n);
    }
    
    vector<string> findPair(int n, int m){
        if(n==0) return vector<string>({""});
        if(n==1) return vector<string>({"0","1","8"});
        
        vector<string> temp = findPair(n-2, m);
        vector<string> ret;
        for(int i = 0; i < temp.size(); ++i){
            string s = temp[i];
            if(n != m) ret.push_back("0" + s + "0");
            ret.push_back("1" + s + "1");
            ret.push_back("6" + s + "9");
            ret.push_back("8" + s + "8");
            ret.push_back("9" + s + "6");
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> findStrobogrammatic(int n) {
        return findPair(n, n);
    }
    
    public List<String> findPair(int n, int m){
        //return list of strobogrammatic with the size of n 
        
        //use arrays.aslist
        if(n==0) return new ArrayList<String>(Arrays.asList(""));
        if(n==1) return new ArrayList<String>(Arrays.asList("0","1","8"));
        
        List<String> temp = findPair(n-2, m);
        List<String> ret = new ArrayList<>();
        for(int i = 0; i < temp.size(); ++i){
            String s = temp.get(i);//use get()
            if(n!=m) ret.add("0" + s + "0"); //consider 0 situation
            ret.add("1" + s + "1");
            ret.add("6" + s + "9");
            ret.add("8" + s + "8");
            ret.add("9" + s + "6");
        }
        return ret;
    }
}
