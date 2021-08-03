/*
We are given a linked list with head as the first node.  Let's number the nodes in the list: node_1, node_2, node_3, ... etc.

Each node may have a next larger value: for node_i, next_larger(node_i) is the node_j.val such that j > i, node_j.val > node_i.val, and j is the smallest possible choice.  If such a j does not exist, the next larger value is 0.

Return an array of integers answer, where answer[i] = next_larger(node_{i+1}).

Note that in the example inputs (not outputs) below, arrays such as [2,1,5] represent the serialization of a linked list with a head node value of 2, second node value of 1, and third node value of 5.



Example 1:

Input: [2,1,5]
Output: [5,5,0]
Example 2:

Input: [2,7,4,3,5]
Output: [7,0,5,5,0]
Example 3:

Input: [1,7,5,1,9,2,5,1]
Output: [7,9,9,9,0,5,0,0]


Note:

1 <= node.val <= 10^9 for each node in the linked list.
The given list has length in the range [0, 10000].
*/

/*
Solution 1:
convert listNode list to array
find next larger element in array and put them in result
-> use larger stack to keep tracking larger element

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
    func nextLargerNodes(_ head: ListNode?) -> [Int] {
        var arr = [Int]()
        var node = head
        while node != nil {
            arr.append(node!.val)
            node = node?.next
        }

        let n = arr.count
        if n == 1 { return [0] }

        var res = Array(repeating: 0, count: n)
        var larger = [arr[n-1]]
        for i in stride(from: n-2, through: 0, by: -1) {
            // <= want strictly larger element
            while !larger.isEmpty, larger.last! <= arr[i] {
                larger.removeLast()
            }
            res[i] = larger.isEmpty ? 0 : larger.last!
            larger.append(arr[i])
        }
        return res
    }
}