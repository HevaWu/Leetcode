/*
Given a list of daily temperatures T, return a list such that, for each day in the input, tells you how many days you would have to wait until a warmer temperature. If there is no future day for which this is possible, put 0 instead.

For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76, 73], your output should be [1, 1, 4, 2, 1, 1, 0, 0].

Note: The length of temperatures will be in the range [1, 30000]. Each temperature will be an integer in the range [30, 100].
*/


/*
Solution 1:
Stack

prepare stack: [(index, temperature)]
start from end of T array.
if stack is not empty, try to find if there is any element is larger than current

- Time Complexity: O(n), each index gets pushed and popped at most once from the stack
- Space Complexity: O(W), w is the number of allowed values for T[i]. Size of stack is bounded as it represents stictly increasing temperatures
*/
class Solution {
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        let n = T.count
        var res = Array(repeating: 0, count: n)
        
        // (index, temperature)
        var stack = [(Int, Int)]()
        for i in stride(from: n-1, through: 0, by: -1) {
            var temp = 0
            while !stack.isEmpty {
                guard let next = stack.last else { break }
                if next.1 > T[i] {
                    temp += (next.0 - i)
                    break
                } else {
                    stack.removeLast()
                }
            }
            stack.append((i, T[i]))
            res[i] = temp
        }
        return res
    }
}