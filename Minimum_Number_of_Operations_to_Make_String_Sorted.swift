/*
You are given a string s (0-indexed)​​​​​​. You are asked to perform the following operation on s​​​​​​ until you get a sorted string:

Find the largest index i such that 1 <= i < s.length and s[i] < s[i - 1].
Find the largest index j such that i <= j < s.length and s[k] < s[i - 1] for all the possible values of k in the range [i, j] inclusive.
Swap the two characters at indices i - 1​​​​ and j​​​​​.
Reverse the suffix starting at index i​​​​​​.
Return the number of operations needed to make the string sorted. Since the answer can be too large, return it modulo 109 + 7.



Example 1:

Input: s = "cba"
Output: 5
Explanation: The simulation goes as follows:
Operation 1: i=2, j=2. Swap s[1] and s[2] to get s="cab", then reverse the suffix starting at 2. Now, s="cab".
Operation 2: i=1, j=2. Swap s[0] and s[2] to get s="bac", then reverse the suffix starting at 1. Now, s="bca".
Operation 3: i=2, j=2. Swap s[1] and s[2] to get s="bac", then reverse the suffix starting at 2. Now, s="bac".
Operation 4: i=1, j=1. Swap s[0] and s[1] to get s="abc", then reverse the suffix starting at 1. Now, s="acb".
Operation 5: i=2, j=2. Swap s[1] and s[2] to get s="abc", then reverse the suffix starting at 2. Now, s="abc".
Example 2:

Input: s = "aabaa"
Output: 2
Explanation: The simulation goes as follows:
Operation 1: i=3, j=4. Swap s[2] and s[4] to get s="aaaab", then reverse the substring starting at 3. Now, s="aaaba".
Operation 2: i=4, j=4. Swap s[3] and s[4] to get s="aaaab", then reverse the substring starting at 4. Now, s="aaaab".
Example 3:

Input: s = "cdbea"
Output: 63
Example 4:

Input: s = "leetcodeleetcodeleetcode"
Output: 982157772


Constraints:

1 <= s.length <= 3000
s​​​​​​ consists only of lowercase English letters.
*/

/*
Solution 2:
math

Let us look at string cabbcdba for simplicity. We need to find how many string there is before this string in lexicographcal order.
- Strings, start with a or b should be OK for sure, so what we need to do is to find how many symbols less than c we have. Total number of strings is 2 * 7!, because we have two options for the first place and others we can put whatever we want. Also, we have b 3, a 2 times and c 2 times. So, we need to divide total number of options by 2! * 3! * 3!. Google multinomial coefficients for more details. So, total number of options here is 2 * 7!/2!/2!/3!.
- Now look at strings starts with c. There is not symbols, less than a, so here answer is 0.
- Now look at strings starts with ca, next symbols should be a and we have only one options here. So, total number of options is 1 * 5!/3!, because we have b 3 times among the rest symbols we did not used yet.
- And so on

To achieve good complexity we will use the fact that our string consist only 26 letters. Also we start our process from the end: in this way it will be possible to keep cnt array of frequencies and update it and calculate sum(cnt[:ind]): number of elements smaller than given one. Also, we need to work with 10^9 + 7 module, which is hopefully prime, so we can use Fermat little theorem to make fast divisions given this module. To divide number by q is the same as multiply it by q^(N-2) % N.

Time Complexity: O(26n)
If we have n the length of string s and m is the size of alphabet, we have complexity O(nm). There is also part where we canculate pow, but it is done in logarithmic time and at most 26 times at each iteration, so it will be smaller than the first term. Also f(i) will be called with parameters less than n, so no more than n times and we use memoisation.

Space Complexity: O(3000)
*/
class Solution {
    func makeStringSorted(_ s: String) -> Int {
        if s.count == 1 { return 0 }
        let mod = Int(1e9 + 7)
        let n = s.count
        var s = Array(s)

        var res = 0
        let ascii_a = Character("a").asciiValue!
        var count = Array(repeating: 0, count: 26)

        var cache = [Int: Int]()
        cache[0] = 1
        cache[1] = 1

        for i in stride(from: n-1, through: 0, by: -1) {
            let index = Int(s[i].asciiValue! - ascii_a)
            count[index] += 1

            var preSum = 0
            for j in 0..<index {
                preSum += count[j]
            }
            var temp = preSum * f(n-i-1, &cache, mod)

            for j in 0..<26 {
                temp = temp * helpPow(f(count[j], &cache, mod), mod-2, mod) % mod
            }
            res += temp
        }

        return res % mod
    }

    func f(_ i: Int, _ cache: inout [Int: Int], _ mod: Int) -> Int {
        if let val = cache[i] { return val }
        cache[i] = f(i-1, &cache, mod) * i % mod
        return cache[i]!
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
Time Limit Exceeded

from beginning, calculate how many operations it takes to put later smallest char
into proper place
*/
class Solution {
    func makeStringSorted(_ s: String) -> Int {
        if s.count == 1 { return 1 }
        let mod = Int(1e9 + 7)

        var s = Array(s)
        let n = s.count
        var map = [Character: Int]()
        for c in s {
            map[c, default: 0] += 1
        }

        var sortedKey = map.keys.sorted(by: >)
        var res = 0
        for i in 0..<n {
            if s[i] != sortedKey.last! {
                res = (res + moveAndCountOperation(&s, i, n, sortedKey.last!)) % mod
            }

            map[s[i]]! -= 1
            if map[s[i]]! == 0 {
                sortedKey.removeLast()
            }
        }
        return res < 0 ? res + mod : res
    }

    func moveAndCountOperation(_ s: inout [Character], _ index: Int, _ n: Int, _ targetChar: Character) -> Int {
        var res = 0
        while s[index] != targetChar {
            var i = n-1
            while i > index {
                if s[i] < s[i-1] { break }
                i -= 1
            }

            var j = i
            while j < n, s[j] < s[i-1] {
                j += 1
            }

            // should swap i-1, j-1
            s.swapAt(i-1, j-1)
            s[i...].reverse()

            res += 1
        }
        return res
    }
}