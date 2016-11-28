/*249. Group Shifted Strings   QuestionEditorial Solution  My Submissions
Total Accepted: 15547 Total Submissions: 42938 Difficulty: Easy Contributors: Admin
Given a string, we can "shift" each of its letter to its successive letter, for example: "abc" -> "bcd". We can keep "shifting" which forms the sequence:

"abc" -> "bcd" -> ... -> "xyz"
Given a list of strings which contains only lowercase alphabets, group all strings that belong to the same shifting sequence.

For example, given: ["abc", "bcd", "acef", "xyz", "az", "ba", "a", "z"], 
A solution is:

[
  ["abc","bcd","xyz"],
  ["az","ba"],
  ["acef"],
  ["a","z"]
]
Hide Company Tags Google Uber
Hide Tags Hash Table String
Hide Similar Problems (M) Group Anagrams
*/



/* O(mn), m is the length of strings, n is the length of max length string in strings
for each string in strings[], we calculate its gapValue, 
int gap = s.charAt(i)-s.charAt(i-1);
String gapValue += gap<0 ? gap+26 : gap

then push each gapValue into hashMap, key is gapValue, value is ArrayList<> for which string has this gapValue

at the last, for each value in map, we sort its list, and push the list into ret list*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<vector<string>> groupStrings(vector<string>& strings) {
        vector<vector<string>> ret;
        unordered_map<string, vector<string>> mymap;
        
        for(string s:strings){
            string gapValue = "";
            for(int i = 1; i < s.size(); ++i){
                int gap = (int)(s[i] - s[i-1]);
                gapValue += to_string(gap<0 ? gap+26 : gap);
            }
            mymap[gapValue].push_back(s);
        }
        
        for(auto m:mymap){
            vector<string> gapList = m.second;
            sort(gapList.begin(), gapList.end());
            ret.push_back(gapList);
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<List<String>> groupStrings(String[] strings) {
        List<List<String> > ret = new ArrayList<>();
        Map<String, List<String>> mymap = new HashMap<>();
        
        for(String s:strings){
            //find the gapValue of s
            String gapValue = "";
            for(int i = 1; i < s.length(); ++i){
                int gap = s.charAt(i) - s.charAt(i-1);
                gapValue += gap<0 ? gap+26 : gap;
            }
            if(!mymap.containsKey(gapValue)){
                mymap.put(gapValue, new ArrayList<>());
            }
            //push this string into corresppond gap List
            mymap.get(gapValue).add(s);
        }
        
        for(List<String> list:mymap.values()){
            //sort the correspond list
            Collections.sort(list);
            ret.add(list);
        }
        
        return ret;
    }
}
