/*
An n-bit gray code sequence is a sequence of 2n integers where:

Every integer is in the inclusive range [0, 2n - 1],
The first integer is 0,
An integer appears no more than once in the sequence,
The binary representation of every pair of adjacent integers differs by exactly one bit, and
The binary representation of the first and last integers differs by exactly one bit.
Given an integer n, return any valid n-bit gray code sequence.



Example 1:

Input: n = 2
Output: [0,1,3,2]
Explanation:
The binary representation of [0,1,3,2] is [00,01,11,10].
- 00 and 01 differ by one bit
- 01 and 11 differ by one bit
- 11 and 10 differ by one bit
- 10 and 00 differ by one bit
[0,2,3,1] is also a valid gray code sequence, whose binary representation is [00,10,11,01].
- 00 and 10 differ by one bit
- 10 and 11 differ by one bit
- 11 and 01 differ by one bit
- 01 and 00 differ by one bit
Example 2:

Input: n = 1
Output: [0,1]


Constraints:

1 <= n <= 16
*/

/*
Solution 5:
iterative 2

Time Complexity: O(2^n)
Space Complexity: O(1)
*/
class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var res = [Int]()
        let len = 1<<n
        for i in 0..<len {
            let num = i ^ (i >> 1)
            res.append(num)
        }
        return res
    }

}

/*
Solution 4:
recursive 2

flip bit

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var res = [Int]()
        var next = 0
        check(&next, n, &res)
        return res
    }

    func check(_ next: inout Int, _ n: Int, _ res: inout [Int]) {
        if n == 0 {
            res.append(next)
            return
        }

        check(&next, n-1, &res)
        next = next ^ (1<<(n-1))
        check(&next, n-1, &res)
    }
}

/*
Solution 3:
iterative

Time Complexity: O(2^n)
Space Complexity: O(1)
*/
class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var res = [Int]()
        res.append(0)

        for i in 1...n {
            let size = res.count
            let mask = 1<<(i-1)
            for j in stride(from: size-1, through: 0, by: -1) {
                res.append(mask | res[j])
            }
        }

        return res
    }
}

/*
Solution 2:
recursive

00
01
11
10

mask | reverse of previous order

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var res = [Int]()
        check(n, &res)
        return res
    }

    func check(_ n: Int, _ res: inout [Int]) {
        if n == 0 {
            res.append(0)
            return
        }

        check(n-1, &res)
        let size = res.count
        let mask = 1<<(n-1)
        for i in stride(from: size-1, through: 0, by: -1) {
            res.append(res[i] | mask)
        }
    }
}

/*
Solution 1:

Idea:
- add by size, check from len=2 to n, ex: 0, 1,| 11, 10, | 110, 111, 101, 100, ...
- for each size, always record "pre" element, and check (0..<len) index to see if we can convert 1 and find valid next val

Time Complexity: O(n * 2^(n-1) * n)
Space Complexity: O(2^n)
*/
class Solution {
    func grayCode(_ n: Int) -> [Int] {
        var res = [0, 1]

        guard n > 1 else { return res }

        var visited = Set<Int>()
        visited.insert(0)

        for len in 2...n {
            let size = 1<<(len-1)
            var pre = size + res[size-1]
            visited.insert(pre)
            res.append(pre)

            for i in 1..<size {
                for j in 0..<len {
                    let val = pre ^ (1<<j)
                    if !visited.contains(val) {
                        visited.insert(val)
                        res.append(val)
                        pre = val
                        break
                    }
                }
            }
        }
        return res
    }
}