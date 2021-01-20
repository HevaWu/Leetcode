/*
Given a list of sorted characters letters containing only lowercase letters, and given a target letter target, find the smallest element in the list that is larger than the given target.

Letters also wrap around. For example, if the target is target = 'z' and letters = ['a', 'b'], the answer is 'a'.

Examples:
Input:
letters = ["c", "f", "j"]
target = "a"
Output: "c"

Input:
letters = ["c", "f", "j"]
target = "c"
Output: "f"

Input:
letters = ["c", "f", "j"]
target = "d"
Output: "f"

Input:
letters = ["c", "f", "j"]
target = "g"
Output: "j"

Input:
letters = ["c", "f", "j"]
target = "j"
Output: "c"

Input:
letters = ["c", "f", "j"]
target = "k"
Output: "c"
Note:
letters has a length in range [2, 10000].
letters consists of lowercase letters, and contains at least 2 unique letters.
target is a lowercase letter.

Hint 1: 
Try to find whether each of 26 next letters are in the given string array.
*/

/*
Solution 1:
Binary Search

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        if target < letters[0] || target >= letters.last! {
            return letters[0]
        }
        
        var left = 0
        var right = letters.count-1
        while left < right {
            let mid = left + (right-left)/2
            if letters[mid] > target {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return letters[left]
    }
}