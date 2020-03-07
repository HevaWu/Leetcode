
// You have a keyboard layout as shown above in the XY plane, where each English uppercase letter is located at some coordinate, for example, the letter A is located at coordinate (0,0), the letter B is located at coordinate (0,1), the letter P is located at coordinate (2,3) and the letter Z is located at coordinate (4,1).

// Given the string word, return the minimum total distance to type such string using only two fingers. The distance between coordinates (x1,y1) and (x2,y2) is |x1 - x2| + |y1 - y2|. 

// Note that the initial positions of your two fingers are considered free so don't count towards your total distance, also your two fingers do not have to start at the first letter or the first two letters.

 

// Example 1:

// Input: word = "CAKE"
// Output: 3
// Explanation: 
// Using two fingers, one optimal way to type "CAKE" is: 
// Finger 1 on letter 'C' -> cost = 0 
// Finger 1 on letter 'A' -> cost = Distance from letter 'C' to letter 'A' = 2 
// Finger 2 on letter 'K' -> cost = 0 
// Finger 2 on letter 'E' -> cost = Distance from letter 'K' to letter 'E' = 1 
// Total distance = 3
// Example 2:

// Input: word = "HAPPY"
// Output: 6
// Explanation: 
// Using two fingers, one optimal way to type "HAPPY" is:
// Finger 1 on letter 'H' -> cost = 0
// Finger 1 on letter 'A' -> cost = Distance from letter 'H' to letter 'A' = 2
// Finger 2 on letter 'P' -> cost = 0
// Finger 2 on letter 'P' -> cost = Distance from letter 'P' to letter 'P' = 0
// Finger 1 on letter 'Y' -> cost = Distance from letter 'A' to letter 'Y' = 4
// Total distance = 6
// Example 3:

// Input: word = "NEW"
// Output: 3
// Example 4:

// Input: word = "YEAR"
// Output: 7
 

// Constraints:

// 2 <= word.length <= 300
// Each word[i] is an English uppercase letter.

// Solution 1: 3D DP
// Initial the position of two fingers as (0,0).
// Iterate the input sttring and track the position of two fingers after tap the last character.
// dp[a,b] means with one finger at a and the other at postion b,
// the minimum distance we need is dp[a, b].
// d(a, b) return the distance moving from a to b. Also if a = 0 we return 0.
class Solution {    
    func minimumDistance(_ word: String) -> Int {
        // key is [finger1, finger2]
        var dp: [[Int]: Int] = [[0, 0]: 0]
        var temp = [[Int]: Int]() // use to update dp later
        for char in word {
            let c = Int(char.asciiValue!+1)
            for pair in dp.keys {
                let a = pair[0]
                let b = pair[1]
                // first finger
                temp[[c, b]] = min(temp[[c, b], default: 3000], dp[pair]! + getDis(from: a, to: c))
                // second finger
                temp[[a, c]] = min(temp[[a, c], default: 3000], dp[pair]! + getDis(from: b, to: c))
            }
            dp = temp
            temp = [[Int]: Int]()
        }
        return dp.values.min() ?? 0
    }
    
    func getDis(from: Int, to: Int) -> Int {
        return from == 0 ? 0 : abs(from/6 - to/6) + abs(from%6 - to%6)
    }
}

// Solution 2: 2D DP
// 3 dimensions is absolutely super easy to understand.
// Though for me is not easy to write (hate to brackets).
// 2 dimension dynamic programming is a good optimisation and not hard to come up with.
// By 2 dimension, I mean to recorde the positions of both fingers.
// But either 2D or 3D, We actually don't really need at all.
// We only need to record the position of the left finger.
// One important observation is that,
// out right finger will always stay at A[i - 1] after the last move.
// This is key idea that I want to express in this solution.
// 
// Imagine that we tap all letters with only one finger.
// The res distance we get is the maximum distance we will need.
// In our dynamic programming, dp[a] means that,
// if our left finger ends at character a,
// the maximum we can save is dp[a].
// Now our right finger tapped all letters, and left finger did nothing.
// We iterate through the whole string one by one
// and select some letter to tap with the left finger.
// By doing this, we want to find out the maximum distance that we can save from the tapping with one finger.
// Assume that our left finger is at a now,
// our right finger is at b,
// and we the right finger will tap c next.
// Instead of moving right finger from b to c with distance d(b, c),
// we try moving left finger from a to c with distance d(a, c).
// Hopely this will save d(b, c) - d(a, c).
// And finaly, we have one fingers at b and the other at c now.
// The finger at b will be new left finger, and the other will be the rihgt.
// 
// Time complexity: O(26*n)
// Space complexity: O(1)
class Solution {
    let asciiA = Character("A").asciiValue!
    func minimumDistance(_ word: String) -> Int {
        // record for first finger
        var dp = Array(repeating: 0, count: 26)
        var sumDis = 0
        var maxDis = 0
        
        var word = Array(word)
        for i in 0..<word.count-1 {
            let b = Int(word[i].asciiValue! - asciiA)
            let c = Int(word[i+1].asciiValue! - asciiA)
            for a in 0..<26 {
                // dp[b] directly use first finger
                // getDis(from: b, to: c)+ dp[a] - getDis(from: a, to: c) -> use second finger
                // -> need to minus the precounted dp[a] one
                dp[b] = max(dp[b], getDis(from: b, to: c) + dp[a] - getDis(from: a, to: c))
            }
            maxDis = max(maxDis, dp[b])
            sumDis += getDis(from: b, to: c)
        }
        return sumDis - maxDis
    }
    
    func getDis(from: Int, to: Int) -> Int {
        return abs(from/6 - to/6) + abs(from%6 - to%6)
    }
}