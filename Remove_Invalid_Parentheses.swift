/*
Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible results.

Note: The input string may contain letters other than the parentheses ( and ).

Example 1:

Input: "()())()"
Output: ["()()()", "(())()"]
Example 2:

Input: "(a)())()"
Output: ["(a)()()", "(a())()"]
Example 3:

Input: ")("
Output: [""]
*/

/*
Solution 2:
limited backTrack

find number of misplaced ( and )
- We process the expression one bracket at a time starting from the left.
- Suppose we encounter an opening bracket i.e. (, it may or may not lead to an invalid expression because there can be a matching ending bracket somewhere in the remaining part of the expression. Here, we simply increment the counter keeping track of left parentheses till now. left += 1
- If we encounter a closing bracket, this has two meanings:
  - Either there was no matching opening bracket for this closing bracket and in that case we have an invalid expression. This is the case when left == 0 i.e. when there are no unmatched left brackets available. In such a case we increment another counter say right += 1 to represent misplaced right parentheses.
  - Or, we had some unmatched opening bracket available to match this closing bracket. This is the case when left > 0. In this case we simply decrement the left counter we had i.e. left -= 1
- Continue processing the string until all parentheses have been processed.
- In the end the values of left and right would tell us the number of unmatched ( and ) parentheses respectively.

Algorithm
- The state of the recursion is now defined by five different variables:
  - index which represents the current character that we have to process in the original string.
  - left_count which represents the number of left parentheses that have been added to the expression we are building.
  - right_count which represents the number of right parentheses that have been added to the expression we are building.
  - left_rem is the number of left parentheses that remain to be removed.
  - right_rem represents the number of right parentheses that remain to be removed. Overall, for the final expression to be valid, left_rem == 0 and right_rem == 0.
- When we decide to not consider a parenthesis i.e. delete a parenthesis, be it a left or a right parentheses, we have to consider their corresponding remaining counts as well. This means that we can only discard a left parentheses if left_rem > 0 and similarly for the right one we will check for right_rem > 0.
- There are no changes to checks for considering a parenthesis. Only the conditions change for discarding a parenthesis.
- Condition for an expression being valid in the base case would now become left_rem == 0 and right_rem == 0. Note that we don't have to check if left_count == right_count anymore because in the case of a valid expression, we would have removed all the misplaced or invalid parenthesis by the time the recursion ends. So, the only check we need if left_rem == 0 and right_rem == 0.

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func removeInvalidParentheses(_ s: String) -> [String] {
        if s.isEmpty { return [""] }
        
        var s = s
        
        var left = 0
        var right = 0
        
        for c in s {
            if c == "(" {
                left += 1
            } else if c == ")" {
                if left == 0 {
                    right += 1
                } else {
                    left -= 1
                }
            }
        }
        
        var cur = String()
        
        // use set to avoid duplicate
        var valid = Set<String>()
        backTrack(s, s.startIndex, 0, 0, left, right, &cur, &valid)        
        return Array(valid)
    }
    
    func backTrack(_ s: String, _ index: String.Index, 
                   _ leftCount: Int, _ rightCount: Int, 
                   _ misLeftRemain: Int, _ misRightRemain: Int,
                   _ cur: inout String, _ valid: inout Set<String>) {
        if index == s.endIndex {
            if misLeftRemain == 0, misRightRemain == 0 {
                valid.insert(cur)
            }
        } else {
            let c = s[index]
            let count = cur.count
            
            if (c == "(" && misLeftRemain > 0) 
            || (c == ")" && misRightRemain > 0) {
                backTrack(s, 
                          s.index(after: index), 
                          leftCount, 
                          rightCount, 
                          c == "(" ? misLeftRemain-1 : misLeftRemain,
                          c == ")" ? misRightRemain-1 : misRightRemain,
                          &cur, &valid)
            }
            cur.append(c)
            
            if c != "(", c != ")" {
                backTrack(s, 
                          s.index(after: index), 
                          leftCount, 
                          rightCount, 
                          misLeftRemain,
                          misRightRemain,
                          &cur, &valid)
            } else if c == "(" {
                backTrack(s, 
                          s.index(after: index), 
                          leftCount+1, 
                          rightCount, 
                          misLeftRemain,
                          misRightRemain,
                          &cur, &valid)
            } else if rightCount < leftCount {
                backTrack(s, 
                          s.index(after: index), 
                          leftCount, 
                          rightCount+1, 
                          misLeftRemain,
                          misRightRemain,
                          &cur, &valid)
            }
            
            cur.removeLast()
        }
    }
}

/*
Soluton 1:
bfs

use visited to check already checked string
use queue to memo next checking string list

use isFound to help terminate removing char from valid string

Time Complexity: O(2^n)
Spacee Complexity: O(n)
*/
class Solution {
    func removeInvalidParentheses(_ s: String) -> [String] {
        if s.isEmpty { return [""] }
        
        var s = s
        
        var visited: Set<String> = [s]
        var queue: [String] = [s]
        
        var isFound = false
        
        var res = [String]()
        while !queue.isEmpty {
            s = queue.removeFirst()
            
            if isValid(s) {
                res.append(s)
                isFound = true
            }
            
            if isFound {
                continue
            }
            
            for i in s.indices {
                if s[i] != "(", s[i] != ")" {
                    continue
                }
                
                var temp = s
                temp.remove(at: i)
                if !visited.contains(temp) {
                    visited.insert(temp)
                    queue.append(temp)
                }
            }
        }
        return res
    }
    
    func isValid(_ s: String) -> Bool {
        if s.isEmpty { return true }
        
        var count = 0
        for c in s {
            if c == "(" {
                count += 1
            } else if c == ")" {
                count -= 1
                if count < 0 {
                    return false 
                }
            }
        }
        return count == 0
    }
}
