// Given a positive integer n, return the number of all possible attendance records with length n, which will be regarded as rewardable. The answer may be very large, return it after mod 109 + 7.

// A student attendance record is a string that only contains the following three characters:

// 'A' : Absent.
// 'L' : Late.
// 'P' : Present.
// A record is regarded as rewardable if it doesn't contain more than one 'A' (absent) or more than two continuous 'L' (late).

// Example 1:
// Input: n = 2
// Output: 8 
// Explanation:
// There are 8 records with length 2 will be regarded as rewardable:
// "PP" , "AP", "PA", "LP", "PL", "AL", "LA", "LL"
// Only "AA" won't be regarded as rewardable owing to more than one absent times. 
// Note: The value of n won't exceed 100,000.

// Solution 1: Force
// In the brute force approach, we actually form every possible string comprising of the letters "A", "P", "L" and check if the string is rewardable by checking it against the given criterias. In order to form every possible string, we make use of a recursive gen(string, n) function. At every call of this function, we append the letters "A", "P" and "L" to the input string, reduce the required length by 1 and call the same function again for all the three newly generated strings.
// 
// Time complexity : O(3^n). Exploring 3^ncombinations.
// Space complexity : O(n^n). Recursion tree can grow upto depth nn and each node contains string of length O(n)O(n).

// Solution 2: recursive 
// Firstly, assume the problem to be considering only the characters LL and PP in the strings. i.e. The strings can contain only LL and PP. The effect of AA will be taken into account later on.
// In order to develop the relation, let's assume that f[n]f[n] represents the number of possible rewardable strings(with LL and PP as the only characters) of length nn. Then, we can easily determine the value of f[n]f[n] if we know the values of the counts for smaller values of nn. To see how it works, let's examine the figure below:
// The above figure depicts the division of the rewardable string of length nn into two strings of length n-1n−1 and ending with LL or PP. The string ending with PP of length nn is always rewardable provided the string of length n-1n−1 is rewardable. Thus, this string accounts for a factor of f[n-1]f[n−1] to f[n]f[n].
// For the first string ending with LL, the rewardability is dependent on the further strings of length n-3n−3. Thus, we consider all the rewardable strings of length n-3n−3 now. Out of the four combinations possible at the end, the fourth combination, ending with a LLLL at the end leads to an unawardable string. But, since we've considered only rewardable strings of length n-3n−3, for the last string to be rewardable at length n-3n−3 and unawardable at length n-1n−1, it must be preceded by a PP before the LLLL.
// Thus, accounting for the first string again, all the rewardable strings of length n-1n−1, except the strings of length n-4n−4 followed by PLLPLL, can contribute to a rewardable string of length nn. Thus, this string accounts for a factor of f[n-1] - f[n-4]f[n−1]−f[n−4] to f[n]f[n].
// 
// f[n]=2f[n−1]−f[n−4]
// We store all the f[i]f[i] values in an array. In order to compute f[i]f[i], we make use of a recursive function func(n) which makes use of the above recurrence relation.
// Now, we need to put the factor of character AA being present in the given string. We know, atmost one AA is allowed to be presnet in a rewardable string. Now, consider the two cases.
// No AA is present: In this case, the number of rewardable strings is the same as f[n]f[n].
// A single AA is present: Now, the single AA can be present at any of the nn positions. If the AA is present at the i^{th}position in the given string, in the form: "<(i-1) characters>, A, <(n-i) characters>", the total number of rewardable strings is given by: f[i-1] * f[n-i]f[i−1]∗f[n−i]. Thus, the total number of such substrings is given by: \sum_{i=1}^{n} (f[i-1] * f[n-i])
// 
// Time complexity : O(2^n). method funcfunc will take 2^ntime.
// Space complexity : O(n)O(n). ff array is used of size nn.
class Solution {
    let mod: Int = 1000000007
    func checkRecord(_ n: Int) -> Int {
        var f = Array(repeating: 0, count: n+1)
        f[0] = 1
        for i in 1...n {
            f[i] = checkFunc(i)
        }
        // plust A
        var record = f[n]
        for i in 1...n {
            record += (f[i-1]*f[n-i]) % mod
        }
        return record % mod
    }
    
    // only consider L & P
    func checkFunc(_ n: Int) -> Int {
        switch n {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 4
        case 3:
            return 7
        default:
            let r = (2*checkFunc(n-1) - checkFunc(n-4)) % mod
			return r >= 0 ? r : r+mod
        }
    }
}

// Solution 3: DP
// In the last approach, we calculated the values of f[i]f[i] everytime using the recursive function, which goes till its root depth everytime. But, we can reduce a large number of redundant calculations, if we use the results obtained for previous f[j]f[j] values directly to obtain f[i]f[i] as f[i] = 2f[i-1] + f[i-4]f[i]=2f[i−1]+f[i−4].
// 
// Time complexity : O(n)O(n). One loop to fill ff array and one to calculate sumsum
// Space complexity : O(n)O(n). ff array of size nn is used.
class Solution {
    let mod: Int = 1000000007
    func checkRecord(_ n: Int) -> Int {
        var f = Array(repeating: 0, count: n<=5 ? 6 : n+1)
        f[0] = 1
        f[1] = 2
        f[2] = 4
        f[3] = 7
        for i in 4..<f.count {
            let r = (2*f[i-1] - f[i-4]) % mod
            f[i] = r >= 0 ? r : mod+r
        }
        
        var record = f[n]
        for i in 1...n {
            record += (f[i-1]*f[n-i]) % mod
        }
        return record % mod
    }
}

// Solution 4: DP with constant space
// we keep a track of the number of unique transitions from which a rewardable state can be achieved. We start off with a string of length 0 and keep on adding a new character to the end of the string till we achieve a length of nn. At the end, we sum up the number of transitions possible to reach each rewardable state to obtain the required result.
// We can use variables corresponding to the states. axlyaxly represents the number of strings of length ii containing xx a's and ending with yy l's.
// 
// Time complexity : O(n)O(n). Single loop to update the states.
// Space complexity : O(1)O(1). Constant Extra Space is used.
class Solution {
    func checkRecord(_ n: Int) -> Int {
        let mod: Int = 1000000007
        var a0l0 = 1
        var a0l1 = 0
        var a0l2 = 0
        var a1l0 = 0
        var a1l1 = 0
        var a1l2 = 0
        for i in 0..<n {
            let temp_a0l0 = (a0l0 + a0l1 + a0l2) % mod
            let temp_a0l1 = a0l0
            let temp_a0l2 = a0l1
            let temp_a1l0 = (a1l0 + a1l1 + a1l2 + a0l0 + a0l1 + a0l2) % mod
            let temp_a1l1 = a1l0
            let temp_a1l2 = a1l1
            a0l0 = temp_a0l0
            a0l1 = temp_a0l1
            a0l2 = temp_a0l2
            a1l0 = temp_a1l0
            a1l1 = temp_a1l1
            a1l2 = temp_a1l2
        }
        return (a0l0 + a0l1 + a0l2 + a1l0 + a1l1 + a1l2) % mod
    }
}