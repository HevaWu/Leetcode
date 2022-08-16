/*
Given a string, find the first non-repeating character in it and return its index. If it doesn't exist, return -1.

Examples:

s = "leetcode"
return 0.

s = "loveleetcode"
return 2.


Note: You may assume the string contains only lowercase English letters.
*/

/*
Solution 2:
use char array
- appear[i] means char i's appearance indices

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func firstUniqChar(_ s: String) -> Int {
        let n = s.count
        // appear[i] means char i's appearance indicies
        var appear = Array(repeating: [Int](), count: 26)

        let asciia = Character("a").asciiValue!
        var s = Array(s)
        for i in 0..<n {
            let index = Int(s[i].asciiValue! - asciia)
            appear[index].append(i)
        }

        // the first unique char's index
        var unique = n

        for i in 0..<26 {
            if appear[i].count == 1 {
                unique = min(unique, appear[i][0])
            }
        }

        return unique == n ? -1 : unique
    }
}

/*
Solution 1:
map

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var s = Array(s)

        // key is char
        // value is array of appeared index
        var map = [Character: [Int]]()
        for i in s.indices {
            if var val = map[s[i]] {
                val[1] += 1
                map[s[i]] = val
            } else {
                map[s[i]] = [i, 1]
            }
        }

        var res = Int.max
        for k in map.keys {
            if map[k]![1] == 1, map[k]![0] < res {
                res = map[k]![0]
            }
        }
        return res == Int.max ? -1 : res
    }
}