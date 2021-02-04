/*
Given a singly linked list, determine if it is a palindrome.

Example 1:

Input: 1->2
Output: false
Example 2:

Input: 1->2->2->1
Output: true
Follow up:
Could you do it in O(n) time and O(1) space?
*/

/*
Solution 1:
use slow, fast 2 node memo
1. make slow in the middle
  - fast go 2 step, slow go 1 step
2. reverse slow link
3. check if reversed on same as remain one

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func isPalindrome(_ head: ListNode?) -> Bool {
        // reverse list head
        var rev: ListNode? = nil
        
        var slow = head
        var fast = head
        while fast != nil, fast?.next != nil {
            fast = fast?.next?.next
            
            // reverse first half list
            let _next = slow?.next
            slow?.next = rev
            rev = slow
            slow = _next
        }
        
        if fast != nil {
            slow = slow?.next
        }
        // print(rev?.val, slow?.val)
        
        while rev != nil, rev?.val == slow?.val {
            slow = slow?.next
            rev = rev?.next
        }
        
        // print(rev?.val, slow?.val)
        return rev?.val == slow?.val
    }
}