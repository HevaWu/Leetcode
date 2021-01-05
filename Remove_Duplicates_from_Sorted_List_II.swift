/*
Given the head of a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list. Return the linked list sorted as well.

 

Example 1:


Input: head = [1,2,3,3,4,4,5]
Output: [1,2,5]
Example 2:


Input: head = [1,1,1,2,3]
Output: [2,3]
 

Constraints:

The number of nodes in the list is in the range [0, 300].
-100 <= Node.val <= 100
The list is guaranteed to be sorted in ascending order.
*/

/*
Solution 2:
recursive
improve solution 1 by not using additional temp
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
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard var node = head else { return nil }
        var _next: ListNode? = node.next
        if _next != nil {
            if node.val == _next?.val {
                // remove current node, and find next not duplicate node
                while node.val == _next?.val {
                    _next = _next?.next
                }
                return deleteDuplicates(_next)
            } else {
                node.next = deleteDuplicates(node.next)
                return node
            }
        } else {
            return node
        }
    }
}

/*
Solution 1:
recursively go through node.next
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
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
		// memo existing duplicate node.val
        var temp: Int? = nil
        
        func _deleteDuplicate(_ node: ListNode?) -> ListNode? {
            guard let node = node else { return nil }
            if node.val == temp {
                return _deleteDuplicate(node.next)
            } else if let _next = node.next, node.val == _next.val {
                temp = node.val
                return _deleteDuplicate(_next.next)
            } else {
                node.next = _deleteDuplicate(node.next)
                return node
            }
        }
        
        return _deleteDuplicate(head)
    }
}