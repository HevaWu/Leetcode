/*
Given an integer n, return the number of strings of length n that consist only of vowels (a, e, i, o, u) and are lexicographically sorted.

A string s is lexicographically sorted if for all valid i, s[i] is the same as or comes before s[i+1] in the alphabet.

 

Example 1:

Input: n = 1
Output: 5
Explanation: The 5 sorted strings that consist of vowels only are ["a","e","i","o","u"].
Example 2:

Input: n = 2
Output: 15
Explanation: The 15 sorted strings that consist of vowels only are
["aa","ae","ai","ao","au","ee","ei","eo","eu","ii","io","iu","oo","ou","uu"].
Note that "ea" is not a valid string since 'e' comes after 'a' in the alphabet.
Example 3:

Input: n = 33
Output: 66045
 

Constraints:

1 <= n <= 50 

Hint 1:
For each character, its possible values will depend on the value of its previous character, because it needs to be not smaller than it.

Hint 2:
Think backtracking. Build a recursive function count(n, last_character) that counts the number of valid strings of length n and whose first characters are not less than last_character.

Hint 3:
In this recursive function, iterate on the possible characters for the first character, which will be all the vowels not less than last_character, and for each possible value c, increase the answer by count(n-1, c).
*/

/*
Solution 4:
Math: Combination number
Now we have n characters, we are going to insert 4 l inside.
We can add in the front, in the middle and in the end.
How many ways do we have?
For the 1st l, we have n+1 position to insert.
For the 2nd l, we have n+2 position to insert.
For the 3rd l, we have n+3 position to insert.
For the 4th l, we have n+4 position to insert.
Also 4 l are the same,
there are (n + 1) * (n + 2) * (n + 3) * (n + 4) / 4! ways.

The character before the 1st l, we set to a.
The character before the 2nd l, we set to e.
The character before the 3rd l, we set to i.
The character before the 4th l, we set to o.
The character before the 5th l, we set to u.

We get the one result for the oringinal problem.

Time O(1)
Space O(1)
*/
class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        return (n+1) * (n+2) * (n+3) * (n+4) / 24
    }
}

/*
Solution 3:
1D DP

Time Complexity: O(5n)
Space Complexity: O(5)
*/
class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        // dp[n+1][6]
        var dp = [0, 1, 1, 1, 1, 1]
        
        for i in 1...n {
            for j in 1...5 {
                dp[j] += dp[j-1]
            }
        }
        
        return dp[5]
    }
}

/*
Solution 2:
DP

dp[i][j] = dp[i][j-1] + (i > 1 ? dp[i-1][j] : 1)
return dp[n][5]

Time Complexity: O(5n)
Space Complexity: O(5n)
*/
class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        // dp[n+1][6]
        var dp = Array(repeating: Array(repeating: 0, count: 6), 
                       count: n+1)
        
        for i in 1...n {
            for j in 1...5 {
                dp[i][j] = dp[i][j-1] + (i>1 ? dp[i-1][j] : 1)
            }
        }
        
        return dp[n][5]
    }
}

/*
Solution 1:
BackTrack

Time Complexity: O(5^n)
Space Complexity: O(1)
*/
class Solution {
    func countVowelStrings(_ n: Int) -> Int {
        var res = 0
        
        // append case of a,e,i,o,u is 5,4,3,2,1
        // vowel a, have 5 possible append cases, aeiou
        // vowel e, have 4 possible append cases, eiou
        // backTrack lastCharIndex...4 would be enough
        func _count(_ remain: Int, _ lastCharIndex: Int) {
            if remain == 0 {
                res += 1
                return 
            }
            
            for i in lastCharIndex...4 {
                _count(remain-1, i)
            }
        }
        
        _count(n, 0)
        return res
    }
}