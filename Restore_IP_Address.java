/*93. Restore IP Addresses   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 74198
Total Submissions: 286803
Difficulty: Medium
Contributors: Admin
Given a string containing only digits, restore it by returning all possible valid IP address combinations.

For example:
Given "25525511135",

return ["255.255.11.135", "255.255.111.35"]. (Order does not matter)

Hide Tags Backtracking String
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*DFS
check from the start of the string, once it satisfy the IP rules, keep find the next point
if not, return
check until the last character*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> restoreIpAddresses(String s) {
        List<String> ret = new LinkedList<>();
        restoreIP(s, ret, 0, "", 0);
        return ret;
    }

    public void restoreIP(String s, List<String> ret, int index, String restore, int count){
        if(count > 4) return; //ip address only contain 4 part
        if(count == 4 && index == s.length()) ret.add(restore); //check until the last character, and satisfy the ip rules

        for(int i = 1; i < 4; ++i){
            if(index + i > s.length()) break;
            String str = s.substring(index, index + i);
            if((str.startsWith("0") && str.length()>1) // like 02
                || (i==3 && Integer.parseInt(str) >= 256)) continue;
            restoreIP(s, ret, index+i, restore+str+(count==3?"":"."), count+1);
        }
    }
}

