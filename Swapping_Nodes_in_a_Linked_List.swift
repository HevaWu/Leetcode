/*
You are given the head of a linked list, and an integer k.

Return the head of the linked list after swapping the values of the kth node from the beginning and the kth node from the end (the list is 1-indexed).

 

Example 1:


Input: head = [1,2,3,4,5], k = 2
Output: [1,4,3,2,5]
Example 2:

Input: head = [7,9,6,6,7,8,3,0,9,5], k = 5
Output: [7,9,6,6,8,7,3,0,9,5]
Example 3:

Input: head = [1], k = 1
Output: [1]
Example 4:

Input: head = [1,2], k = 1
Output: [2,1]
Example 5:

Input: head = [1,2,3], k = 2
Output: [1,2,3]
 

Constraints:

The number of nodes in the list is n.
1 <= k <= n <= 105
0 <= Node.val <= 100
*/

/*
Solution 2:
optimize solution 1

only switch node.val would be enough, don't care link logic

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
    func swapNodes(_ head: ListNode?, _ k: Int) -> ListNode? {
        // kth node
        var first = head
        for i in 0..<(k-1) {
            first = first?.next
        }
        
        // n-k th node
        var second = head
        var end = first
        while end?.next != nil {
            second = second?.next
            end = end?.next
        }
        
        if first === second { return head }
        
        let temp = second!.val
        second!.val = first!.val
        first!.val = temp
        
        return head
    }
}

/*
Solution 1:
iterate list

check list linked all logic

- k==1
  - secondPre === first
  - else
- k==n
  - firstPre === second
  - else
- 1< k < n
  - firstPre === second
  - secondPre === first
  - else

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
    func swapNodes(_ head: ListNode?, _ k: Int) -> ListNode? {
        // kth node
        var firstPre: ListNode? = nil
        var first = head
        for i in 0..<(k-1) {
            firstPre = first
            first = first?.next
        }
        
        // n-k th node
        var secondPre: ListNode? = nil
        var second = head
        var end = first
        while end?.next != nil {
            secondPre = second
            second = second?.next
            end = end?.next
        }
        
        // print(firstPre?.val, first?.val, secondPre?.val, second?.val)
        
        if first === second { return head }
        
        // swap
        if firstPre == nil {
            // k == 1
            
            if secondPre === first {
                first?.next = nil
                second?.next = first
                return second
            }
            
            second?.next = first?.next
            
            secondPre?.next = first
            first?.next = nil
            
            return second
        } else if secondPre == nil {
            // k == n
            
            if firstPre === second {
                second?.next = nil
                first?.next = second
                return first
            }
            
            first?.next = second?.next
            
            firstPre?.next = second
            second?.next = nil
            
            return first
        } else if secondPre === first {
            let secondNext = second?.next
            
            firstPre?.next = second
            
            second?.next = first
            first?.next = secondNext
        } else if firstPre === second {
            let firstNext = first?.next
            
            secondPre?.next = first
            
            first?.next = second
            second?.next = firstNext
        } else {
            // 1 < k < n
            let secondNext = second?.next
            
            firstPre?.next = second
            second?.next = first?.next
            
            secondPre?.next = first
            first?.next = secondNext
        }
        return head
    }
}