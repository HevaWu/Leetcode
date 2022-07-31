/*
Given an array nums and two types of queries where you should update the value of an index in the array, and retrieve the sum of a range in the array.

Implement the NumArray class:

NumArray(int[] nums) initializes the object with the integer array nums.
void update(int index, int val) updates the value of nums[index] to be val.
int sumRange(int left, int right) returns the sum of the subarray nums[left, right] (i.e., nums[left] + nums[left + 1], ..., nums[right]).


Example 1:

Input
["NumArray", "sumRange", "update", "sumRange"]
[[[1, 3, 5]], [0, 2], [1, 2], [0, 2]]
Output
[null, 9, null, 8]

Explanation
NumArray numArray = new NumArray([1, 3, 5]);
numArray.sumRange(0, 2); // return 9 = sum([1,3,5])
numArray.update(1, 2);   // nums = [1,2,5]
numArray.sumRange(0, 2); // return 8 = sum([1,2,5])


Constraints:

1 <= nums.length <= 3 104
-100 <= nums[i] <= 100
0 <= index < nums.length
-100 <= val <= 100
0 <= left <= right < nums.length
At most 3 104 calls will be made to update and sumRange.

*/

/*
Solution 2:
binary index tree

Example: given an array a[0]...a[7], n=8, we use a array BIT[9] to
represent a tree,
where index [2] is the parent of [1] and [3],
[6] is the parent of [5] and [7],
[4] is the parent of [2] and [6], and
[8] is the parent of [4]. I.e.,

BIT[] as a binary tree:
               ______________*
               ______*
               __*     __*
               *   *   *   *
bit indices: 0 1 2 3 4 5 6 7 8

BIT[i] = (
    [i] is a left child
    ? the partial sum from its left most descendant to itself
    : the partial sum from its parent (exclusive) to itself. (check the range of "__"
).

Eg. BIT[1]=a[0],
BIT[2]=a[1]+BIT[1]=a[1]+a[0],
BIT[3]=a[2],
BIT[4]=a[3]+BIT[3]+BIT[2]=a[3]+a[2]+a[1]+a[0],
BIT[5]=a[4]
BIT[6]=a[5]+BIT[5]=a[5]+a[4],
BIT[7]=a[6]
BIT[8]=a[7]+BIT[7]+BIT[6]+BIT[4]=a[7]+a[6]+...+a[0], ...

Thus, to update a[1]=BIT[2], we shall update BIT[2], BIT[4], BIT[8],
i.e., for current [i], the next update [j] is j=i+(i&-i) //double the
last 1-bit from [i].

Similarly, to get the partial sum up to a[6]=BIT[7], we shall get the
sum of BIT[7], BIT[6], BIT[4], i.e., for current [i], the next
summand [j] is j=i-(i&-i) // delete the last 1-bit from [i].

To obtain the original value of a[7] (corresponding to index [8] of
BIT), we have to subtract BIT[7], BIT[6], BIT[4] from BIT[8], i.e.,
starting from [idx-1], for current [i], the next subtrahend [j] is
j=i-(i&-i), up to j==idx-(idx&-idx) exclusive. (However, a quicker
way but using extra space is to store the original array.)

Time Complexity: O(log n)
Space Complexity: O(n)
*/

class NumArray {
    var nums: [Int]
    var BIT: [Int]
    let n: Int

    init(_ nums: [Int]) {
        self.nums = nums
        n = nums.cou
        BIT = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            insertBIT(i, nums[i])
        }
    }

    private func insertBIT(_ i: Int, _ val: Int) {
        // print("init", i)
        var i = i + 1
        while i <= n {
            BIT[i] += val
            // double last 1-bit from [i]
            i += (i & -i)
            // print(i)
        }
    }

    func update(_ index: Int, _ val: Int) {
        var diff = val - nums[index]
        nums[index] = val
        insertBIT(index, diff)
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {
        return getSum(right) - getSum(left-1)
    }

    private func getSum(_ i: Int) -> Int {
        // print("getSum", i)
        var i = i+1
        var sum = 0
        while i > 0 {
            sum += BIT[i]
            // delete last 1-bit from [i]
            i -= (i & -i)
            // print(i)
        }
        return sum
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * obj.update(index, val)
 * let ret_2: Int = obj.sumRange(left, right)
 */


/*
Solution 1:
segment tree

1. build segment tree
    - if node p holds sum of [i...j] range, its left hold [i... (i+j)/2], its right hold [i+j/2 + 1, j]
2. update segment tree
    - rebuild segment tree, use bottom-up update the leaf node that contains a[i]
3. find sum of [L, R]
    - check if l is right child of parent P
        - if is, P contains sum of range of l and another child which is outside the range
        - if not, P contains sum of range which lies in [l,r], Add P to sum
    - check if r is left child of P
        - if is, P contains sum of range of r, and another child which is outside the range
        - if not, P contains sum of range which lies in [l, r], Add P to sum

Time Complexity:
- init: build tree, O(n)
- update: O(log n)
- rangeSum: O(log n)

Space Complexity:
- init: build tree, O(n)
- update: O(1)
- rangeSum: O(1)
*/
class NumArray {
    // segmentTree
    var tree: [Int] = [Int]()
    var n: Int = 0

    init(_ nums: [Int]) {
        guard !nums.isEmpty else { return }
        n = nums.count
        tree = Array(repeating: 0, count: n*2)
        buildTree(nums)
    }

    private func buildTree(_ nums: [Int]) {
        var i = n
        var j = 0
        while i < 2 * n {
            tree[i] = nums[j]
            i += 1
            j += 1
        }

        i = n-1
        while i > 0 {
            tree[i] = tree[i*2] + tree[i*2+1]
            i -= 1
        }
    }

    func update(_ index: Int, _ val: Int) {
        var pos = index + n
        tree[pos] = val
        while pos > 0 {
            var left = pos
            var right = pos
            if pos % 2 == 0 {
                right = pos + 1
            } else {
                right = pos - 1
            }

            tree[pos/2] = tree[left] + tree[right]
            pos /= 2
        }
    }

    func sumRange(_ left: Int, _ right: Int) -> Int {
        var l = left + n
        var r = right + n
        var sum = 0
        while l <= r {
            if l % 2 == 1 {
                // l is P's right node, should not add another child, add l itself into sum
                sum += tree[l]
                l += 1
            }
            if r % 2 == 0 {
                // r is P's left node, should not add another child, add r itself into sum
                sum += tree[r]
                r -= 1
            }
            l /= 2
            r /= 2
        }
        return sum
    }
}


/**
 Your NumArray object will be instantiated and called as such:
 let obj = NumArray(nums)
 obj.update(index, val)
 let ret_2: Int = obj.sumRange(left, right)
 */