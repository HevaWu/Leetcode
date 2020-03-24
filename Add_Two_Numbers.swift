// You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

// You may assume the two numbers do not contain any leading zero, except the number 0 itself.

// Example:

// Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
// Output: 7 -> 0 -> 8
// Explanation: 342 + 465 = 807.

// Solution:
// use temp to help recording the sum result, if temp > 0, next one should add 1
//
// Time Complexity: O(max(M,N)), go through 2 list
// Space Complexity: O(max(M,N)) most largest length would be max + 1
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        var head = ListNode(0)
        var node = head

        var temp = 0
        var l1 = l1
        var l2 = l2
        while l1 != nil, l2 != nil {
            node.next = ListNode((temp + l1!.val + l2!.val)  % 10)
            temp = (temp + l1!.val + l2!.val)  / 10
            node = node.next!
            l1 = l1!.next
            l2 = l2!.next
        }

        if l1 == nil {
            while l2 != nil {
                node.next = ListNode((temp + l2!.val) % 10)
                temp = (temp + l2!.val ?? 0) / 10
                node = node.next!
                l2 = l2!.next
            }
        }

        if l2 == nil {
            while l1 != nil {
                node.next = ListNode((temp + l1!.val) % 10)
                temp = (temp + l1!.val) / 10
                node = node.next!
                l1 = l1!.next
            }
        }

        if temp > 0 {
            node.next = ListNode(temp)
        }

        return head.next
    }
}

// Optimize Solution 1
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {

        var head = ListNode(0)
        var node = head

        var temp = 0
        var l1 = l1
        var l2 = l2

        while l1 != nil || l2 != nil {
            let x1 = (l1 == nil ? 0 : l1!.val)
            let x2 = (l2 == nil ? 0 : l2!.val)
            node.next = ListNode((temp + x1 + x2) % 10)
            temp = (temp + x1 + x2) / 10
            node = node.next!

            if l1 != nil { l1 = l1!.next}
            if l2 != nil { l2 = l2!.next}
        }

        if temp > 0 {
            node.next = ListNode(temp)
        }

        return head.next
    }
}

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head = ListNode(0)
        
        var l1 = l1
        var l2 = l2
        var temp = 0
        var node = head
        while l1 != nil || l2 != nil {
            temp = (l1?.val ?? 0) + (l2?.val ?? 0) + temp
            node.next = ListNode(temp%10)
            temp = temp/10
            
            if l1 != nil { l1 = l1!.next }
            if l2 != nil { l2 = l2!.next }
            node = node.next!
        }
        
        if temp != 0 { 
            node.next = ListNode(temp)
        }
        
        return head.next
    }
}