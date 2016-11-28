/*394. Decode String   QuestionEditorial Solution  My Submissions
Total Accepted: 7907 Total Submissions: 20068 Difficulty: Medium Contributors: Admin
Given an encoded string, return it's decoded string.

The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.

You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.

Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

Examples:

s = "3[a]2[bc]", return "aaabcbc".
s = "3[a2[c]]", return "accaccacc".
s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
Hide Company Tags Google
Hide Tags Depth-first Search Stack
*/



/*
approach 1:
use two stacks to store the array
countS --- for store how many times the next string need to repeats
retS --- for store the ret string correspond to countS
each time, search String s, if this char is number, find the count, and push it into countS, if this char is "[", push current ret, and reset ret = ""
if this char is "]", pop the correspond count, and ret, repeat and store it as ret
use StringBuilder to complete the repeat and add operation

approach 2:
recursively do decodeString(String s, int i)
try to find the number, then through recursively use decodeString(s,i) function, 
get the correspond repeat string, 
return the string*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:

    string decodeString(string s) {
        int i = 0;
        return decodeString(s, i);
    }
    
    string decodeString(string s, int& i){ //remember &
        string ret;
        while(i<s.size() && s[i]!=']'){
            if(!isdigit(s[i])){
                ret += s[i++];
            } else {
                //find the count
                int count = 0;
                while(i<s.size() && isdigit(s[i])){
                    count = count*10 + (s[i++]-'0');
                }
                i++;//'['
                string temp = decodeString(s, i);
                i++; //']'
                while(count-- > 0){
                    ret += temp;
                }
            }
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String decodeString(String s) {
        int[] i = new int[1]; //need to pass an array, since we need to change i[0] value through recursive function
        i[0] = 0;
        return decodeString(s, i);
    }
    
    public String decodeString(String s, int[] i){
        // System.out.println("Start decode: " + s + " " + i[0]);
        StringBuilder ret = new StringBuilder();
        while(i[0]<s.length() && s.charAt(i[0])!=']'){
            if(!Character.isDigit(s.charAt(i[0]))){
                //use character.isDigit()
                ret.append(s.charAt(i[0])+"");
                // System.out.println(s.charAt(i)!='');
                i[0]++;
            } else {
                int count = 0;
                while(i[0]<s.length() && Character.isDigit(s.charAt(i[0]))){
                    count = count*10 + (s.charAt(i[0])-'0');
                    i[0]++;
                }
                i[0]++;//'['
                String temp = decodeString(s, i);
                // System.out.println(temp + " " + i[0] + " " + count);
                i[0]++; //']'
                while(count-- > 0){
                    ret.append(temp);
                }
            }
        }
        // System.out.println("End decode" + ret.toString());
        return ret.toString();
    }
}




public class Solution {
    public String decodeString(String s) {
        String ret = "";
        Stack<Integer> countS = new Stack<>();
        Stack<String> retS = new Stack<>();
        
        int i = 0;
        while(i<s.length()){
            //find the count value
            if(Character.isDigit(s.charAt(i))){
                int count = 0;
                while(i<s.length() && Character.isDigit(s.charAt(i))){
                    count = count*10 + (s.charAt(i)-'0');
                    i++;
                }
                countS.push(count);
            } else if(s.charAt(i)=='['){
                retS.push(ret);
                ret = "";
                i++;
            } else if(s.charAt(i)==']'){
                //use stringbuilder to append pre string
                StringBuilder temp = new StringBuilder(retS.pop());
                int t = countS.pop();
                while(t-- > 0){
                    temp.append(ret);
                }
                ret = temp.toString();
                i++;
            } else {
                //find the ret value
                ret += s.charAt(i);
                i++; //remember i++
            }
        }
        return ret;
    }
}
