// There are two sorted arrays nums1 and nums2 of size m and n respectively.

// Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).

// You may assume nums1 and nums2 cannot be both empty.

// Example 1:

// nums1 = [1, 3]
// nums2 = [2]

// The median is 2.0
// Example 2:

// nums1 = [1, 2]
// nums2 = [3, 4]

// The median is (2 + 3)/2 = 2.5

// Solution 1: default sort
// 
class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var num = nums1 + nums2
        num.sort()
        let n = num.count
        return n%2==0 ? Double(num[n/2]+num[n/2-1])/Double(2) : Double(num[n/2])
    }
}

// Solution 2: binary search
// Set \text{imin} = 0imin=0, \text{imax} = mimax=m, then start searching in [\text{imin}, \text{imax}][imin,imax]¥Set i = \frac{\text{imin} + \text{imax}}{2}i= 2imin+imax, j = \frac{m + n + 1}{2} - ij= 2m+n+1−i
// Now we have \text{len}(\text{left}\_\text{part})=\text{len}(\text{right}\_\text{part})len(left_part)=len(right_part). And there are only 3 situations that we may encounter:
// \text{B}[j-1] \leq \text{A}[i]B[j−1]≤A[i] and \text{A}[i-1] \leq \text{B}[j]A[i−1]≤B[j]
// Means we have found the object ii, so stop searching.
// \text{B}[j-1] > \text{A}[i]B[j−1]>A[i]
// Means \text{A}[i]A[i] is too small. We must adjust ii to get \text{B}[j-1] \leq \text{A}[i]B[j−1]≤A[i].
// Can we increase ii?
//       Yes. Because when ii is increased, jj will be decreased.
//       So \text{B}[j-1]B[j−1] is decreased and \text{A}[i]A[i] is increased, and \text{B}[j-1] \leq \text{A}[i]B[j−1]≤A[i] may
//       be satisfied.
// Can we decrease ii?
//       No! Because when ii is decreased, jj will be increased.
//       So \text{B}[j-1]B[j−1] is increased and \text{A}[i]A[i] is decreased, and \text{B}[j-1] \leq \text{A}[i]B[j−1]≤A[i] will
//       be never satisfied.
// So we must increase ii. That is, we must adjust the searching range to [i+1, \text{imax}][i+1,imax].
// So, set \text{imin} = i+1imin=i+1, and goto 2.
// \text{A}[i-1] > \text{B}[j]A[i−1]>B[j]:
// Means \text{A}[i-1]A[i−1] is too big. And we must decrease ii to get \text{A}[i-1]\leq \text{B}[j]A[i−1]≤B[j].
// That is, we must adjust the searching range to [\text{imin}, i-1][imin,i−1].
// So, set \text{imax} = i-1imax=i−1, and goto 2.
// 
// max(A[i−1],B[j−1]), when m + nm+n is odd
// \frac{\max(\text{A}[i-1], \text{B}[j-1]) + \min(\text{A}[i], \text{B}[j])}{2},2max(A[i−1],B[j−1])+min(A[i],B[j]), when m + nm+n is even
// 
// Searching ii in [0, m][0,m], to find an object ii such that:(j = 0(j=0 or i = mi=m or \text{B}[j-1] \leq \text{A}[i])B[j−1]≤A[i]) and(i = 0(i=0 or j = nj=n or \text{A}[i-1] \leq \text{B}[j]),A[i−1]≤B[j]), where j = \frac{m + n + 1}{2} - ij= 2m+n+1−i
// 
// Time complexity: O\big(\log\big(\text{min}(m,n)\big)\big)O(log(min(m,n))).
// At first, the searching range is [0, m][0,m]. And the length of this searching range will be reduced by half after each loop. So, we only need \log(m)log(m) loops. Since we do constant operations in each loop, so the time complexity is O\big(\log(m)\big)O(log(m)). Since m \leq nm≤n, so the time complexity is O\big(\log\big(\text{min}(m,n)\big)\big)O(log(min(m,n))).
// Space complexity: O(1)O(1).
// We only need constant memory to store 99 local variables, so the space complexity is O(1)O(1).
class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var m = nums1.count
        var n = nums2.count
        
        // always make sure m <= n
        var nums1 = nums1
        var nums2 = nums2
        if m>n {
            let temp = nums1
            nums1 = nums2
            nums2 = temp
            
            var tmp = m
            m = n
            n = tmp
        }
        
        var imin = 0
        var imax = m
        var halfLen = (m+n+1)/2
        
        while imin <= imax {
            var i = (imin+imax)/2
            var j = halfLen - i
            
            print(i,j, nums1, nums2, m, n)
            if i < imax, nums2[j-1] > nums1[i] { // i is too small
                imin = i+1
            } else if i > imin, nums1[i-1] > nums2[j] { // i is too large
                imax = i-1
            } else { // i is perfect, return value
                var maxLeft = 0
                if i == 0 { maxLeft = nums2[j-1] }
                else if j == 0 { maxLeft = nums1[i-1]}
                else { maxLeft = max(nums1[i-1], nums2[j-1]) }
                if (m+n)%2 == 1 { return Double(maxLeft) }
                
                var minRight = 0
                if i == m { minRight = nums2[j] }
                else if j == n { minRight = nums1[i] }
                else { minRight = min(nums2[j], nums1[i]) }
            
                return Double(maxLeft+minRight)/2.0
            }
        }
        return Double(0)
    }
}

