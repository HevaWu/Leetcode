/*
You have n packages that you are trying to place in boxes, one package in each box. There are m suppliers that each produce boxes of different sizes (with infinite supply). A package can be placed in a box if the size of the package is less than or equal to the size of the box.

The package sizes are given as an integer array packages, where packages[i] is the size of the ith package. The suppliers are given as a 2D integer array boxes, where boxes[j] is an array of box sizes that the jth supplier produces.

You want to choose a single supplier and use boxes from them such that the total wasted space is minimized. For each package in a box, we define the space wasted to be size of the box - size of the package. The total wasted space is the sum of the space wasted in all the boxes.

For example, if you have to fit packages with sizes [2,3,5] and the supplier offers boxes of sizes [4,8], you can fit the packages of size-2 and size-3 into two boxes of size-4 and the package with size-5 into a box of size-8. This would result in a waste of (4-2) + (4-3) + (8-5) = 6.
Return the minimum total wasted space by choosing the box supplier optimally, or -1 if it is impossible to fit all the packages inside boxes. Since the answer may be large, return it modulo 109 + 7.



Example 1:

Input: packages = [2,3,5], boxes = [[4,8],[2,8]]
Output: 6
Explanation: It is optimal to choose the first supplier, using two size-4 boxes and one size-8 box.
The total waste is (4-2) + (4-3) + (8-5) = 6.
Example 2:

Input: packages = [2,3,5], boxes = [[1,4],[2,3],[3,4]]
Output: -1
Explanation: There is no box that the package of size 5 can fit in.
Example 3:

Input: packages = [3,5,8,10,11,12], boxes = [[12],[11,9],[10,5,14]]
Output: 9
Explanation: It is optimal to choose the third supplier, using two size-5 boxes, two size-10 boxes, and two size-14 boxes.
The total waste is (5-3) + (5-5) + (10-8) + (10-10) + (14-11) + (14-12) = 9.


Constraints:

n == packages.length
m == boxes.length
1 <= n <= 105
1 <= m <= 105
1 <= packages[i] <= 105
1 <= boxes[j].length <= 105
1 <= boxes[j][k] <= 105
sum(boxes[j].length) <= 105
The elements in boxes[j] are distinct.
*/

/*
Solution 1:
binary search

The key is for each package, we always use the box with minimum size if possible, because larger box brings more wasted space. Therefore, use binary search to fit each box and use presum to count the wasted space.

Idea:
- sort packages, get maxP (maximum package size), and sumP (sum of all package size)
- for each box in boxes, sort it first
  - check if current box largest b can fit maxP or not, if not, skip current box
  - try to find sumB which is maximum box size by using box
    - find this by go through box, to see how many box used for put proper packages[preIndex...index]
    - sumB += (preIndex-index)*b
  - minSpace = min(minSpace, sumB - sumP)
- do mod at the end

Time Complexity: O(nlogn + n + m*klogk)
Space Complexity: O(n+m)
*/
class Solution {
    func minWastedSpace(_ packages: [Int], _ boxes: [[Int]]) -> Int {
        let mod = Int(1e9 + 7)

        let n = packages.count
        var packages = packages.sorted()

        let maxP = packages[n-1]

        // sum of packages
        var sumP = 0
        for i in 0..<n {
            sumP += packages[i]
        }

        var minSpace = Int.max
        for box in boxes {
            var sortBox = box.sorted()
            if maxP > sortBox.last! {
                // current supplier cannot use for last package
                continue
            }

            let sumB = check(packages, sortBox, n)
            minSpace = min(minSpace, sumB - sumP)
        }
        // mod result at the end
        return minSpace == Int.max ? -1 : minSpace % mod
    }

    func check(_ packages: [Int], _ box: [Int], _ n: Int) -> Int {
        var sumB = 0
        var preIndex = 0

        // use box to check how many box required for packages
        for b in box {
            if b < packages[0] { continue }
            let index = find(b, packages)
            sumB += (index-preIndex) * b
            if index >= n { break }
            preIndex = index
        }
        return sumB
    }

    // DO bisect_right at here
    // return minIndex which arr[index] >= target
    func find(_ target: Int, _ arr: [Int]) -> Int {
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] <= target {
                left = mid+1
            } else {
                right = mid
            }
        }

        return arr[left] <= target ? left + 1 : left
    }
}