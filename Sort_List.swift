/*
Given the head of a linked list, return the list after sorting it in ascending order.

Follow up: Can you sort the linked list in O(n logn) time and O(1) memory (i.e. constant space)?

 

Example 1:


Input: head = [4,2,1,3]
Output: [1,2,3,4]
Example 2:


Input: head = [-1,5,3,4,0]
Output: [-1,0,3,4,5]
Example 3:

Input: head = []
Output: []
 

Constraints:

The number of nodes in the list is in the range [0, 5 * 104].
-105 <= Node.val <= 105
*/

/*
Solution 2:
bottom up

Time Complexity: O(n logn)
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
    func sortList(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        if head?.next == nil { return head }
        
        // get list length
        var n = 0
        var cur = head
        while cur != nil {
            n += 1
            cur = cur?.next
        }
        
        var dummy = ListNode()
        dummy.next = head
        
        var left: ListNode? = ListNode()
        var right: ListNode? = ListNode()
        var tail: ListNode? = ListNode()
                
        var interval = 1
        while interval < n {
            cur = dummy.next
            tail = dummy
            
            while cur != nil {
                left = cur
                right = split(&left, interval)
                cur = split(&right, interval)
                tail = merge(left, right, tail)                
            }
            interval *= 2
        }
        
        return dummy.next
    }
    
    // divide linked list into 2 lists
    // return second list's head
    func split(_ head: inout ListNode?, _ n: Int) -> ListNode? {
        if head == nil { return nil }
        var cur = head
        var i = 1
        while i < n, cur != nil {
            cur = cur?.next
            i += 1
        }
        
        if cur == nil { return nil }
        let second = cur?.next
        cur?.next = nil
        return second
    }
    
    // merge 2 sorted linked list l1, l2
    // then append merged sorted linked list to head
    // return tail of the merged sorted linked list
    func merge(_ l1: ListNode?, _ l2: ListNode?, _ head: ListNode?) -> ListNode? {
        var cur = head
        
        var l1 = l1
        var l2 = l2
        
        while l1 != nil, l2 != nil {
            if l1!.val < l2!.val {
                cur?.next = l1
                l1 = l1?.next
            } else {
                cur?.next = l2
                l2 = l2?.next
            }
            cur = cur?.next
        }
        
        cur?.next = l1 != nil ? l1 : l2
        while cur?.next != nil {
            cur = cur?.next
        }
        
        return cur
    }
}

/*
Solution 1:
merge sort
top-down

Time Complexity: O(n logn)
Space Complexity: O(log n)
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
    func sortList(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        if head?.next == nil { return head }
        
        var head = head
        let mid = getMid(&head)
        
        let left = sortList(head)
        let right = sortList(mid)        
        return merge2List(left, right)
    }
    
    // inout to make sure update head's node
    func getMid(_ head: inout ListNode?) -> ListNode? {
        var preMid: ListNode? = nil
        var node = head
        while node != nil, node?.next != nil {
            preMid = preMid == nil ? node : preMid?.next
            node = node?.next?.next
        }
        
        let mid = preMid?.next
        preMid?.next = nil
        return mid
    }
    
    func merge2List(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        
        var head: ListNode?
        var another: ListNode? 
        
        if l1!.val < l2!.val {
            head = l1
            another = l2
        } else {
            head = l2
            another = l1
        }
        
        var cur = head
        while another != nil {
            if cur?.next == nil || another!.val < cur!.next!.val {
                let temp = cur?.next
                cur?.next = another
                another = temp
            }
            cur = cur?.next
        }
        return head
    }
}