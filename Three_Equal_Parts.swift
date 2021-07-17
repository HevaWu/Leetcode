/*
You are given an array arr which consists of only zeros and ones, divide the array into three non-empty parts such that all of these parts represent the same binary value.

If it is possible, return any [i, j] with i + 1 < j, such that:

arr[0], arr[1], ..., arr[i] is the first part,
arr[i + 1], arr[i + 2], ..., arr[j - 1] is the second part, and
arr[j], arr[j + 1], ..., arr[arr.length - 1] is the third part.
All three parts have equal binary values.
If it is not possible, return [-1, -1].

Note that the entire part is used when considering what binary value it represents. For example, [1,1,0] represents 6 in decimal, not 3. Also, leading zeros are allowed, so [0,1,1] and [1,1] represent the same value.



Example 1:

Input: arr = [1,0,1,0,1]
Output: [0,3]
Example 2:

Input: arr = [1,1,0,1,1]
Output: [-1,-1]
Example 3:

Input: arr = [1,1,0,0,1]
Output: [0,2]


Constraints:

3 <= arr.length <= 3 * 104
arr[i] is 0 or 1
*/

/*
Solution 3:
check ones

Say S is the number of ones in A. Since every part has the same number of ones, they all should have T = S / 3 ones.
If S isn't divisible by 3, the task is impossible.

We can find the position of the 1st, T-th, T+1-th, 2T-th, 2T+1-th, and 3T-th one. The positions of these ones form 3 intervals: [i1, j1], [i2, j2], [i3, j3]. (If there are only 3 ones, then the intervals are each length 1.)

Between them, there may be some number of zeros. The zeros after j3 must be included in each part: say there are z of them (z = S.length - j3).
So the first part, [i1, j1], is now [i1, j1+z]. Similarly, the second part, [i2, j2], is now [i2, j2+z].

If all this is actually possible, then the final answer is [j1+z, j2+z+1].

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func threeEqualParts(_ arr: [Int]) -> [Int] {
        var invalid = [-1, -1]

        let n = arr.count

        var ones = arr.reduce(into: 0) { res, next in
            res += next
        }

        if ones % 3 != 0 { return invalid }
        if ones == 0 { return [0, n-1] }

        let T = ones/3
        var i1 = -1
        var j1 = -1
        var i2 = -1
        var j2 = -1
        var i3 = -1
        var j3 = -1

        var temp = 0
        for i in 0..<n where arr[i] == 1 {
            temp += 1
            // not use if else at here, because T = 1, j1, i2 can be equal
            if temp == 1 { i1 = i }
            if temp == T { j1 = i }
            if temp == T+1 { i2 = i }
            if temp == 2 * T { j2 = i }
            if temp == 2 * T + 1 { i3 = i }
            if temp == 3 * T { j3 = i }
        }
        // print(i1, j1, i2, j2, i3, j3)

        let p1 = arr[i1...j1]
        let p2 = arr[i2...j2]
        let p3 = arr[i3...j3]

        guard p1 == p2, p2 == p3  else {
            return invalid
        }

        let zero12 = i2-j1-1
        let zero23 = i3-j2-1
        let zero3 = n-j3-1

        if zero12 < zero3 || zero23 < zero3 { return invalid }
        return [j1+zero3, j2+zero3+1]
    }
}

/*
Solution 2:
iterative check 3 part

1. find proper p1 array
2. removing leading zero, and check if we can find p2 part where p1 == p2
3. removing leading zero, check if we can find p3 part where p1 == p3

Time Complexity: O(n * n)
Space Complexity: O(n/3)
*/
class Solution {
    func threeEqualParts(_ arr: [Int]) -> [Int] {
        let n = arr.count

        // skip leading zero
        var s1 = 0
        while s1 < n, arr[s1] == 0 {
            s1 += 1
        }
        if s1 == n {
            // all zero array
            return [0, n-1]
        }

        guard s1 < n-2 else { return [-1, -1] }

        var p1 = [Int]()
        for l in s1..<(n-2) {
            p1.append(arr[l])

            let len = p1.count
            let i = l

            var r = l+1
            // skip leading zero
            while r < n - 2 * len, arr[r] == 0 {
                r += 1
            }

            // print("skip", r)

            // check p2 part
            let s2 = r

            // use <= to check if there is enough space for p2, p3
            guard s2 + len <= n - len else { break }
            while r < s2 + len {
                if arr[r] != p1[r-s2] {
                    break
                }
                r += 1
            }

            // print(r)

            guard r == s2 + len else {
                // cannot find proper p2, skip later checking
                continue
            }

            // can find proper p2, check p3
            let j = r

            // skip leading zero
            while arr[r] == 0 {
                r += 1
            }

            let s3 = r
            guard s3 + len == n else { continue }
            while r < n {
                if arr[r] != p1[r-s3] {
                    break
                }
                r += 1
            }

            if r == n {
                return [i, j]
            }
        }

        return [-1, -1]
    }
}

/*
Solution 1:
Int limitation
*/
class Solution {
    func threeEqualParts(_ arr: [Int]) -> [Int] {
        // get total decimal from arr
        let total = getTotal(arr)

        let n = arr.count

        var p1 = 0
        for l in 0..<(n-2) {
            p1 <<= 1
            p1 += arr[l]

            var p2 = 0
            for r in (l+1)..<(n-1) {
                p2 <<= 1
                p2 += arr[r]
                guard p2 <= p1 else { break }

                let p3 = total - (p1 << (n-1-l)) - (p2 << (n-1-r))
                if p1 == p2, p2 == p3 {
                    return [l, r+1]
                }
                if p1 == p2 { break }
            }
        }

        return [-1, -1]
    }

    func getTotal(_ arr: [Int]) -> Int {
        var res = 0
        for num in arr {
            res <<= 1
            res += num
        }
        return res
    }
}