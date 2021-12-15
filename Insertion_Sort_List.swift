/*
Given the head of a singly linked list, sort the list using insertion sort, and return the sorted list's head.

The steps of the insertion sort algorithm:

Insertion sort iterates, consuming one input element each repetition and growing a sorted output list.
At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list and inserts it there.
It repeats until no input elements remain.
The following is a graphical example of the insertion sort algorithm. The partially sorted list (black) initially contains only the first element in the list. One element (red) is removed from the input data and inserted in-place into the sorted list with each iteration.




Example 1:


Input: head = [4,2,1,3]
Output: [1,2,3,4]
Example 2:


Input: head = [-1,5,3,4,0]
Output: [-1,0,3,4,5]


Constraints:

The number of nodes in the list is in the range [1, 5000].
-5000 <= Node.val <= 5000
*/

/*
Solution 2:
optimize Solution1
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
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        var head = head
        var newHead: ListNode = ListNode(Int.min)

        while head != nil {
            let next = head!.next

            var cur = newHead
            while cur.next != nil, cur.next!.val < head!.val {
                cur = cur.next!
            }
            head!.next = cur.next
            cur.next = head
            head = next
        }
        return newHead.next
    }
}

/*
Solution 1:
init newHead as nil
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
    func insertionSortList(_ head: ListNode?) -> ListNode? {
        var head = head
        var newHead: ListNode? = nil
        while head != nil {
            let next = head!.next
            if newHead == nil {
                head!.next = nil
                newHead = head
            } else {
                if newHead!.val >= head!.val {
                    head!.next = newHead
                    newHead = head
                } else {
                    var cur = newHead
                    while cur!.next != nil, cur!.next!.val < head!.val {
                        cur = cur!.next
                    }
                    head!.next = cur!.next
                    cur!.next = head
                }
            }
            head = next
        }
        return newHead
    }
}