/*
Given a string S, we can transform every letter individually to be lowercase or uppercase to create another string.

Return a list of all possible strings we could create. You can return the output in any order.

 

Example 1:

Input: S = "a1b2"
Output: ["a1b2","a1B2","A1b2","A1B2"]
Example 2:

Input: S = "3z4"
Output: ["3z4","3Z4"]
Example 3:

Input: S = "12345"
Output: ["12345"]
Example 4:

Input: S = "0"
Output: ["0"]
 

Constraints:

S will be a string with length between 1 and 12.
S will consist only of letters or digits.
*/

/*
Solution 1
recursive

Time Complexity: O(2^n)
Space Complexity: O(1)
*/
class Solution {
    func letterCasePermutation(_ S: String) -> [String] {
        var res = [String]()
        var S = Array(S)
        let n = S.count
        _permutation(&S, 0, n, &res)
        return res
    }
    
    func _permutation(_ str: inout [Character], 
                      _ index: Int, 
                      _ n: Int, 
                      _ res: inout [String]) {
        if index == n {
            res.append(String(str))
            return
        }
        
        if str[index].isNumber {
            _permutation(&str, index+1, n, &res)
        } else {
            str[index] = str[index].lowercased().first!
            _permutation(&str, index+1, n, &res)
            str[index] = str[index].uppercased().first!
            _permutation(&str, index+1, n, &res)
        }
    }
} 
