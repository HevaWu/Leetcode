/*
Design a queue that supports push and pop operations in the front, middle, and back.

Implement the FrontMiddleBack class:

FrontMiddleBack() Initializes the queue.
void pushFront(int val) Adds val to the front of the queue.
void pushMiddle(int val) Adds val to the middle of the queue.
void pushBack(int val) Adds val to the back of the queue.
int popFront() Removes the front element of the queue and returns it. If the queue is empty, return -1.
int popMiddle() Removes the middle element of the queue and returns it. If the queue is empty, return -1.
int popBack() Removes the back element of the queue and returns it. If the queue is empty, return -1.
Notice that when there are two middle position choices, the operation is performed on the frontmost middle position choice. For example:

Pushing 6 into the middle of [1, 2, 3, 4, 5] results in [1, 2, 6, 3, 4, 5].
Popping the middle from [1, 2, 3, 4, 5, 6] returns 3 and results in [1, 2, 4, 5, 6].


Example 1:

Input:
["FrontMiddleBackQueue", "pushFront", "pushBack", "pushMiddle", "pushMiddle", "popFront", "popMiddle", "popMiddle", "popBack", "popFront"]
[[], [1], [2], [3], [4], [], [], [], [], []]
Output:
[null, null, null, null, null, 1, 3, 4, 2, -1]

Explanation:
FrontMiddleBackQueue q = new FrontMiddleBackQueue();
q.pushFront(1);   // [1]
q.pushBack(2);    // [1, 2]
q.pushMiddle(3);  // [1, 3, 2]
q.pushMiddle(4);  // [1, 4, 3, 2]
q.popFront();     // return 1 -> [4, 3, 2]
q.popMiddle();    // return 3 -> [4, 2]
q.popMiddle();    // return 4 -> [2]
q.popBack();      // return 2 -> []
q.popFront();     // return -1 -> [] (The queue is empty)


Constraints:

1 <= val <= 109
At most 1000 calls will be made to pushFront, pushMiddle, pushBack, popFront, popMiddle, and popBack.
*/

/*
Solution 1:
brute force with one array

- push middle, always push at n/2 position
- pop middle,
  - if current queue is even, pop at n/2-1 position element
  - if current queue is odd, pop at n/2 position element

Time Complexity:
- all push O(1)
- pop front O(n)
- pop middle O(n)
- pop last O(1)
Space Complexity: O(n)
*/
class FrontMiddleBackQueue {
    var queue: [Int]

    init() {
        queue = [Int]()
    }

    func pushFront(_ val: Int) {
        queue.insert(val, at: 0)
    }

    func pushMiddle(_ val: Int) {
        let n = queue.count
        queue.insert(
            val,
            at: n / 2
        )
    }

    func pushBack(_ val: Int) {
        queue.append(val)
    }

    func popFront() -> Int {
        if queue.isEmpty { return -1 }
        return queue.removeFirst()
    }

    func popMiddle() -> Int {
        if queue.isEmpty { return -1 }
        let n = queue.count
        return queue.remove(at: (n-1)/2)
        // let pos = n % 2 == 0 ? (n/2-1) : n/2
        // let val = queue[pos]
        // if pos == 0 {
        //     if n > 1 {
        //         queue = Array(queue[1...])
        //     } else {
        //         queue = [Int]()
        //     }
        // } else if pos == n-1 {
        //     queue = Array(queue[..<pos])
        // } else {
        //     queue = Array(queue[..<pos]) + Array(queue[(pos+1)...])
        // }
        // return val
    }

    func popBack() -> Int {
        if queue.isEmpty { return -1 }
        return queue.removeLast()
    }
}

/**
 * Your FrontMiddleBackQueue object will be instantiated and called as such:
 * let obj = FrontMiddleBackQueue()
 * obj.pushFront(val)
 * obj.pushMiddle(val)
 * obj.pushBack(val)
 * let ret_4: Int = obj.popFront()
 * let ret_5: Int = obj.popMiddle()
 * let ret_6: Int = obj.popBack()
 */