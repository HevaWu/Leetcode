/*
There are N dominoes in a line, and we place each domino vertically upright.

In the beginning, we simultaneously push some of the dominoes either to the left or to the right.



After each second, each domino that is falling to the left pushes the adjacent domino on the left.

Similarly, the dominoes falling to the right push their adjacent dominoes standing on the right.

When a vertical domino has dominoes falling on it from both sides, it stays still due to the balance of the forces.

For the purposes of this question, we will consider that a falling domino expends no additional force to a falling or already fallen domino.

Given a string "S" representing the initial state. S[i] = 'L', if the i-th domino has been pushed to the left; S[i] = 'R', if the i-th domino has been pushed to the right; S[i] = '.', if the i-th domino has not been pushed.

Return a string representing the final state.

Example 1:

Input: ".L.R...LR..L.."
Output: "LL.RR.LLRRLL.."
Example 2:

Input: "RR.L"
Output: "RR.L"
Explanation: The first domino expends no additional force on the second domino.
Note:

0 <= N <= 10^5
String dominoes contains only 'L', 'R' and '.'
*/

/*
Solution 2:
2 loop

Scanning from left to right, our force decays by 1 every iteration, and resets to N if we meet an 'R', so that force[i] is higher (than force[j]) if and only if dominoes[i] is closer (looking leftward) to 'R' (than dominoes[j]).

Similarly, scanning from right to left, we can find the force going rightward (closeness to 'L').

For some domino answer[i], if the forces are equal, then the answer is '.'. Otherwise, the answer is implied by whichever force is stronger.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func pushDominoes(_ dominoes: String) -> String {
        let n = dominoes.count
        var dominoes = Array(dominoes)

        var cache = Array(repeating: 0, count: n)
        var force = 0
        for i in 0..<n {
            if dominoes[i] == "R" {
                force = n
            } else if dominoes[i] == "L" {
                force = 0
            } else {
                force = max(force-1, 0)
            }
            cache[i] += force
        }

        for i in stride(from: n-1, through: 0, by: -1)  {
            if dominoes[i] == "L" {
                force = n
            } else if dominoes[i] == "R" {
                force = 0
            } else {
                force = max(force-1, 0)
            }
            cache[i] -= force
        }

        var final = String()
        for c in cache {
            final.append(c > 0 ? "R" : (c < 0 ? "L" : "."))
        }
        return final
    }
}

/*
Solution 1:
queue

record initial state and push them into queue
then iteratively check how to update it

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func pushDominoes(_ dominoes: String) -> String {
        let n = dominoes.count
        var arr = Array(dominoes)

        var queue = [(index: Int, isLeft: Bool)]()
        for i in 0..<n {
            switch arr[i] {
                case "L": queue.append((i, true))
                case "R": queue.append((i, false))
                default: continue
            }
        }

        // if there is no init pushes, return original string
        if queue.isEmpty { return dominoes }

        var pre: (index: Int, isLeft: Bool) = (-1, false)
        let leftChar = Character("L")
        let rightChar = Character("R"
                                 )
        while !queue.isEmpty {
            defer {
                pre = cur
            }

            let cur = queue.removeFirst()
            if pre.index == -1 {
                if cur.isLeft == true {
                    set(leftChar, 0, cur.index-1, &arr)
                }
            } else {
                guard cur.index - pre.index > 1 else { continue }
                if pre.isLeft == cur.isLeft {
                    set(pre.isLeft ? leftChar : rightChar, pre.index, cur.index-1, &arr)
                } else {
                    if !pre.isLeft {
                        let mid = (cur.index+pre.index+1) / 2

                        // pre push to right, cur push to left
                        if (cur.index-pre.index+1) % 2 == 0 {
                            set(rightChar, pre.index, mid-1, &arr)
                            set(leftChar, mid, cur.index-1, &arr)
                        } else {
                            set(rightChar, pre.index, mid-1, &arr)
                            set(leftChar, mid+1, cur.index-1, &arr)
                        }
                    }
                }
            }
        }

        // if last is right, update remaining
        if !pre.isLeft {
            set(rightChar, pre.index, n-1, &arr)
        }

        var final = String()
        for c in arr {
            final.append(c)
        }
        return final
    }

    func set(_ char: Character, _ start: Int, _ end: Int, _ arr: inout [Character]) {
        guard end >= start else { return }
        for i in start...end {
            arr[i] = char
        }
    }
}