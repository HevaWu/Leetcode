// Given a linked list, remove the n-th node from the end of list and return its head.

// Example:

// Given linked list: 1->2->3->4->5, and n = 2.

// After removing the second node from the end, the linked list becomes 1->2->3->5.
// Note:

// Given n will always be valid.

// Follow up:

// Could you do this in one pass?

// Solution 1: 2 pass
// First pass go through all linked list, mark length len
// we should remove len-n+1 node
// second pass relink len-n & len-n+2 to remove node
// 
// Time Complexity: O(L).The algorithm makes two traversal of the list, first to calculate list length LL and second to find the (L - n)(L−n) th node. There are 2L-n2L−n operations and time complexity is O(L)O(L).
// Space complexity : O(1)O(1).We only used constant extra space.

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
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        guard head != nil, n > 0 else { return head }
        
        var dummy = ListNode(0)
        dummy.next = head
        
        var len = 0
        var head = head
        while head != nil {
            len += 1
            head = head!.next
        }
        
        // remove len-n+1 node
        // find len-n node
        var node = dummy
        var index = 0
        while index < len-n, node != nil {
            node = node.next!
            index += 1
        }

        // relink
        guard node.next != nil else { return nil }
        node.next = node.next!.next
        return dummy.next
    }
}

// Solution 2: one pass
// The above algorithm could be optimized to one pass. Instead of one pointer, we could use two pointers. The first pointer advances the list by n+1n+1 steps from the beginning, while the second pointer starts from the beginning of the list. Now, both pointers are exactly separated by nn nodes apart. We maintain this constant gap by advancing both pointers together until the first pointer arrives past the last node. The second pointer will be pointing at the nnth node counting from the last. We relink the next pointer of the node referenced by the second pointer to point to the node's next next node.
// 
// Time complexity : O(L)O(L) The algorithm makes one traversal of the list of LL nodes. Therefore time complexity is O(L)O(L).
// Space complexity : O(1)O(1). We only used constant extra space.
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
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var dummy = ListNode(0)
        dummy.next = head
        
        var left = dummy
        var right = dummy
        var dis = 0
        
        while right.next != nil {
            right = right.next!
            dis += 1
            if dis > n {
                left = left.next!
            }
        }
        
        guard left.next != nil else { return nil }
        left.next = left.next!.next
        return dummy.next
    }
}