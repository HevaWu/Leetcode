/*
Given a string s and a character c that occurs in s, return an array of integers answer where answer.length == s.length and answer[i] is the shortest distance from s[i] to the character c in s.

 

Example 1:

Input: s = "loveleetcode", c = "e"
Output: [3,2,1,0,1,0,0,1,2,2,1,0]
Example 2:

Input: s = "aaab", c = "b"
Output: [3,2,1,0]
 

Constraints:

1 <= s.length <= 104
s[i] and c are lowercase English letters.
c occurs at least once in s.
*/

/*
Solution 2
optimize solution 1
*/
class Solution {
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        // index array, where c appeared in s
        var arr = [Int]()
        
        var s = Array(s)
        let n = s.count
        for i in 0..<n where s[i] == c {
            arr.append(i)
        }
        
        var res = [Int]()
        var j = 0
        for i in 0..<n {
            if j < arr.count-1, abs(arr[j+1] - i) < abs(arr[j] - i) {
                j += 1
            }
            res.append(abs(arr[j] - i))
        }
        return res
    }
}

/*
Solution 1
array

store c index array into arr
iterative check char in s

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func shortestToChar(_ s: String, _ c: Character) -> [Int] {
        // index array, where c appeared in s
        var arr = [Int]()
        
        var s = Array(s)
        let n = s.count
        for i in 0..<n where s[i] == c {
            arr.append(i)
        }
        
        var res = [Int]()
        for i in 0..<n {
            if s[i] == c {
                res.append(0)
            } else {
                if arr[0] > i || arr.count == 1 {
                    res.append(abs(i-arr[0]))
                } else {
                    var temp = abs(i-arr[0])
                    for j in 1..<arr.count {
                        temp = min(temp, abs(i-arr[j]))
                    }
                    res.append(temp)
                }
            }
        }
        return res
    }
}