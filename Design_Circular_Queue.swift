/*
Design your implementation of the circular queue. The circular queue is a linear data structure in which the operations are performed based on FIFO (First In First Out) principle and the last position is connected back to the first position to make a circle. It is also called "Ring Buffer".

One of the benefits of the circular queue is that we can make use of the spaces in front of the queue. In a normal queue, once the queue becomes full, we cannot insert the next element even if there is a space in front of the queue. But using the circular queue, we can use the space to store new values.

Implementation the MyCircularQueue class:

MyCircularQueue(k) Initializes the object with the size of the queue to be k.
int Front() Gets the front item from the queue. If the queue is empty, return -1.
int Rear() Gets the last item from the queue. If the queue is empty, return -1.
boolean enQueue(int value) Inserts an element into the circular queue. Return true if the operation is successful.
boolean deQueue() Deletes an element from the circular queue. Return true if the operation is successful.
boolean isEmpty() Checks whether the circular queue is empty or not.
boolean isFull() Checks whether the circular queue is full or not.
 

Example 1:

Input
["MyCircularQueue", "enQueue", "enQueue", "enQueue", "enQueue", "Rear", "isFull", "deQueue", "enQueue", "Rear"]
[[3], [1], [2], [3], [4], [], [], [], [4], []]
Output
[null, true, true, true, false, 3, true, true, true, 4]

Explanation
MyCircularQueue myCircularQueue = new MyCircularQueue(3);
myCircularQueue.enQueue(1); // return True
myCircularQueue.enQueue(2); // return True
myCircularQueue.enQueue(3); // return True
myCircularQueue.enQueue(4); // return False
myCircularQueue.Rear();     // return 3
myCircularQueue.isFull();   // return True
myCircularQueue.deQueue();  // return True
myCircularQueue.enQueue(4); // return True
myCircularQueue.Rear();     // return 4
 

Constraints:

1 <= k <= 1000
0 <= value <= 1000
At most 3000 calls will be made to enQueue, deQueue, Front, Rear, isEmpty, and isFull.
 

Follow up: Could you solve the problem without using the built-in queue? 
*/

/*
Implement by Circular Queue definitaion

Be careful:
- enqueue: if current queue is empty, assign value to head, otherwise, assign value to tail
- dequeue: when removing cur head, move to next element, if next element not exist, assign head to tail for making current queue tail point to correct index
*/
class MyCircularQueue {
    var arr: [Int?]
    var head: Int
    var tail: Int
    let n: Int

    init(_ k: Int) {
        arr = Array(repeating: nil, count: k)
        head = 0
        tail = 0
        n = k
    }
    
    func enQueue(_ value: Int) -> Bool {
        guard !isFull() else { return false }
        if isEmpty() {
            arr[head] = value
        } else {
            tail += 1
            if tail == n {
                tail = 0
            }
            arr[tail] = value
        }
        
        return true
    }
    
    func deQueue() -> Bool {
        guard !isEmpty() else { return false }
        arr[head] = nil
        head += 1
        if head == n {
            head = 0
        } 
        if isEmpty() {
            // if there is no next element, move tail pointer together with head pointer
            tail = head
        }
        return true
    }
    
    func Front() -> Int {
        return isEmpty() ? -1 : arr[head]!
    }
    
    func Rear() -> Int {
        return isEmpty() ? -1 : arr[tail]!
    }
    
    func isEmpty() -> Bool {
        return arr[head] == nil
    }
    
    func isFull() -> Bool {
        guard !isEmpty() else { return false }
        if head <= tail {
            return tail - head + 1 == n
        } else {
            return head == tail + 1
        }
    }
}

/**
 * Your MyCircularQueue object will be instantiated and called as such:
 * let obj = MyCircularQueue(k)
 * let ret_1: Bool = obj.enQueue(value)
 * let ret_2: Bool = obj.deQueue()
 * let ret_3: Int = obj.Front()
 * let ret_4: Int = obj.Rear()
 * let ret_5: Bool = obj.isEmpty()
 * let ret_6: Bool = obj.isFull()
 */