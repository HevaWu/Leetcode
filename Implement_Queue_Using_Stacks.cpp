/*232. Implement Queue using Stacks  QuestionEditorial Solution  My Submissions
Total Accepted: 53710
Total Submissions: 155620
Difficulty: Easy
Implement the following operations of a queue using stacks.

push(x) -- Push element x to the back of queue.
pop() -- Removes the element from in front of queue.
peek() -- Get the front element.
empty() -- Return whether the queue is empty.
Notes:
You must use only standard operations of a stack -- which means only push to
top, peek/pop from top, size, and is empty operations are valid. Depending on
your language, stack may not be supported natively. You may simulate a stack by
using a list or deque (double-ended queue), as long as you use only standard
operations of a stack. You may assume that all operations are valid (for
example, no pop or peek operations will be called on an empty queue). Subscribe
to see which companies asked this question

Show Tags
Show Similar Problems
*/

class Queue {
  stack<int> stinput, stoutput;

 public:
  // Push element x to the back of queue.
  void push(int x) { stinput.push(x); }

  // Removes the element from in front of queue.
  void pop(void) {
    peek();
    stoutput.pop();
  }

  // Get the front element.
  int peek(void) {
    if (stoutput.empty()) {
      while (stinput.size()) {
        stoutput.push(stinput.top());
        stinput.pop();
      }
    }
    return stoutput.top();
  }

  // Return whether the queue is empty.
  bool empty(void) { return stinput.empty() && stoutput.empty(); }
};
