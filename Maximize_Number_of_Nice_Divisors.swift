/*
You are given a positive integer primeFactors. You are asked to construct a positive integer n that satisfies the following conditions:

The number of prime factors of n (not necessarily distinct) is at most primeFactors.
The number of nice divisors of n is maximized. Note that a divisor of n is nice if it is divisible by every prime factor of n. For example, if n = 12, then its prime factors are [2,2,3], then 6 and 12 are nice divisors, while 3 and 4 are not.
Return the number of nice divisors of n. Since that number can be too large, return it modulo 109 + 7.

Note that a prime number is a natural number greater than 1 that is not a product of two smaller natural numbers. The prime factors of a number n is a list of prime numbers such that their product equals n.



Example 1:

Input: primeFactors = 5
Output: 6
Explanation: 200 is a valid value of n.
It has 5 prime factors: [2,2,2,5,5], and it has 6 nice divisors: [10,20,40,50,100,200].
There is not other value of n that has at most 5 prime factors and more nice divisors.
Example 2:

Input: primeFactors = 8
Output: 18


Constraints:

1 <= primeFactors <= 109
*/

/*
Solution 2:
Math

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func maxNiceDivisors(_ primeFactors: Int) -> Int {
        if primeFactors < 3 { return primeFactors }

        let mod = Int(1e9 + 7)
        let a = primeFactors / 3
        let b = primeFactors % 3
        if b == 0 {
            return helpPow(3, a, mod)
        } else if b == 1 {
            return helpPow(3, a-1, mod) * 4 % mod
        } else if b == 2 {
            return helpPow(3, a, mod) * 2 % mod
        }
        return 0
    }

    // fast Exponentiation algorithm
    func helpPow(_ a: Int, _ power: Int, _ mod: Int) -> Int {
        var res = 1
        var a = a
        var power = power
        while power != 0 {
            // power % 2 == 1
            if power & 1 == 1 {
                res = res * a % mod
            }
            // power/2
            power >>= 1
            a = (a * a) % mod
        }
        return res
    }
}

/*
Solution 1:
backTrack check all of permutation
Time Limit Exceeded

Time Complexity: O(n + logn logn + n * remain!)
Space Complexity: O(1)
*/
class Solution {
    let mod = Int(1e9 + 7)

    func maxNiceDivisors(_ primeFactors: Int) -> Int {
        let n = primeFactors
        if n == 1 { return 0 }
        if n == 2 { return 1 }

        let primes = countPrimes(primeFactors+1)

        // only pick one factor, return n-1
        var nice = n-1
        for pick in 2...min(n, primes) {
            // reset
            var temp = 0
            check(n-pick, pick, 0, pick-1, 1, &temp)
            nice = max(nice, temp)
        }

        return nice
    }

    // max nice divisor when pick `pick` numbers
    func check(_ remain: Int, _ pick: Int,
               _ start: Int, _ end: Int,
               _ cur: Int, _ res: inout Int) {

        if remain == 0 {
            res = max(res, cur%mod)
            return
        }

        if start == end {
            res = max(res, (cur*(remain+1)) % mod)
            return
        }

        for i in stride(from: remain, through: remain/pick, by: -1) {
            // print("before", arr, i, cur, start)
            check(remain-i, pick, start+1, end, cur*(i+1), &res)
        }
    }

    // return prime list < n
    func countPrimes(_ n: Int) -> Int {
        var isPrime = Array(repeating: true, count: n)
        var i = 2

        while i * i < n {
            defer { i += 1}

            if !isPrime[i] { continue }
            var j = i*i
            while j < n {
                isPrime[j] = false
                j += i
            }
        }

        var res = 0
        for i in 2..<n {
            if isPrime[i] {
                res += 1
            }
        }
        return res
    }
}