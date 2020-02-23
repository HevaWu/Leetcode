// You're given strings J representing the types of stones that are jewels, and S representing the stones you have.  Each character in S is a type of stone you have.  You want to know how many of the stones you have are also jewels.

// The letters in J are guaranteed distinct, and all characters in J and S are letters. Letters are case sensitive, so "a" is considered a different type of stone from "A".

// Example 1:

// Input: J = "aA", S = "aAAbbbb"
// Output: 3
// Example 2:

// Input: J = "z", S = "ZZ"
// Output: 0
// Note:

// S and J will consist of letters and have length at most 50.
// The characters in J are distinct.

// Hint
// For each stone, check if it is a jewel.

// Solution 1: set 
// 
// Time Complexity: O(J\text{.length} + S\text{.length}))O(J.length+S.length)). The O(J\text{.length})O(J.length) part comes from creating J. The O(S\text{.length})O(S.length) part comes from searching S.
// Space Complexity: O(J\text{.length})O(J.length).
class Solution {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        guard !J.isEmpty, !S.isEmpty else { return 0 }
        var jewels = Set<Character>()
        for c in J {
            jewels.insert(c)
        }
        
        var count = 0
        for c in S {
            if jewels.contains(c) {
                count += 1
            }
        }
        return count
    }
}

// Solution 2: swift reduce
// Time complexity: O(S.length)
// Space complexity: O(1)
class Solution {
    func numJewelsInStones(_ J: String, _ S: String) -> Int {
        return S.reduce(0, { res, char -> Int in
            return res + (J.contains(char) ? 1 : 0)
        })
    }
}