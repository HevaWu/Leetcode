/*
Given the head of a linked list, we repeatedly delete consecutive sequences of nodes that sum to 0 until there are no such sequences.

After doing so, return the head of the final linked list.  You may return any such answer.



(Note that in the examples below, all sequences are serializations of ListNode objects.)

Example 1:

Input: head = [1,2,-3,3,1]
Output: [3,1]
Note: The answer [1,2,1] would also be accepted.
Example 2:

Input: head = [1,2,3,-3,4]
Output: [1,2,4]
Example 3:

Input: head = [1,2,3,-3,-2]
Output: [1]


Constraints:

The given linked list will contain between 1 and 1000 nodes.
Each node in the linked list has -1000 <= node.val <= 1000.
*/

/*
Solution 1:
iterate the list
use dummy to record final list's head's previous node

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
    func removeZeroSumSublists(_ head: ListNode?) -> ListNode? {
        var dummy = ListNode(0)
        dummy.next = head
        var preSum = 0
        var preSumDic = [Int : ListNode]()
        preSumDic[0] = dummy
        var cur = head

        while cur != nil {
            preSum += cur!.val
            if let node = preSumDic[preSum] {
                var nodeToDelete = node.next
                var tempSum = preSum + (nodeToDelete?.val ?? 0)
                while nodeToDelete !== cur {
                    preSumDic[tempSum] = nil
                    nodeToDelete = nodeToDelete!.next
                    tempSum += nodeToDelete!.val
                }
                node.next = cur!.next
            } else {
                preSumDic[preSum] = cur
            }
            cur = cur!.next
        }
        return dummy.next
    }
}
