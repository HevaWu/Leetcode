/*
Design your implementation of the linked list. You can choose to use a singly or doubly linked list.
A node in a singly linked list should have two attributes: val and next. val is the value of the current node, and next is a pointer/reference to the next node.
If you want to use the doubly linked list, you will need one more attribute prev to indicate the previous node in the linked list. Assume all nodes in the linked list are 0-indexed.

Implement the MyLinkedList class:

MyLinkedList() Initializes the MyLinkedList object.
int get(int index) Get the value of the indexth node in the linked list. If the index is invalid, return -1.
void addAtHead(int val) Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list.
void addAtTail(int val) Append a node of value val as the last element of the linked list.
void addAtIndex(int index, int val) Add a node of value val before the indexth node in the linked list. If index equals the length of the linked list, the node will be appended to the end of the linked list. If index is greater than the length, the node will not be inserted.
void deleteAtIndex(int index) Delete the indexth node in the linked list, if the index is valid.
 

Example 1:

Input
["MyLinkedList", "addAtHead", "addAtTail", "addAtIndex", "get", "deleteAtIndex", "get"]
[[], [1], [3], [1, 2], [1], [1], [1]]
Output
[null, null, null, null, 2, null, 3]

Explanation
MyLinkedList myLinkedList = new MyLinkedList();
myLinkedList.addAtHead(1);
myLinkedList.addAtTail(3);
myLinkedList.addAtIndex(1, 2);    // linked list becomes 1->2->3
myLinkedList.get(1);              // return 2
myLinkedList.deleteAtIndex(1);    // now the linked list is 1->3
myLinkedList.get(1);              // return 3
 

Constraints:

0 <= index, val <= 1000
Please do not use the built-in LinkedList library.
At most 2000 calls will be made to get, addAtHead, addAtTail,  addAtIndex and deleteAtIndex.
*/

/*
Solution 2:
Doubly linked list
*/

class MyLinkedList {
    var head: ListNode?
    var tail: ListNode?
    
    /** Initialize your data structure here. */
    init() {
        head = nil
        tail = nil
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        var cur = head
        for i in 0..<index {
            // if cur == nil { return -1 }
            cur = cur?.next
        }
        return cur == nil ? -1 : cur!.val
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        var cur = ListNode(val)
        if head == nil {
            head = cur
            tail = head
        } else {
            cur.next = head
            head?.prev = cur
            head = cur
        }
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        var cur = ListNode(val)
        if tail == nil {
            head = cur
            tail = head
        } else {
            tail?.next = cur
            cur.prev = tail
            tail = cur
        }
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if index == 0 {
            addAtHead(val)
            return 
        }
        
        var cur = head
        for i in 0..<index {
            if cur == nil { return }
            cur = cur!.next
        }
        
        // index greater than length
        if cur == nil { 
            addAtTail(val)
            return 
        }
        
        var newNode = ListNode(val)
        newNode.next = cur
        newNode.prev = cur!.prev
        cur!.prev?.next = newNode
        cur!.prev = newNode
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        if index == 0 {
            head = head?.next
            return
        }
        
        var cur = head
        for i in 0..<index {
            if cur == nil { return }
            cur = cur!.next
        }
        
        if cur == nil { return }
        if cur!.next == nil {
            // cur is tail
            cur!.prev?.next = nil
            tail = cur!.prev
            return
        }
        cur!.prev?.next = cur!.next
        cur!.next?.prev = cur!.prev
    }
}

class ListNode {
    var val: Int
    var next: ListNode?
    var prev: ListNode?
    init(_ val: Int) {
        self.val = val
    }
}

/**
 * Your MyLinkedList object will be instantiated and called as such:
 * let obj = MyLinkedList()
 * let ret_1: Int = obj.get(index)
 * obj.addAtHead(val)
 * obj.addAtTail(val)
 * obj.addAtIndex(index, val)
 * obj.deleteAtIndex(index)
 */

/*
Solution 1:
Singly linked list
*/
class MyLinkedList {
    var head: ListNode?
    
    /** Initialize your data structure here. */
    init() {
        head = nil
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        var cur = head
        for i in 0..<index {
            // if cur == nil { return -1 }
            cur = cur?.next
        }
        return cur == nil ? -1 : cur!.val
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        var cur = ListNode(val)
        cur.next = head
        head = cur
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if head == nil {
            head = ListNode(val)
            return
        }
        
        var cur = head
        while cur?.next != nil {
            cur = cur?.next
        }
        cur?.next = ListNode(val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if index == 0 {
            addAtHead(val)
            return 
        }
        
        var cur = head
        for i in 0..<(index-1) {
            if cur == nil { return }
            cur = cur!.next
        }
        
        if cur == nil { return }
        var newNode = ListNode(val)
        newNode.next = cur!.next
        cur!.next = newNode
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        if index == 0 {
            head = head?.next
            return
        }
        
        var cur = head
        for i in 0..<(index-1) {
            if cur == nil { return }
            cur = cur!.next
        }
        if cur == nil { return }
        cur!.next = cur!.next?.next
    }
}

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
    }
}

/**
 * Your MyLinkedList object will be instantiated and called as such:
 * let obj = MyLinkedList()
 * let ret_1: Int = obj.get(index)
 * obj.addAtHead(val)
 * obj.addAtTail(val)
 * obj.addAtIndex(index, val)
 * obj.deleteAtIndex(index)
 */