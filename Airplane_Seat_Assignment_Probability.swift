/*
n passengers board an airplane with exactly n seats. The first passenger has lost the ticket and picks a seat randomly. But after that, the rest of passengers will:

Take their own seat if it is still available,
Pick other seats randomly when they find their seat occupied
What is the probability that the n-th person can get his own seat?



Example 1:

Input: n = 1
Output: 1.00000
Explanation: The first person can only get the first seat.
Example 2:

Input: n = 2
Output: 0.50000
Explanation: The second person has a probability of 0.5 to get the second seat (when first person gets the first seat).


Constraints:

1 <= n <= 10^5
*/

/*
Solution 1:

f(n) = (1 / n + (n - 2) / n) * f(n - 1)

f(n) = 1/n                                    -> 1st person picks his own seat
    + 1/n * 0                                 -> 1st person picks last one's seat
	+ (n-2)/n * (                            ->1st person picks one of seat from 2nd to (n-1)th
        1/(n-2) * f(n-1)                   -> 1st person pick 2nd's seat
        1/(n-2) * f(n-2)                  -> 1st person pick 3rd's seat
        ......
        1/(n-2) * f(2)                     -> 1st person pick (n-1)th's seat
	)

=> f(n) = 1/n * ( f(n-1) + f(n-2) + f(n-3) + ... + f(1) )

If the 1st one picks i's seat, we know that
- Anyone between 1st and ith, gets their own seats

Then, when we come to person i, it becomes a sub-problem

- i takes a random seat
- the rest follow the same rule
- from i to last (inclusive), there are n - (i-1) seats left
- so it's a f(n-i+1)

when n > 2,
f(n) = 1/n * ( f(n-1) + f(n-2) + ... + f(1) )
f(n-1) = 1/(n-1) * (f(n-2) + f(n-3) + ... + f(1))

because, the 2nd equation requires n-1 > 1

=>

n * f(n) = f(n-1) + f(n-2) + f(n-3) + ... + f(1)
(n-1) * f(n-1) = f(n-2) + f(n-3) + ... + f(1)

=>

n * f(n) - (n-1)*f(n-1) = f(n-1)

=> n * f(n) = n * f(n-1)
=> f(n) = f(n-1) , when n > 2

f(1) =1
f(2) = 1/2
From here
f(n) = f(n-1) = ... = f(2) = 1/2

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func nthPersonGetsNthSeat(_ n: Int) -> Double {
        return n == 1 ? 1 : 0.5
    }
}