/*275. H-Index II Add to List
Description  Submission  Solutions
Total Accepted: 41693
Total Submissions: 123670
Difficulty: Medium
Contributors: Admin
Follow up for H-Index: What if the citations array is sorted in ascending order? Could you optimize your algorithm?

Hint:

Expected runtime complexity is in O(log n) and the input is sorted.
Hide Company Tags Facebook
Hide Tags Binary Search
Hide Similar Problems (M) H-Index
*/






／*
Binary Search
Since we need the time complexicty is O(logn)
search start from the middle
*／
////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int hIndex(int[] citations) {
        if(citations.length == 0) return 0;
        int len = citations.length;
        int start = 0;
        int end = len - 1;
        while(start <= end){
            int mid = (start + end)/2;
            if(citations[len-1-mid] > mid){
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }
        return start;
    }
}
