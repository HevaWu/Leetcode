/*4. Median of Two Sorted Arrays  QuestionEditorial Solution  My Submissions
Total Accepted: 119900 Total Submissions: 595846 Difficulty: Hard
There are two sorted arrays nums1 and nums2 of size m and n respectively.

Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

Example 1:
nums1 = [1, 3]
nums2 = [2]

The median is 2.0
Example 2:
nums1 = [1, 2]
nums2 = [3, 4]

The median is (2 + 3)/2 = 2.5
Hide Company Tags Google Zenefits Microsoft Apple Yahoo Dropbox Adobe
Hide Tags Binary Search Array Divide and Conquer
*/



/*binary search the two sorted array --- time complexity should be O(log (m+n))
try to find the two value, which is at the median position after merging two array
just find them, no need to merge them

binary search two sorted array
always let A.length <= B.length,if not swap two array to keep this
i is the index of A, j is the index of B
start from two median position of two array, and compare their value
if A[i] < B[j-1] i is too small, increase it
else if A[i-1] > B[j] i is too big, decrease it
else i is at the perfect position
	find the left median value of merging array
	if the total size of merging array is odd, just return the left median value
	else find the right median value of merging array
	return (left+right)/2.0 */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        int m = nums1.size();
        int n = nums2.size();
        if(m > n) {
            //swap A and B
            vector<int> temp = nums1;
            nums1 = nums2;
            nums2 = temp;
            int tem = m;
            m = n;
            n = tem;
        }
        if(n == 0) return 0;
        
        int i1 = 0, i2 = m, mid = (m+n+1)/2;
        int left = 0, right = 0;
        double median = 0;
        while(i1 <= i2){
            //must let m<n, otherwise this will throw error
            int i = (i1+i2)/2;
            int j = mid - i;
            if(i<m && nums1[i]<nums2[j-1]){
                //i is too small, increase it
                i1 = i+1;
            } else if (i>0 && nums1[i-1]>nums2[j]){
                //i is too big, decrease it
                i2 = i-1;
            } else {
                //i is at good position
                if(i==0){
                    left = nums2[j-1];
                } else if(j==0){
                    left = nums1[i-1];
                } else {
                    left = max(nums1[i-1],nums2[j-1]);
                }
                
                if((m+n)%2==1){
                    //m+n is odd
                    median = (double)left;
                    break;
                }
                
                if(i==m){
                    right = nums2[j];
                } else if(j==n){
                    right = nums1[i];
                } else{
                    right = min(nums1[i],nums2[j]);
                }
                
                median = (left+right)/2.0;
                break;
            }
        }
        return median;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        int m = nums1.length;
        int n = nums2.length;
        if(m > n){
            //swap two array
            //always keep nums1 has smaller size
            int[] temp = nums1;
            nums1 = nums2;
            nums2 = temp;
            int tem = m;
            m = n;
            n = tem;
        }
        if(n==0) return 0;
        
        //i1 and i2 is two index for nums1
        int i1 = 0, i2 = m, mid = (m+n+1)/2;
        int left = 0, right = 0;
        double median = 0;
        while(i1 <= i2){
            int i = (i1+i2)/2;
            int j = mid-i;
            if(i<m && nums1[i]<nums2[j-1]){//i is too small , remember i<m
                i1 = i+1; //change i1
            } else if(i>0 && nums1[i-1]>nums2[j]){//i is too large, remember i>0
                i2 = i-1; // change i2
            } else {//correct position
                if(i==0){
                    left = nums2[j-1];
                } else if(j==0){
                    left = nums1[i-1];
                } else {
                    left = Math.max(nums1[i-1], nums2[j-1]);
                }
                
                if((m+n)%2==1){ //total elements number is odd
                    median = (double)left;
                    break;
                }
                
                //total elements number is even
                if(i==m){
                    right = nums2[j];
                } else if(j==n){
                    right = nums1[i];
                } else {
                    right = Math.min(nums1[i], nums2[j]);
                }
                
                median = (left+right)/2.0;
                break;
            }
        }
        return median;
    }
}
