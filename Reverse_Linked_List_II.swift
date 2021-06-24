/*
Given the head of a singly linked list and two integers left and right where left <= right, reverse the nodes of the list from position left to position right, and return the reversed list.



Example 1:


Input: head = [1,2,3,4,5], left = 2, right = 4
Output: [1,4,3,2,5]
Example 2:

Input: head = [5], left = 1, right = 1
Output: [5]


Constraints:

The number of nodes in the list is n.
1 <= n <= 500
-500 <= Node.val <= 500
1 <= left <= right <= n
*/

/*
Solution 1:
dummy + list reverse

make dummy head incase left is beginning node

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
    func reverseBetween(_ head: ListNode?, _ left: Int, _ right: Int) -> ListNode? {
        guard let head = head else { return nil }
        if left == right { return head }

        var dummy = ListNode(0)
        dummy.next = head

        var node: ListNode? = dummy
        var i = 1
        while i < left, node != nil {
            node = node?.next
            i += 1
        }
        if node == nil { return head }

        var pre: ListNode? = node
        // print(pre?.val)
        node = node?.next
        while i < right, node != nil {
            let next = node?.next
            node?.next = next?.next
            next?.next = pre?.next
            pre?.next = next

            i += 1
        }

        return dummy.next
    }
}