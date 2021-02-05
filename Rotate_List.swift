/*
Given the head of a linked list, rotate the list to the right by k places.

 

Example 1:


Input: head = [1,2,3,4,5], k = 2
Output: [4,5,1,2,3]
Example 2:


Input: head = [0,1,2], k = 4
Output: [2,0,1]
 

Constraints:

The number of nodes in the list is in the range [0, 500].
-100 <= Node.val <= 100
0 <= k <= 2 * 109
*/

/*
Solution 2:
2 pointer 

count list length n first
then update k = k%n

use 2 pointer, slow, fast to find last kth element
and update slow, fast
rotateHead = slow?.next
fast.next = head
slow.next = nil

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
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        let n = getListLength(head)
        var k = k%n
        
        if k == 0 { return head }
        
        var slow: ListNode? = head
        var fast: ListNode? = head
        for i in 0..<k {
            fast = fast?.next
        }
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next
        }
        
        var rotateHead = slow?.next
        fast?.next = head
        slow?.next = nil
        
        return rotateHead
    }
    
    func getListLength(_ head: ListNode?) -> Int {
        var res = 0
        var cur: ListNode? = head
        while cur != nil {
            res += 1
            cur = cur?.next
        }
        return res
    }
}

/*
Solution 1:
store into arr first
then find start = n-k%n
create new headNode
iteratively store element into list

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
    func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard let head = head else { return nil }
        var arr = [Int]()
        
        var cur: ListNode? = head
        while cur != nil {
            arr.append(cur!.val)
            cur = cur?.next
        }
        
        let n = arr.count
        let remain = k % n
        if remain == 0 {
            return head
        }
                
        var start = n - remain
        var rotateHead = ListNode(arr[start])
        cur = rotateHead
        if remain > 1 {
            for i in (start+1)..<n {
                cur?.next = ListNode(arr[i])
                cur = cur?.next
            }
        }
        
        for i in 0..<start {
            cur?.next = ListNode(arr[i])
            cur = cur?.next
        }
        
        return rotateHead
    }
}
