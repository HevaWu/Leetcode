/*
You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.



Example 1:


Input: l1 = [7,2,4,3], l2 = [5,6,4]
Output: [7,8,0,7]
Example 2:

Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [8,0,7]
Example 3:

Input: l1 = [0], l2 = [0]
Output: [0]


Constraints:

The number of nodes in each linked list is in the range [1, 100].
0 <= Node.val <= 9
It is guaranteed that the list represents a number that does not have leading zeros.


Follow up: Could you solve it without reversing the input lists?
*/

/*
Solution 1:
stack to store l1 and l2 int value first

Time Complexity: O(max(n1, n2))
Space Complexity: O(n1 + n2)
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
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var stack1 = [Int]()
        var stack2 = [Int]()

        var node = l1
        while node != nil {
            stack1.append(node!.val)
            node = node?.next
        }

        node = l2
        while node != nil {
            stack2.append(node!.val)
            node = node?.next
        }

        var cur = 0
        var head: ListNode? = nil
        while !stack1.isEmpty || !stack2.isEmpty {
            if !stack1.isEmpty {
                cur += stack1.removeLast()
            }
            if !stack2.isEmpty {
                cur += stack2.removeLast()
            }

            let val = cur % 10
            cur /= 10

            let newNode = ListNode(val)
            newNode.next = head
            head = newNode
        }

        if cur != 0 {
            let newNode = ListNode(cur)
            newNode.next = head
            head = newNode
        }
        return head
    }
}
