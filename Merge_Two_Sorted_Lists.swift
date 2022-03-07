/*
Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Example:

Input: 1->2->4, 1->3->4
Output: 1->1->2->3->4->4
*/

/*
Solution 1: iterate
Time complexity : O(n + m)O(n+m)
Because exactly one of l1 and l2 is incremented on each loop iteration, the while loop runs for a number of iterations equal to the sum of the lengths of the two lists. All other work is constant, so the overall complexity is linear.
Space complexity : O(1)O(1)
The iterative approach only allocates a few pointers, so it has a constant overall memory footprint.
*/
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
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var head = ListNode(0)

        var node = head
        var l1 = l1
        var l2 = l2
        while l1 != nil, l2 != nil {
            if l1!.val > l2!.val {
                node.next = l2
                l2 = l2!.next
            } else {
                node.next = l1
                l1 = l1!.next
            }
            node = node.next!
        }

        if l1 == nil {
            node.next = l2
        }

        if l2 == nil {
            node.next = l1
        }

        return head.next
    }
}

/*
Solution 3:
another code style of Solution 1
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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil { return list2 }
        if list2 == nil { return list1 }

        if list1!.val > list2!.val {
            return mergeTwoLists(list2, list1)
        }

        // list!.val <= list2!.val
        // merge list1 into list1
        var head = list1
        var cur = head
        var l1 = list1!.next
        var l2 = list2
        while l1 != nil || l2 != nil {
            if let templ1 = l1, let templ2 = l2 {
                if templ1.val < templ2.val {
                    cur?.next = templ1
                    l1 = templ1.next
                } else {
                    cur?.next = templ2
                    l2 = templ2.next
                }
            } else {
                // one list is finished
                if let templ1 = l1 {
                    cur?.next = templ1
                    break
                }
                if let templ2 = l2 {
                    cur?.next = templ2
                    break
                }
            }
            cur = cur?.next
        }

        return head
    }
}

/*
Solution 2: Recursive
recursive merge 2 lists

Time Complexity: O(m+n)
Space Complexity: O(m+n)
*/
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
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        if l1 == nil { return l2 }
        if l2 == nil { return l1 }
        if l1!.val < l2!.val {
            l1!.next = mergeTwoLists(l1!.next, l2)
            return l1
        }
        l2!.next = mergeTwoLists(l1, l2!.next)
        return l2
    }
}
