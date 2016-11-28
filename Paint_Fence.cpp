/*276. Paint Fence   QuestionEditorial Solution  My Submissions
Total Accepted: 14434 Total Submissions: 43627 Difficulty: Easy Contributors: Admin
There is a fence with n posts, each post can be painted with one of the k colors.

You have to paint all the posts such that no more than two adjacent fence posts have the same color.

Return the total number of ways you can paint the fence.

Note:
n and k are non-negative integers.

Hide Company Tags Google
Hide Tags Dynamic Programming
Hide Similar Problems (E) House Robber (M) House Robber II (M) Paint House (H) Paint House II
*/



/* O(n) time O(1) space
Dynamic Programming
there is no more than two ajacent fence posts have the same color 
it is two possibilities:
1. the last two posts have the same color --- use same to count this situation
2. the last two posts have the different colors --- use diff to count this situation

when adding a new post, we use the same color as the last one or different color
if use diff, there are k-1 options --- diff = (diff+same)*(k-1)
if use same, only one option --- same = temp(which store the pre diff)


eg: let's say we have 3 posts and 3 colors. The first two posts we have 9 ways to do them, (1,1), (1,2), (1,3), (2,1), (2,2), (2,3), (3,1), (3,2), (3,3). Now we know that
diffColorCounts = 6; And sameColorCounts = 3;
Now for the third post, we can compute these two variables like this:

If we use different colors than the last one (the second one), these ways can be added into diffColorCounts, so if the last one is 3, we can use 1 or 2, if it's 1, we can use 2 or 3, etc. Apparently there are (diffColorCounts + sameColorCounts) * (k-1) possible ways.
If we use the same color as the last one, we would trigger a violation in these three cases (1,1,1), (2,2,2) and (3,3,3). This is because they already used the same color for the last two posts. So use the diffColorCounts. */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int numWays(int n, int k) {
        if(n==0) return 0;
        if(n==1) return k;
        
        //for the first two posts there are two possiblities
        int same = k;
        int diff = k*(k-1);
        for(int i = 2; i < n; ++i){
            int temp = diff;
            diff = (same+diff)*(k-1);
            same = temp;
        }
        return diff+same;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int numWays(int n, int k) {
        if(n==0) return 0;
        if(n==1) return k;
        
        //for the first two posts
        int same = k;
        int diff = k * (k-1);
        for(int i = 2; i < n; ++i){
            int temp = diff; //store pre diff counts
            diff = (same+diff)*(k-1);
            same = temp;
        }
        return diff+same;
    }
}
