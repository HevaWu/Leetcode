/*187. Repeated DNA Sequences  QuestionEditorial Solution  My Submissions
Total Accepted: 53567
Total Submissions: 193138
Difficulty: Medium
All DNA is composed of a series of nucleotides abbreviated as A, C, G, and T, for example: "ACGAATTCCG". When studying DNA, it is sometimes useful to identify repeated sequences within the DNA.

Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule.

For example,

Given s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT",

Return:
["AAAAACCCCC", "CCCCCAAAAA"].
Subscribe to see which companies asked this question

Show Tags
*/



/* The last 3 bits are different between ACGT
A is 0x41, C is 0x43, G is 0x47, T is 0x54
A is 0101, C is 0103, G is 0107, T is 0124.
use s[i]&7 to get the last 3 digits

through unordered_map==1 to find if this 10 letters have been appeared before
when the count becomes 2, push this sequence into vector*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        vector<string> ret;
        unordered_map<int, int> mymap;
        
        int bit = 0, i = 0;
        
        while(i < 9){
            bit = (bit << 3) | (s[i++] & 7);
            // bit = bit << 3 | s[i++] & 7;
        }
        
        while(i < s.size()){
            if(mymap[bit = ((bit << 3) & 0x3FFFFFFF) | (s[i++] & 7)]++ == 1){ 
                //mymap[bit = bit << 3 & 0x3FFFFFFF | s[i++] & 7]++ == 1
                ret.push_back(s.substr(i-10,10));
            }
        }
        
        return ret;
    }
};




/*Use two set to store the sequence
myset----check each 10 sequence letter list, if exist, let "repeat" add if
repeat---check if this sequence has already add before, set will not store the repeat sequence*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> findRepeatedDnaSequences(String s) {
        Set myset = new HashSet();
        Set repeat = new HashSet();
        
        for(int i = 0; i + 9 < s.length(); ++i){
            String sub = s.substring(i, i + 10);
            if(!myset.add(sub)){
                repeat.add(sub);
            }
        }
        
        return new ArrayList(repeat);
    }
}