// Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

// Example:

// Input:
// [
//   1->4->5,
//   1->3->4,
//   2->6
// ]
// Output: 1->1->2->3->4->4->5->6

// Solution 1: Mege list one by one
// convert to search 2 list for n times <- n is lists.count
// 
// Time Complexity: O(Kn)
// Space Complexity: O(Kn)
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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        var node = lists[0]
        
        for i in 1..<lists.count {
            let list = lists[i]
            // sort node
            node = merge2Lists(node, list)
        }
        return node
    }
    
    func merge2Lists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard list1 != nil else { return list2 }
        guard list2 != nil else { return list1 }
        
        var list1 = list1
        var list2 = list2
        var node = ListNode(0)
        var head = node
        
        while list1 != nil, list2 != nil {
            if list1!.val < list2!.val {
                node.next = list1
                list1 = list1!.next
            } else {
                node.next = list2
                list2 = list2!.next
            }
            node = node.next!
        }
        
        if list1 == nil {
            node.next = list2    
        }
        
        if list2 == nil {
            node.next = list1
        }
        
        return head.next
    } 
}

// Solution 2: Divide & Conquer
// Optimize first solution:
// Pair up \text{k}k lists and merge each pair.
// After the first pairing, \text{k}k lists are merged into k/2k/2 lists with average 2N/k2N/k length, then k/4k/4, k/8k/8 and so on.
// Repeat this procedure until we get the final sorted linked list.
// Thus, we'll traverse almost NN nodes per pairing and merging, and repeat this procedure about \log_{2}{k}log2k times.
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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        
        var lists = lists
        var n = lists.count
        var interval = 1
        
        var head = ListNode(0)
        while interval < n {
            for i in stride(from: 0, to: n - interval, by: interval+1) {
                lists[i] = merge2List(lists[i], lists[i+interval])
            }
            interval *= 2 
        }
        return lists[0] 
    }
    
    func merge2List(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard list1 != nil else { return list2 }
        guard list2 != nil else { return list1 }
        
        var list1 = list1
        var list2 = list2
        var node = ListNode(0)
        var head = node
        
        while list1 != nil, list2 != nil {
            if list1!.val > list2!.val {
                node.next = list2
                list2 = list2!.next
            } else {
                node.next = list1
                list1 = list1!.next
            }
            node = node.next!
        }
        
        if list1 == nil {
            node.next = list2
        }
        
        if list2 == nil {
            node.next = list1
        }
        
        return head.next
    }

// Another merge2Lists solution 
    func merge2Lists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard list1 != nil else { return list2 }
        guard list2 != nil else { return list1 }
        
        var head: ListNode
        var another: ListNode?
        if list1!.val < list2!.val {
            head = list1!
            another = list2
        } else {
            head = list2!
            another = list1
        }
        
        var cur: ListNode = head
        while another != nil {
            if cur.next == nil || cur.next!.val > another!.val {
                let temp = cur.next
                cur.next = another!
                another = temp
            }
            cur = cur.next!
        }
        return head
    }
}

// Solution 3: Brute Force
// Put all of node in an array first, then sort them
// 
// Time Complexity: O(N\log N) where NN is the total number of nodes.
// Collecting all the values costs O(N) time.
// A stable sorting algorithm costs O(N\log N) time.
// Iterating for creating the linked list costs O(N) time.
// Space complexity : O(N).
// Sorting cost O(N) space (depends on the algorithm you choose).
// Creating a new linked list costs O(N) space.
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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        
        // save all node
        var nodeArr = [Int]()
        for list in lists {
            var varlist = list
            while varlist != nil {
                nodeArr.append(varlist!.val)
                varlist = varlist!.next
            }
        }
        
        // put it into ListNode
        var node = ListNode(0)
        var head = node
        for i in nodeArr.sorted() {
            node.next = ListNode(i)
            node = node.next!
        }
        return head.next
    }
}

/*
Solution 4:
recursive

Time Limit Exceeded
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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        
        var node: ListNode? = nil
        var cur = 0

        for i in 0..<lists.count {
            if node == nil || (lists[i] != nil && lists[i]!.val < node!.val) {
                node = lists[i]
                cur = i
            }
        }
        
        if node == nil {
            return nil
        }
                
        var temp = lists
        if lists[cur]?.next == nil {
            temp.remove(at: cur)
        } else {
            temp[cur] = lists[cur]?.next
        }
        node?.next = mergeKLists(temp)
        return node
    }
}

/*
Solution 5:
Passed

Divide and conquer
recursive merge2Lists(lists[..<n/2], lists[n/2..<n])
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
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        guard !lists.isEmpty else { return nil }
        if lists.count == 1 { return lists[0] }
        if lists.count == 2 { return merge2Lists(lists[0], lists[1]) }
        
        return merge2Lists(
            mergeKLists(Array(lists[..<(lists.count/2)])),
            mergeKLists(Array(lists[(lists.count/2)..<lists.count]))
        )
    }
    
    func merge2Lists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        guard list1 != nil else { return list2 }
        guard list2 != nil else { return list1 }
        
        var head: ListNode
        var another: ListNode?
        if list1!.val < list2!.val {
            head = list1!
            another = list2
        } else {
            head = list2!
            another = list1
        }
        
        var cur: ListNode = head
        while another != nil {
            if cur.next == nil || cur.next!.val > another!.val {
                let temp = cur.next
                cur.next = another!
                another = temp
            }
            cur = cur.next!
        }
        return head
    }
}