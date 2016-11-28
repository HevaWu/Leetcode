/*271. Encode and Decode Strings  QuestionEditorial Solution  My Submissions
Total Accepted: 11929 Total Submissions: 43846 Difficulty: Medium
Design an algorithm to encode a list of strings to a string. The encoded string is then sent over the network and is decoded back to the original list of strings.

Machine 1 (sender) has the function:

string encode(vector<string> strs) {
  // ... your code
  return encoded_string;
}
Machine 2 (receiver) has the function:
vector<string> decode(string s) {
  //... your code
  return strs;
}
So Machine 1 does:

string encoded_string = encode(strs);
and Machine 2 does:

vector<string> strs2 = decode(encoded_string);
strs2 in Machine 2 should be the same as strs in Machine 1.

Implement the encode and decode methods.

Note:
The string may contain any possible characters out of 256 valid ascii characters. Your algorithm should be generalized enough to work on any possible characters.
Do not use class member/global/static variables to store states. Your encode and decode algorithms should be stateless.
Do not rely on any library method such as eval or serialize methods. You should implement your own encode/decode algorithm.
Hide Company Tags Google
Hide Tags String
Hide Similar Problems (E) Count and Say (H) Serialize and Deserialize Binary Tree
*/



/*encode str.length + $ + str*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Codec {
public:

    // Encodes a list of strings to a single string.
    string encode(vector<string>& strs) {
        string ret = "";
        for(string s:strs){
            ret += to_string(s.size())+"$"+s;
        }
        return ret;
    }

    // Decodes a single string to a list of strings.
    vector<string> decode(string s) {
        vector<string> ret;
        int index = 0;
        while(index < s.size()){
            int mark = s.find_first_of("$",index);
            int len = stoi(s.substr(index,mark-index));
            index = mark+1;
            ret.push_back(s.substr(index,len));
            index += len;
        }
        return ret;
    }
};

// Your Codec object will be instantiated and called as such:
// Codec codec;
// codec.decode(codec.encode(strs));




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Codec {

    // Encodes a list of strings to a single string.
    public String encode(List<String> strs) {
        StringBuilder ret = new StringBuilder();
        for(String s:strs){
            ret.append(s.length()).append("$").append(s);
        }
        return ret.toString();
    }

    // Decodes a single string to a list of strings.
    public List<String> decode(String s) {
        List<String> ret = new ArrayList<>();
        int index = 0;
        while(index < s.length()){
            int mark = s.indexOf("$",index);
            int len = Integer.valueOf(s.substring(index,mark));//do not forget integer.valueof()
            index = mark+1;
            ret.add(s.substring(index,index+len));//string.substring(fromindex,endindex)
            index += len;
        }
        return ret;
    }
}

// Your Codec object will be instantiated and called as such:
// Codec codec = new Codec();
// codec.decode(codec.encode(strs));
