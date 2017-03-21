/*440. K-th Smallest in Lexicographical Order   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 2222
Total Submissions: 10085
Difficulty: Hard
Contributors: Stomach_ache
Given integers n and k, find the lexicographically k-th smallest integer in the range from 1 to n.

Note: 1 ≤ k ≤ n ≤ 109.

Example:

Input:
n: 13   k: 2

Output:
10

Explanation:
The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9], so the second smallest number is 10.
Hide Company Tags Hulu
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*denary tree(each node has 10 children)
find the kth element is to do a k steps preorder traverse of the tree
idea: calculate the steps between curr and curr+1 (neighbor nodes in same level)
in order to skip some steps
Main Function
1. calculate how many steps curr need ot move to curr+1
2. if steps <= k, can move to curr+1
	else, curr+1 is actually behind the target node x in the preorder path, cannot jump to curr+1, move forward one step, (cur * 10) is always the next preorder node, repeat it
Steps Function help to find the steps to curr +1
1. let n1 = curr, n2 = curr + 1
	n2 is always the next right besides n1's right most node
2. if n2 <= n, n2 exists, we can add the number of nodes from n1 to n2 steps
	if n2 > n, the next right node between n1 to n2 is n, add (n + 1 - n1) to steps
	steps += Math.min(n+1, n2) - n1
	n1 *= 10
	n2 *= 10
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int findKthNumber(int n, int k) {
        if(k > n) return -1;
        int cur = 1; //the current number
        k = k - 1; //jump one number
        while(k > 0){ //remember test k
            int step = findStep(n, cur, cur + 1);
            if(step <= k){
                cur += 1;
                k = k - step;
            } else {
                cur = cur * 10;
                k = k - 1;
            }
        }
        return cur;
    }

    //find how many nodes between n1 and n2
    public int findStep(int n, long n1, long n2){
        int step = 0;
        while(n1 <= n){ // is <= n
            step += Math.min(n+1, n2) - n1;
            n1 = n1 * 10;
            n2 = n2 * 10;
        }
        return step;
    }
}

