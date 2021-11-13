/*
Given a list of daily temperatures T, return a list such that, for each day in the input, tells you how many days you would have to wait until a warmer temperature. If there is no future day for which this is possible, put 0 instead.

For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76, 73], your output should be [1, 1, 4, 2, 1, 1, 0, 0].

Note: The length of temperatures will be in the range [1, 30000]. Each temperature will be an integer in the range [30, 100].
*/

/*
Solution 3:
array

Initialize an array answer with the same length as temperatures and all values initially set to 0. Also, initialize an integer hottest = 0 to track the hottest temperature seen so far.

Iterate backwards through the input. At each index currDay, check if the current day is the hottest one seen so far. If it is, update hottest and move on. Otherwise, do the following:

Initialize a variable days = 1 because the next warmer day must be at least one day in the future.
While temperatures[currDay + days] <= temperatures[currDay]:
Add answer[currDay + days] to days. This effectively jumps directly to the next warmer day.
Set answer[currDay] = days.
Return answer.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        let n = temperatures.count
        var answer = Array(repeating: 0, count: n)
        var hottest = 0

        for i in stride(from: n-1, through: 0, by: -1) {
            let temp = temperatures[i]

            if hottest <= temp {
                hottest = temp
                continue
            }

            var days = 1
            while temperatures[i + days] <= temp {
                days += answer[i + days]
            }

            answer[i] = days
        }

        return answer
    }
}

/*
Solution 2:
another coding way of Solution 1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func dailyTemperatures(_ temperatures: [Int]) -> [Int] {
        let n = temperatures.count
        var stack = [(temp: Int, index: Int)]()
        var answer = Array(repeating: 0, count: n)

        for i in stride(from: n-1, through: 0, by: -1) {
            let temp = temperatures[i]

            while !stack.isEmpty, stack.last!.temp <= temp {
                stack.removeLast()
            }

            if !stack.isEmpty {
                answer[i] = stack.last!.index - i
            }
            stack.append((temp, i))
        }

        return answer
    }
}

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