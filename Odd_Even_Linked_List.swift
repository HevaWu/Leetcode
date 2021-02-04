/*
Given a singly linked list, group all odd nodes together followed by the even nodes. Please note here we are talking about the node number and not the value in the nodes.

You should try to do it in place. The program should run in O(1) space complexity and O(nodes) time complexity.

Example 1:

Input: 1->2->3->4->5->NULL
Output: 1->3->5->2->4->NULL
Example 2:

Input: 2->1->3->5->6->4->7->NULL
Output: 2->3->6->7->1->5->4->NULL
 

Constraints:

The relative order inside both the even and odd groups should remain as it was in the input.
The first node is considered odd, the second node even and so on ...
The length of the linked list is between [0, 10^4].
*/

/*
Solution 2
Optimize solution 1

at the end set
odd.next = even
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
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        
        // current odd node
        var odd: ListNode? = head
        
        // head of even node
        var even: ListNode? = head.next
        
        // current checking even node
        var _even: ListNode? = even
        
        while _even != nil, _even?.next != nil {
            odd?.next = _even?.next
            odd = odd?.next
            _even?.next = odd?.next
            _even = _even?.next
        }
        
        odd?.next = even
        return head
    }
}

/*
Solution 1
iterative
hold 3 node
- odd: current checking odd node
- even: even node list top
- _even: current checking even node

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
    func oddEvenList(_ head: ListNode?) -> ListNode? {
        guard let head = head else { return nil }
        
        // current odd node
        var odd: ListNode? = head
        
        // head of even node
        var even: ListNode? = head.next
        
        // current checking even node
        var _even: ListNode? = even
        
        while _even != nil {
            let _odd = _even?.next
            // need to add this checking
            // otherwise we might missing whole even list, ex: [1,2,3,4]
            if _odd == nil { break }
            
            _even?.next = _odd?.next
            _even = _even?.next
            
            _odd?.next = even
            odd?.next = _odd
            odd = odd?.next
        }
        return head
    }
}