/*
Given a list of daily temperatures T, return a list such that, for each day in
the input, tells you how many days you would have to wait until a warmer
temperature. If there is no future day for which this is possible, put 0
instead.

For example, given the list of temperatures T = [73, 74, 75, 71, 69, 72, 76,
73], your output should be [1, 1, 4, 2, 1, 1, 0, 0].

Note: The length of temperatures will be in the range [1, 30000]. Each
temperature will be an integer in the range [30, 100].
*/

/*
Solution 1:
Stack

prepare stack: [(index, temperature)]
start from end of T array.
if stack is not empty, try to find if there is any element is larger than
current

- Time Complexity: O(n), each index gets pushed and popped at most once from the
stack
- Space Complexity: O(W), w is the number of allowed values for T[i]. Size of
stack is bounded as it represents stictly increasing temperatures
*/
struct TempNode {
  int t;
  int index;
  TempNode(int t, int index) : t(t), index(index) {}
};

class Solution {
 public:
  vector<int> dailyTemperatures(vector<int>& temperatures) {
    stack<TempNode> mystack;
    int n = temperatures.size();
    vector<int> res(n, 0);

    for (int i = n - 1; i >= 0; i--) {
      while (mystack.size() > 0 && mystack.top().t <= temperatures[i]) {
        mystack.pop();
      }
      int value = mystack.size() > 0 ? mystack.top().index - i : 0;
      res[i] = value;
      mystack.push(TempNode(temperatures[i], i));
    }
    return res;
  }
};
