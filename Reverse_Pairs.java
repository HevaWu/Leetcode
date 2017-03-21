/*493. Reverse Pairs Add to List
Description  Submission  Solutions
Total Accepted: 2345
Total Submissions: 13235
Difficulty: Hard
Contributors: ckcz123
Given an array nums, we call (i, j) an important reverse pair if i < j and nums[i] > 2*nums[j].

You need to return the number of important reverse pairs in the given array.

Example1:

Input: [1,3,2,3,1]
Output: 2
Example2:

Input: [2,4,3,5,1]
Output: 3
Note:
The length of the given array will not exceed 50,000.
All the numbers in the input array are in the range of 32-bit integer.
Hide Company Tags Google
Hide Tags Binary Indexed Tree Segment Tree Binary Search Tree Divide and Conquer
Hide Similar Problems (H) Count of Smaller Numbers After Self
 */






/*
Solution 2 faster than Solution 1 faster than Solution 3

Solution 1: merge sort 129ms/137 test
O(nlogn)
in each round, divide array into two parts and sort them
after int count = mergeSort(nums, s, mid) + mergeSort(nums, mid+1, e)
the left part and right part are sorted,
only need to count how many pairs of number(leftPart[i], rightPart[j])
satisfies leftPart[i] <= 2*rightPart[j]

Solution 2: implement merge sort by ourselves

Solution 3: BST
O(n^2)
time limit at case[0,1,2,3,..,4999] should return 0
Build TreeNode
    TreeNode left, right
    int val, count
    TreeNode(val){
        this.val = val;
        count = 1;
    }
Overall Algorithm:
    Scan the numbers from right to left.
    First search the tree to get "count" of numbers smaller than "nums[i] / 2.0", sum to the final result.
    Insert "nums[i]" to the tree.
insertNode logic:
    Recursively try to find a place to insert this number. When "root" is "null", its time to create a new node. If meet the same number, just increase the "count".
    When try to insert the number to "left" sub-tree, increase "count" of current node.
searchNode logic:
    If "target" value is greater than the current value, meaning current node and all left sub-tree are smaller than "target",
    return "count" (remember it stands for count of numbers smaller or equal to current number) of current node plus any possible smaller number than target in right sub-tree.
    Otherwise, only search left sub-tree.
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: merge sort arrays.sort
public class Solution {
    public int reversePairs(int[] nums) {
        if(nums==null || nums.length==0) return 0;
        return mergeSort(nums, 0, nums.length-1);
    }

    public int mergeSort(int[] nums, int s, int e){
        if(s>=e) return 0;
        int mid = (s+e)/2;
        int count = mergeSort(nums, s, mid) + mergeSort(nums, mid+1, e);
        //i start from s, j start from mid+1
        for(int i = s, j = mid+1; i <= mid; ++i){
            while(j<=e && nums[i]/2.0>nums[j]) j++;
            count += j-(mid+1);
        }
        //there is a sort limit, only the array we already count sorted
        Arrays.sort(nums, s, e+1);
        return count;
    }
}


//Solution 2: merge sort implement merge sort by myself
public class Solution {
    private int[] temp;

    public int reversePairs(int[] nums) {
        if(nums==null || nums.length==0) return 0;
        this.temp = new int[nums.length];
        return mergeSort(nums, 0, nums.length-1);
    }

    public int mergeSort(int[] nums, int s, int e){
        if(s>=e) return 0;
        int mid = (s+e)/2;
        int count = mergeSort(nums,s,mid) + mergeSort(nums,mid+1,e);
        for(int i = s, j = mid+1; i <= mid; ++i){
            while(j<=e && nums[i]/2.0>nums[j]) j++;
            count += j-(mid+1);
        }

        //Arrays.sort(nums, s, e+1);
        //could write the sort part by mergesort
        mymerge(nums, s, mid, e);
        return count;
    }

    public void mymerge(int[] nums, int s, int mid, int e){
        for(int i = s; i <= e; ++i) temp[i] = nums[i];
        int p1 = s;
        int p2 = mid+1;
        int i = s;
        while(p1<=mid || p2<=e){
            if(p1>mid || (p2<=e && temp[p1] > temp[p2])){
                nums[i++] = temp[p2++];
            } else {
                nums[i++] = temp[p1++];
            }
        }
    }
}




//Solution 3: BST
public class Solution {
    public class TreeNode{
        int val, count;
        TreeNode left, right;
        TreeNode(int val){
            this.val = val;
            //count means the node.val less than or equal to root.val, means its left child
            count = 1;
        }
    }

    public int reversePairs(int[] nums) {
        if(nums==null || nums.length==0) return 0;

        int len = nums.length;
        //build a TreeNode root
        TreeNode root = new TreeNode(nums[len-1]);

        //start binary search, from right to left
        int pairs = 0; //the return count of pairs
        for(int i = len-2; i>=0; --i){
            pairs += searchNode(root, nums[i]/2.0);
            insertNode(root, nums[i]);
        }

        return pairs;
    }

    public int searchNode(TreeNode root, double target){
        if(root==null) return 0;
        if(root.val < target){
            //search right child, and add root.count
            return root.count + searchNode(root.right, target);
        } else {
            //search left child
            return searchNode(root.left, target);
        }
    }

    public TreeNode insertNode(TreeNode root, int target){
        //if there is no root, create a new root
        if(root==null) return new TreeNode(target);

        if(root.val == target){
            root.count++;
        } else if(root.val < target){
            //insert to right child
            root.right = insertNode(root.right, target);
        } else {
            //insert to left child
            root.count++;
            root.left = insertNode(root.left, target);
        }
        return root;
    }
}
