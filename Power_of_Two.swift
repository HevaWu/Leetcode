/*
Given an integer n, return true if it is a power of two. Otherwise, return false.

An integer n is a power of two, if there exists an integer x such that n == 2x.
*/


class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        var num = 1
        while n > num {
            num <<= 1
        }
        return n == num
    }
}

class Solution {
    func isPowerOfTwo(_ n: Int) -> Bool {
        return (n > 0) && (n & (n-1) == 0)
    }
}