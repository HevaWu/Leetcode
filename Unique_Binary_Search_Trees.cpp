/*96. Unique Binary Search Trees  QuestionEditorial Solution  My Submissions
Total Accepted: 93941
Total Submissions: 242894
Difficulty: Medium
Given n, how many structurally unique BST's (binary search trees) that store values 1...n?

For example,
Given n = 3, there are a total of 5 unique BST's.

   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3
Subscribe to see which companies asked this question*/



/*DP dynamic programming
define two functions
G(n): the number of unique BST for the sequence of length n
F(i,n), 1<=i<=n: i is the root of BST, sequence ranges from 1 to n
G(n) = F(1, n) + F(2, n) + ... + F(n, n). 
G(0)=1, G(1)=1. 
F(i, n) = G(i-1) * G(n-i)	1 <= i <= n
G(n) = G(0) * G(n-1) + G(1) * G(n-2) + … + G(n-1) * G(0)  */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int numTrees(int n) {
        vector<int> G(n+1);
        G[0] = 1;
        G[1] = 1;
        for(int i = 2; i <= n; ++i){  //start from 2
            for(int j = 1; j <= i; ++j){ //start from 1 
                G[i] += G[j-1] * G[i-j];  //remember(+=)
            }
        }
        return G[n];
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int numTrees(int n) {
        int[] G = new int[n+1];
        G[0] = 1;
        G[1] = 1;
        for(int i = 2; i <= n; ++i){
            for(int j = 1; j <= i; ++j){
                G[i] += G[j-1]*G[i-j];
            }
        }
        return G[n];
    }
}