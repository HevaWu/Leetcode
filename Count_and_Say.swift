/*
The count-and-say sequence is a sequence of digit strings defined by the recursive formula:

countAndSay(1) = "1"
countAndSay(n) is the way you would "say" the digit string from countAndSay(n-1), which is then converted into a different digit string.
To determine how you "say" a digit string, split it into the minimal number of groups so that each group is a contiguous section all of the same character. Then for each group, say the number of characters, then say the character. To convert the saying into a digit string, replace the counts with a number and concatenate every saying.

For example, the saying and conversion for digit string "3322251":


Given a positive integer n, return the nth term of the count-and-say sequence.

 

Example 1:

Input: n = 1
Output: "1"
Explanation: This is the base case.
Example 2:

Input: n = 4
Output: "1211"
Explanation:
countAndSay(1) = "1"
countAndSay(2) = say "1" = one 1 = "11"
countAndSay(3) = say "11" = two 1's = "21"
countAndSay(4) = say "21" = one 2 + one 1 = "12" + "11" = "1211"
 

Constraints:

1 <= n <= 30
*/

/*
Solution 2
regex
*/
class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 { return "1" }
        let pre = countAndSay(n-1)
        // print(pre)
        
        var regex = try! NSRegularExpression(pattern: "(.)\\1*")
        let matches = regex.matches(in: pre, range: NSRange(location: 0, length: pre.utf16.count))
        var res = String()
        for m in matches {
            let finded = String(pre[Range(m.range, in: pre)!])
            res.append("\(finded.count)\(finded.first!)")
        }
        
        return res
    }
}

/*
Solution 1
generate from n-1 string

Time Complexity: O(2^n)
Space Complexity: O(2^(n-1))
*/
class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 1 { return "1" }
        let pre = countAndSay(n-1)
        // print(pre)
        
        var res = String()
        
        // start from 0
        var count = 0
        
        var num: Character = pre.first!
        for i in pre.indices {
            if pre[i] != num {
                res.append(String(count))
                res.append(num)
                
                num = pre[i]
                count = 1
            } else {
                count += 1
            }
        }
        
        res.append(String(count))
        res.append(num)
        
        return res
    }
}