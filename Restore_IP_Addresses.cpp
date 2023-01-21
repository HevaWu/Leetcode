/*93. Restore IP Addresses   Add to List QuestionEditorial Solution  My
Submissions Total Accepted: 74198 Total Submissions: 286803 Difficulty: Medium
Contributors: Admin
Given a string containing only digits, restore it by returning all possible
valid IP address combinations.

For example:
Given "25525511135",

return ["255.255.11.135", "255.255.111.35"]. (Order does not matter)

Hide Tags Backtracking String
*/

/*DFS
check from the start of the string, once it satisfy the IP rules, keep find the
next point if not, return check until the last character*/
class Solution {
 private:
  vector<string> res;

 public:
  vector<string> restoreIpAddresses(string s) {
    restoreIP(s, 0, "", 0);
    return res;
  }

  void restoreIP(string s, int index, string restore, int count) {
    if (count > 4) return;  // ip address only contain 4 part
    if (count == 4 && index == s.size())
      res.push_back(
          restore);  // check until the last character, and satisfy the ip rules

    for (int i = 1; i < 4; ++i) {
      if (index + i > s.length()) break;
      string str = s.substr(index, i);
      if ((str[0] == '0' && str.size() > 1)  // like 02
          || (i == 3 && stoi(str) >= 256))
        continue;
      restoreIP(s, index + i, restore + str + (count == 3 ? "" : "."),
                count + 1);
    }
  }
};
