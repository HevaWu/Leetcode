/*
In a linked list of size n, where n is even, the ith node (0-indexed) of the linked list is known as the twin of the (n-1-i)th node, if 0 <= i <= (n / 2) - 1.

For example, if n = 4, then node 0 is the twin of node 3, and node 1 is the twin of node 2. These are the only nodes with twins for n = 4.
The twin sum is defined as the sum of a node and its twin.

Given the head of a linked list with even length, return the maximum twin sum of the linked list.



Example 1:


Input: head = [5,4,2,1]
Output: 6
Explanation:
Nodes 0 and 1 are the twins of nodes 3 and 2, respectively. All have twin sum = 6.
There are no other nodes with twins in the linked list.
Thus, the maximum twin sum of the linked list is 6.
Example 2:


Input: head = [4,2,2,3]
Output: 7
Explanation:
The nodes with twins present in this linked list are:
- Node 0 is the twin of node 3 having a twin sum of 4 + 3 = 7.
- Node 1 is the twin of node 2 having a twin sum of 2 + 2 = 4.
Thus, the maximum twin sum of the linked list is max(7, 4) = 7.
Example 3:


Input: head = [1,100000]
Output: 100001
Explanation:
There is only one node with a twin in the linked list having twin sum of 1 + 100000 = 100001.


Constraints:

The number of nodes in the list is an even integer in the range [2, 105].
1 <= Node.val <= 105
*/

/*
Solution 2:
iterate whole List only once
use two pointer to quick get the second part header
use arr to store first half elements value
then when go to second part, add and compare current twin value

Time Complexity: O(n)
Space Complexity: O(n/2)
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
    func pairSum(_ head: ListNode?) -> Int {
        var first = head
        var second = head?.next
        // save the first half value
        var arr = [Int]()
        while second?.next != nil, second?.next?.next != nil {
            arr.append(first!.val)
            first = first?.next
            second = second?.next?.next
        }
        // add the last element in first half
        arr.append(first!.val)
        // print(arr)
        second = first?.next
        var val = 0
        var i = arr.count-1
        while second != nil {
            val = max(val, arr[i] + second!.val)
            second = second?.next
            i -= 1
        }
        return val
    }
}

/*
Solution 1:
convert List to array
then iterate array to calculate the twin pair

Time Complexity: O(n)
Space Complexity: O(n)
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
    func pairSum(_ head: ListNode?) -> Int {
        var arr = [Int]()
        var cur = head
        while cur != nil {
            arr.append(cur!.val)
            cur = cur?.next
        }

        let n = arr.count
        var val = 0
        for i in 0..<(n/2) {
            val = max(val, arr[i] + arr[n-1-i])
        }
        return val
    }
}
