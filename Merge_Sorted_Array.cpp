/*
Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.
*/

class Solution {
public:
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int i = m - 1, j = n-1, nmerge = m+n-1;
        while(j>=0){
            nums1[nmerge--] = i>=0&&nums1[i]>=nums2[j] ? nums1[i--] : nums2[j--];
        }
    }
};