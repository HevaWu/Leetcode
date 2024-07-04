/*
You are given the head of a linked list, which contains a series of integers separated by 0's. The beginning and end of the linked list will have Node.val == 0.

For every two consecutive 0's, merge all the nodes lying in between them into a single node whose value is the sum of all the merged nodes. The modified list should not contain any 0's.

Return the head of the modified linked list.



Example 1:


Input: head = [0,3,1,0,4,5,2,0]
Output: [4,11]
Explanation:
The above figure represents the given linked list. The modified list contains
- The sum of the nodes marked in green: 3 + 1 = 4.
- The sum of the nodes marked in red: 4 + 5 + 2 = 11.
Example 2:


Input: head = [0,1,0,3,0,2,2,0]
Output: [1,3,4]
Explanation:
The above figure represents the given linked list. The modified list contains
- The sum of the nodes marked in green: 1 = 1.
- The sum of the nodes marked in red: 3 = 3.
- The sum of the nodes marked in yellow: 2 + 2 = 4.


Constraints:

The number of nodes in the list is in the range [3, 2 * 105].
0 <= Node.val <= 1000
There are no two consecutive nodes with Node.val == 0.
The beginning and end of the linked list have Node.val == 0.
*/

/*
Solution 1:
Iterate list, keep recording the
curInDummy: current last node in new dummy list
curVal: current value between two zeros
cur: current node under check in head list

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
    func mergeNodes(_ head: ListNode?) -> ListNode? {
        var dummy = ListNode()
        var curInDummy = dummy
        var curVal = 0
        var cur = head
        while cur != nil {
            if cur!.val != 0 {
                curVal += cur!.val
            } else {
                if curVal != 0 {
                    let newNode = ListNode(curVal)
                    curInDummy.next = newNode
                    curInDummy = newNode
                }
                curVal = 0
            }
            cur = cur!.next
        }
        return dummy.next
    }
}
