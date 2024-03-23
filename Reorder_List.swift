/*143. Reorder List   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 81405
Total Submissions: 331412
Difficulty: Medium
Contributors: Admin
Given a singly linked list L: L0→L1→…→Ln-1→Ln,
reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…

You must do this in-place without altering the nodes' values.

For example,
Given {1,2,3,4}, reorder it to {1,4,2,3}.

Hide Tags Linked List
*/

/*reverse list
1. find the middle element
2. reverse the element behind the mid(change 1-2-3-4-5-6 to 1-2-3-6-5-4)
3. insert the behind-mid element to the before-mid element(change 1-2-3-6-5-4 to 1-6-2-5-3-4)*/

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
    func reorderList(_ head: ListNode?) {
        if head == nil || head?.next == nil { return }
        var p1 = head
        var p2 = head
        while p2?.next != nil && p2?.next?.next != nil {
            p1 = p1?.next
            p2 = p2?.next?.next
        }

        var preMid = p1
        var preCur = p1?.next
        while preCur?.next != nil {
            var cur = preCur?.next
            preCur?.next = cur?.next
            cur?.next = preMid?.next
            preMid?.next = cur
        }

        p1 = head
        p2 = preMid?.next
        while p1 !== preMid {
            preMid?.next = p2?.next
            p2?.next = p1?.next
            p1?.next = p2

            p1 = p2?.next
            p2 = preMid?.next
        }
    }
}
