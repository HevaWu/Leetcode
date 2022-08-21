/*
You want to form a target string of lowercase letters.

At the beginning, your sequence is target.length '?' marks.  You also have a stamp of lowercase letters.

On each turn, you may place the stamp over the sequence, and replace every letter in the sequence with the corresponding letter from the stamp.  You can make up to 10 * target.length turns.

For example, if the initial sequence is "?????", and your stamp is "abc",  then you may make "abc??", "?abc?", "??abc" in the first turn.  (Note that the stamp must be fully contained in the boundaries of the sequence in order to stamp.)

If the sequence is possible to stamp, then return an array of the index of the left-most letter being stamped at each turn.  If the sequence is not possible to stamp, return an empty array.

For example, if the sequence is "ababc", and the stamp is "abc", then we could return the answer [0, 2], corresponding to the moves "?????" -> "abc??" -> "ababc".

Also, if the sequence is possible to stamp, it is guaranteed it is possible to stamp within 10 * target.length moves.  Any answers specifying more than this number of moves will not be accepted.



Example 1:

Input: stamp = "abc", target = "ababc"
Output: [0,2]
([1,0,2] would also be accepted as an answer, as well as some other answers.)
Example 2:

Input: stamp = "abca", target = "aabcaca"
Output: [3,0,1]


Note:

1 <= stamp.length <= target.length <= 1000
stamp and target only contain lowercase letters.
*/

/*
Solution 2:
backward

use only todo set to help tracking each window's not matched index

Time Complexity: O(m * (n-m))
Space Complexity: O(m * (n-m))
*/
class Solution {
    func movesToStamp(_ stamp: String, _ target: String) -> [Int] {
        let n = target.count
        let m = stamp.count

        var target = Array(target)
        var stamp = Array(stamp)

        // backward target to see if we can
        // re-build the stamp index array
        // convert target to ???..??

        // stamps move index array
        var move = [Int]()

        // record the index which can be stamped
        var queue = [Int]()

        var nodeArr = [Node]()

        // init loop over all m windows
        // find initial can be replaced windows
        for i in 0...(n-m) {
            // check each i..<(i+m) window

            // use node to
            // help check the character match stamp character
            var node = Node()
            for j in 0..<m {
                if stamp[j] != target[i+j] {
                    node.todo.insert(i+j)
                }
            }

            nodeArr.append(node)

            if node.todo.isEmpty {
                // current i..<(i+m) window could be set as last stamp
                queue.append(i)
            }
        }

        // backward target
        while !queue.isEmpty {
            let index = queue.removeFirst()
            move.insert(index, at: 0)

            // for index..<index+m will be put the stamp
            // update index..<index+m to ?
            for i in index..<index+m {
                target[i] = "?"
                // the i replace could effect all windows
                // who contains this i in their todo node
                for j in max(0, i-m+1)...min(n-m, i) {
                    if nodeArr[j].todo.contains(i) {
                        nodeArr[j].todo.remove(i)
                        if nodeArr[j].todo.isEmpty {
                            queue.append(j)
                        }
                    }
                }
            }
        }

        return isAllConverted(target) ? move : []
    }

    // check if all character in target have been updated to ?
    func isAllConverted(_ target: [Character]) -> Bool {
        for c in target {
            if c != "?" {
                return false
            }
        }
        return true
    }
}

// hold match result for m window
class Node {
    // record the index which match the stamp character
    var todo = Set<Int>()
}

/*
Solution 1:
backwards
- Imagine we stamped the sequence with moves m_1, m_2,⋯. Now, from the final position target, we will make those moves in reverse order.
- Let's call the ith window, a subarray of target of length stamp.length that starts at i. Each move at position i is possible if the ith window matches the stamp. After, every character in the window becomes a wildcard that can match any character in the stamp.
- For example, say we have stamp = "abca" and target = "aabcaca". Working backwards, we will reverse stamp at window 1 to get "a????ca", then reverse stamp at window 3 to get "a??????", and finally reverse stamp at position 0 to get "???????".

keep track every window
how many cells initially match the stamp (our "made" list), and which ones don't (our "todo" list). Any windows that are ready (ie. have no todo list), get enqueued.

Time Complexity: O(n * (n-m))
Space Complexity: O(n * (n-m))
*/
class Solution {
    func movesToStamp(_ stamp: String, _ target: String) -> [Int] {
        let m = stamp.count
        let n = target.count

        var stamp = Array(stamp)
        var target = Array(target)

        // use to memo cannot fully replaced element
        var queue = [Int]()

        // true - if already replaced
        var done = Array(repeating: false, count: n)

        // result stamp order
        var res = [Int]()

        // help checking remaining todo element in this window
        var arr = [Node]()

        for i in 0...(n-m) {
            // for each window [i, i+m)
            // arr[i] contain info what needs to change before
            // we can reverse stamp at this window
            var made = Set<Int>()
            var todo = Set<Int>()

            for j in 0..<m {
                if target[i+j] == stamp[j] {
                    made.insert(i+j)
                } else {
                    todo.insert(i+j)
                }
            }

            arr.append(Node(made: made, todo: todo))
            if todo.isEmpty {
                res.insert(i, at: 0)
                for j in i..<i+m {
                    queue.append(j)
                    done[j] = true
                }
            }
        }

        while !queue.isEmpty {
            let i = queue.removeFirst()
            for j in max(0, i-m+1)...min(n-m, i) {
                if arr[j].todo.contains(i) {
                    arr[j].todo.remove(i)
                    if arr[j].todo.isEmpty {
                        res.insert(j, at: 0)
                        for m in arr[j].made {
                            if !done[m] {
                                queue.append(m)
                                done[m] = true
                            }
                        }
                    }
                }
            }
        }

        for d in done {
            if !d { return [] }
        }

        return res
    }
}

class Node {
    var made = Set<Int>()
    var todo = Set<Int>()
    init(made: Set<Int>, todo: Set<Int>) {
        self.made = made
        self.todo = todo
    }
}