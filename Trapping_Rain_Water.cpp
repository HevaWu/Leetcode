/*42. Trapping Rain Water  QuestionEditorial Solution  My Submissions
Total Accepted: 83168 Total Submissions: 243044 Difficulty: Hard
Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

For example,
Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.


The above elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped. Thanks Marcos for contributing this image!

Hide Company Tags Google Twitter Zenefits Amazon Apple Bloomberg
Hide Tags Array Stack Two Pointers
Hide Similar Problems (M) Container With Most Water (M) Product of Array Except Self (H) Trapping Rain Water II
*/



/*O(n) time, O(1) space
Two Pointers,
one for left, one for right,
try to find the maxL and maxR seperately
compare A[left] and A[right]
if A[left]<=A[right]
	if A[left]>=maxL, update maxL, otherwise, add the ret water
	left++
otherwise, compare A[right] and maxR, similarly to right side, and right--*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int trap(vector<int>& height) {
        int left = 0, right = height.size()-1;
        if(height.size()<=1) return 0;
        int ret = 0;
        int maxL = 0, maxR = 0;
        while(left <= right){
            if(height[left] <= height[right]){
                //check left side,
                if(height[left] >= maxL){
                    maxL = height[left];
                } else {
                    ret += maxL-height[left];
                }
                left++;
            } else {
                //check right side
                if(height[right] >= maxR){
                    maxR = height[right];
                } else {
                    ret += maxR-height[right];
                }
                right--;
            }
        }
        return ret;
    }
};





/*
Solution 1 faster than Solution 2

Solution 1:
O(n) time, O(1) space
Two Pointers,
one for left, one for right,
try to find the maxL and maxR seperately
compare A[left] and A[right]
if A[left]<=A[right]
    if A[left]>=maxL, update maxL, otherwise, add the ret water
    left++
otherwise, compare A[right] and maxR, similarly to right side, and right--

Solution 2:
Stack
use Stack to store the "index" of current walls  --- which is the left limit
once we find a wall larger than current S.peek() value,
which means there is a right wall make a water trapping
count the trap and add it to the total water
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int trap(int[] height) {
        if(height==null || height.length==0) return 0;
        int left = 0, right = height.length-1;
        int ret = 0;
        int maxL = 0, maxR = 0;
        while(left <= right){
            if(height[left] <= height[right]) {
                //check left side
                if(height[left] >= maxL) {
                    maxL = height[left];
                } else {
                    ret += maxL-height[left];
                }
                left++; //remember left++
            } else {
                //check the right side
                if(height[right] >= maxR) {
                    maxR = height[right];
                } else {
                    ret += maxR-height[right];
                }
                right--;// remember right--
            }
        }
        return ret;
    }
}





//Solution 2
public class Solution {
    public int trap(int[] height) {
        if(height == null || height.length == 0) return 0;
        Stack<Integer> S = new Stack<>();
        int index = 0;
        int water = 0;
        while(index < height.length){
            if(S.isEmpty() || height[index] <= height[S.peek()]){
                //store the left wall, remember update the index
                S.push(index++);
            } else {
                //there is a right wall
                int bottom = S.pop(); //current index of bottom value
                //store current trapping water in "water" element
                //Math.min(height[index], height[S.peek()]) --- get the lowest wall
                // - height[bottom] --- get the vertical gap
                // *(index-S.peek()-1) --- get the horizontal gap
                water += S.isEmpty() ? 0 : (Math.min(height[index], height[S.peek()]) - height[bottom])*(index-S.peek()-1);
            }
        }
        return water;
    }
}
