// Alice has a hand of cards, given as an array of integers.

// Now she wants to rearrange the cards into groups so that each group is size W, and consists of W consecutive cards.

// Return true if and only if she can.

 

// Example 1:

// Input: hand = [1,2,3,6,2,3,4,7,8], W = 3
// Output: true
// Explanation: Alice's hand can be rearranged as [1,2,3],[2,3,4],[6,7,8].
// Example 2:

// Input: hand = [1,2,3,4,5], W = 4
// Output: false
// Explanation: Alice's hand can't be rearranged into groups of 4.
 

// Note:

// 1 <= hand.length <= 10000
// 0 <= hand[i] <= 10^9
// 1 <= W <= hand.length

// Solution 1: brute force
// Count number of different cards to a map c
// Loop from the smallest card number.
// Everytime we meet a new card i, we cut off i - i + W - 1 from the counter.
// 
// Time complexity:  O(MlogM + MW), where M is the number of different cards.
class Solution {
    func isNStraightHand(_ hand: [Int], _ W: Int) -> Bool {        
        var map = [Int: Int]()
        for i in hand {
            map[i, default: 0] += 1
        }
        var key = map.keys.sorted()
        
        var index = 0
        for i in key {
            if map[i]! > 0 {
                for j in stride(from: W-1, through: 1, by: -1) {
                    map[i+j, default: 0] -= map[i]!
                    if map[i+j]! < 0 {
                        return false
                    }
                }
            }
        }
        return true
    }
}

// Solution 2: 
// Count number of different cards to a map c
// Cur represent current open straight groups.
// In a deque start, we record the number of opened a straight group.
// Loop from the smallest card number.
// For example, hand = [1,2,3,2,3,4], W = 3
// We meet one 1:
// opened = 0, we open a new straight groups starting at 1, push (1,1) to start.
// We meet two 2:
// opened = 1, we need open another straight groups starting at 1, push (2,1) to start.
// We meet two 3:
// opened = 2, it match current opened groups.
// We open one group at 1, now we close it. opened = opened - 1 = 1
// We meet one 4:
// opened = 1, it match current opened groups.
// We open one group at 2, now we close it. opened = opened - 1 = 0
// return if no more open groups.
// 
// Time complexity: O(mlogm)
// Space complexity: O(m)
class Solution {
    func isNStraightHand(_ hand: [Int], _ W: Int) -> Bool {
        var map = [Int: Int]()
        for i in hand {
            map[i, default: 0] += 1
        }
        let key = map.keys.sorted()
        
        var queue = [Int]()
        var last = -1
        var open = 0
        
        for i in key {
            if (open > map[i]!) || (open > 0 && i > last + 1) {
                return false
            }
            queue.insert(map[i]! - open, at: 0)
            last = i
            open = map[i]!
            if queue.count == W {
                open -= queue.removeLast()
            }
        }
        return open == 0
    }
}