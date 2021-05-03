/*
Alice and Bob take turns playing a game, with Alice starting first.

Initially, there is a number n on the chalkboard. On each player's turn, that player makes a move consisting of:

Choosing any x with 0 < x < n and n % x == 0.
Replacing the number n on the chalkboard with n - x.
Also, if a player cannot make a move, they lose the game.

Return true if and only if Alice wins the game, assuming both players play optimally.



Example 1:

Input: n = 2
Output: true
Explanation: Alice chooses 1, and Bob has no more moves.
Example 2:

Input: n = 3
Output: false
Explanation: Alice chooses 1, Bob chooses 1, and Alice has no more moves.


Constraints:

1 <= n <= 1000
*/

/*
Solution 1:

if alice lose for N, then alice must win for N+1, since alice can just make n-1
for any odd number, it only has odd factor, after the first move, it will be an even number

if n is odd, pick 1, make it even
if n is even, pick 1, make if odd

fisrt N = 1, Alice lose. then Alice will must win for 2.
if N = 3, since all even number(2) smaller than 3 will leads Alice win, so Alice will lose for 3
3 lose -> 4 win
all even number(2,4) smaller than 5 will leads Alice win, so Alice will lose for 5

Therefore, Alice will always win for even number, lose for odd number.

Time Complexity: O(1)
*/
class Solution {
    func divisorGame(_ n: Int) -> Bool {
        return n % 2 == 0
    }
}