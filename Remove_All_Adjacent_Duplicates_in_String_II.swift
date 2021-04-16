/*
Given a string s, a k duplicate removal consists of choosing k adjacent and equal letters from s and removing them causing the left and the right side of the deleted substring to concatenate together.

We repeatedly make k duplicate removals on s until we no longer can.

Return the final string after all such duplicate removals have been made.

It is guaranteed that the answer is unique.



Example 1:

Input: s = "abcd", k = 2
Output: "abcd"
Explanation: There's nothing to delete.
Example 2:

Input: s = "deeedbbcccbdaa", k = 3
Output: "aa"
Explanation:
First delete "eee" and "ccc", get "ddbbbdaa"
Then delete "bbb", get "dddaa"
Finally delete "ddd", get "aa"
Example 3:

Input: s = "pbbcggttciiippooaais", k = 2
Output: "ps"


Constraints:

1 <= s.length <= 10^5
2 <= k <= 10^4
s only contains lower case English letters.
*/

/*
Solution 2:
shorten code by using stack only

But it cost longer time than Solution 1, because we add redundant push into stack operation

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func removeDuplicates(_ s: String, _ k: Int) -> String {
        if s.count == 1 { return s }
        var stack = [(char: Character, count: Int)]()
        for c in s {
            if !stack.isEmpty, stack.last!.char == c {
                stack[stack.count-1].count = stack.last!.count + 1
                if stack.last!.count == k {
                    stack.removeLast()
                }
            } else {
                stack.append((c, 1))
            }
        }

        if stack.isEmpty { return "" }

        var res = String()
        for (char, count) in stack {
            res.append(String(repeating: char, count: count))
        }
        return res
    }
}

/*
Solution 1:
stack

keep (char, count) in stack

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func removeDuplicates(_ s: String, _ k: Int) -> String {
        if s.count == 1 { return s }
        var stack = [(char: Character, count: Int)]()

        let dummyChar: Character = Character("#")
        var pre: Character = dummyChar
        var count = 0
        for c in s {
            // print(pre, count, c)
            if c == pre {
                count += 1
                continue
            }

            if pre == dummyChar {
                pre = c
                count = 1
                continue
            }

            count = count % k
            if count == 0 {
                pre = c
                count = 1

                if !stack.isEmpty, stack.last!.char == c {
                    count += stack.removeLast().count
                    if count == k {
                        count = 0
                    }
                }
            } else {
                stack.append((pre, count))
                pre = c
                count = 1
            }
            // print(stack)
        }

        // add final char if it < k
        if count < k {
            stack.append((pre, count))
        }

        if stack.isEmpty { return "" }

        var res = String()
        for (char, count) in stack {
            res.append(String(repeating: char, count: count))
        }
        return res
    }
}
