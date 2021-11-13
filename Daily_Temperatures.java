/*
Given a list of daily temperatures T, return a list such that, for each day in the input, tells you how many days you would have to wait until a warmer temperature. If there is no future day for which this is possible, put 0 instead.

For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76, 73], your output should be [1, 1, 4, 2, 1, 1, 0, 0].

Note: The length of temperatures will be in the range [1, 30000]. Each temperature will be an integer in the range [30, 100].
*/

/*
Solution 2:
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
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int hottest = 0;
        int[] answer = new int[n];

        for(int i = n-1; i >= 0; i--) {
            int temp = temperatures[i];

            if (temp >= hottest) {
                hottest = temp;
                continue;
            }

            int days = 1;
            while (temperatures[i + days] <= temp) {
                days += answer[i + days];
            }
            answer[i] = days;
        }
        return answer;
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
    public int[] dailyTemperatures(int[] temperatures) {
        int n = temperatures.length;
        int[] answer = new int[n];
        Stack<TempNode> stack = new Stack<>();

        for(int i = n-1; i >= 0; i--) {
            int temp = temperatures[i];
            while (!stack.isEmpty() && stack.peek().temp <= temp) {
                stack.pop();
            }

            if (!stack.isEmpty()) {
                answer[i] = stack.peek().index - i;
            }
            stack.push(new TempNode(temp, i));
        }
        return answer;
    }
}

class TempNode {
    int temp;
    int index;
    TempNode(int temp, int index) {
        this.temp = temp;
        this.index = index;
    }
}