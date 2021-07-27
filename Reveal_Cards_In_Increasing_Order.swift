/*
In a deck of cards, every card has a unique integer.  You can order the deck in any order you want.

Initially, all the cards start face down (unrevealed) in one deck.

Now, you do the following steps repeatedly, until all cards are revealed:

Take the top card of the deck, reveal it, and take it out of the deck.
If there are still cards in the deck, put the next top card of the deck at the bottom of the deck.
If there are still unrevealed cards, go back to step 1.  Otherwise, stop.
Return an ordering of the deck that would reveal the cards in increasing order.

The first entry in the answer is considered to be the top of the deck.



Example 1:

Input: [17,13,11,2,3,5,7]
Output: [2,13,3,11,5,17,7]
Explanation:
We get the deck in the order [17,13,11,2,3,5,7] (this order doesn't matter), and reorder it.
After reordering, the deck starts as [2,13,3,11,5,17,7], where 2 is the top of the deck.
We reveal 2, and move 13 to the bottom.  The deck is now [3,11,5,17,7,13].
We reveal 3, and move 11 to the bottom.  The deck is now [5,17,7,13,11].
We reveal 5, and move 17 to the bottom.  The deck is now [7,13,11,17].
We reveal 7, and move 13 to the bottom.  The deck is now [11,17,13].
We reveal 11, and move 17 to the bottom.  The deck is now [13,17].
We reveal 13, and move 17 to the bottom.  The deck is now [17].
We reveal 17.
Since all the cards revealed are in increasing order, the answer is correct.


Note:

1 <= deck.length <= 1000
1 <= deck[i] <= 10^6
deck[i] != deck[j] for all i != j
*/

/*
Solution 1:
get indexArr first.

indexArr: order of revealing\
0, 1, 2, 3, 4, 5, 6
-> 0, 2, 3, 4, 5, 6, 1
-> 0, 2, 4, 5, 6, 1, 3
-> 0, 2, 4, 6, 1, 3, 5
-> 0, 2, 4, 6, 3, 5, 1
-> 0, 2, 4, 6, 3, 1, 5

with this order, we map the sorted array element
if sorted array is
   2, 3, 5, 7, 11, 13, 17
   0, 1, 2, 3,  4,  5,  6
-> 0, 2, 4, 6,  3,  1,  5

put 2 at 0th index
put 3 at 2nd index
put 5 at 4th index
put 7 at 6th index
put 11 at 3rd index
put 13 at 1st index
put 17 at 5th index

[2,13,3,11,5,17,7]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func deckRevealedIncreasing(_ deck: [Int]) -> [Int] {
        var deck = deck.sorted()
        let n = deck.count

        // 0,2,4,6,3,1,5
        let indexArr = getGameOrder(n)
        var reveal = Array(repeating: 0, count: n)
        for i in 0..<n {
            reveal[indexArr[i]] = deck[i]
        }
        return reveal
    }

    // 0...(n-1)
    // 0..<6
    // return 0,2,4,6,3,1,5
    func getGameOrder(_ n: Int) -> [Int] {
        var arr = Array(0..<n)
        guard n > 2 else { return arr }
        for i in 0..<(n-2) {
            let next = arr[i+1]
            arr.remove(at: i+1)
            arr.append(next)
        }
        return arr
    }
}