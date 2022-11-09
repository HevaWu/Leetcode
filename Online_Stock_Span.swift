/*
Design an algorithm that collects daily price quotes for some stock and returns the span of that stock's price for the current day.

The span of the stock's price today is defined as the maximum number of consecutive days (starting from today and going backward) for which the stock price was less than or equal to today's price.

For example, if the price of a stock over the next 7 days were [100,80,60,70,60,75,85], then the stock spans would be [1,1,1,2,1,4,6].
Implement the StockSpanner class:

StockSpanner() Initializes the object of the class.
int next(int price) Returns the span of the stock's price given that today's price is price.


Example 1:

Input
["StockSpanner", "next", "next", "next", "next", "next", "next", "next"]
[[], [100], [80], [60], [70], [60], [75], [85]]
Output
[null, 1, 1, 1, 2, 1, 4, 6]

Explanation
StockSpanner stockSpanner = new StockSpanner();
stockSpanner.next(100); // return 1
stockSpanner.next(80);  // return 1
stockSpanner.next(60);  // return 1
stockSpanner.next(70);  // return 2
stockSpanner.next(60);  // return 1
stockSpanner.next(75);  // return 4, because the last 4 prices (including today's price of 75) were less than or equal to today's price.
stockSpanner.next(85);  // return 6


Constraints:

1 <= price <= 105
At most 104 calls will be made to next.
*/

/*
Solution 1:
use stack to keep store stocks by
[price, days less than or equal to price]

when price coming, compare it with stack current value
sum up all days that price less than it, then push it to stack

take [[], [100], [80], [60], [70], [60], [75], [85]] as an example
[100] -> stack is [[100, 1]]
[80] -> [[100, 1], [80, 1]]
[60] -> [[100, 1], [80, 1], [60, 1]]
[70] -> [[100, 1], [80, 1], [70, 2]]
[60] -> [[100, 1], [80, 1], [70, 2], [60, 1]]
[75] -> [[100, 1], [80, 1], [75, 4]]
[85] -> [[100, 1], [85, 6]]

Time Complexity: O(current stack size)
Space Complexity: O(stack size)
*/
class StockSpanner {
    // [price, days less than or equal to price]
    // always keep stack as sorted price
    var stack = [[Int]]()
    init() {

    }

    func next(_ price: Int) -> Int {
        var day = 1
        // put price by checking and adding all small
        // price days
        while !stack.isEmpty, stack.last![0] <= price {
            let cur = stack.removeLast()
            day += cur[1]
        }

        stack.append([price, day])
        return day
    }
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * let obj = StockSpanner()
 * let ret_1: Int = obj.next(price)
 */
