/*
The count-and-say sequence is the sequence of integers beginning as follows:
1, 11, 21, 1211, 111221, ...

1 is read off as "one 1" or 11.
11 is read off as "two 1s" or 21.
21 is read off as "one 2, then one 1" or 1211.
Given an integer n, generate the nth sequence.

Note: The sequence of integers will be represented as a string.
*/

/*
Solution 1
generate from n-1 string

Time Complexity: O(2^n)
Space Complexity: O(2^(n-1))
*/
class Solution {
 public:
  string countAndSay(int n) {
    if (n == 1) {
      return "1";
    }
    string pre = countAndSay(n - 1);
    char cur = '*';
    int count = 0;
    string seq = "";
    for (int i = 0; i < pre.size(); i++) {
      if (pre[i] == cur) {
        count += 1;
      } else {
        if (cur != '*') {
          seq += to_string(count);
          seq += cur;
        }
        cur = pre[i];
        count = 1;
      }
    }
    if (cur != '*') {
      seq += to_string(count);
      seq += cur;
    }
    return seq;
  }
};

class Solution {
 public:
  string countAndSay(int n) {
    string res = "1";

    while (--n) {
      string cur = "";
      for (int i = 0; i < res.size(); i++) {
        int count = 1;
        while (i + 1 < res.size() && res[i] == res[i + 1]) {
          count++;
          i++;
        }
        cur += to_string(count) + res[i];
      }
      res = cur;
    }

    return res;
  }
};
