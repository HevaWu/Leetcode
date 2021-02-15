/*
Count the number of prime numbers less than a non-negative number, n.

 

Example 1:

Input: n = 10
Output: 4
Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.
Example 2:

Input: n = 0
Output: 0
Example 3:

Input: n = 1
Output: 0
 

Constraints:

0 <= n <= 5 * 106
*/

/*
Solution 1
use isPrime to check if this number is prime
Sieve of Eratosthenes  algorithm

- start off with a table of n numbers. Let's look at the first number, 2. We know all multiples of 2 must not be primes, so we mark them off as non-primes. Then we look at the next number, 3. Similarly, all multiples of 3 such as 3 × 2 = 6, 3 × 3 = 9, ... must not be primes, so we mark them off as well. Now we look at the next number, 4, which was already marked off.
- 4 is not a prime because it is divisible by 2, which means all multiples of 4 must also be divisible by 2 and were already marked off. So we can skip 4 immediately and go to the next number, 5. Now, all multiples of 5 such as 5 × 2 = 10, 5 × 3 = 15, 5 × 4 = 20, 5 × 5 = 25, ... can be marked off. There is a slight optimization here, we do not need to start from 5 × 2 = 10.
- In fact, we can mark off multiples of 5 starting at 5 × 5 = 25, because 5 × 2 = 10 was already marked off by multiple of 2, similarly 5 × 3 = 15 was already marked off by multiple of 3. Therefore, if the current number is p, we can always mark off multiples of p starting at p2, then in increments of p: p2 + p, p2 + 2p, ...
- the terminating loop condition can be p < √n, as all non-primes ≥ √n must have already been marked off. When the loop terminates, all the numbers in the table that are non-marked are prime.

Time Complexity: O(n log log n)
Space Complexity: O(n)
*/
class Solution {
    func countPrimes(_ n: Int) -> Int {
        guard n > 2 else { return 0 }
        var isPrime = Array(repeating: true, count: n)
        
        var i = 2
        while i*i < n {
            defer { i += 1 }
            
            if !isPrime[i] { 
                continue 
            }
            
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