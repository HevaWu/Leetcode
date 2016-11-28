/*288. Unique Word Abbreviation  QuestionEditorial Solution  My Submissions
Total Accepted: 15926
Total Submissions: 102353
Difficulty: Easy
An abbreviation of a word follows the form <first letter><number><last letter>. Below are some examples of word abbreviations:

a) it                      --> it    (no abbreviation)

     1
b) d|o|g                   --> d1g

              1    1  1
     1---5----0----5--8
c) i|nternationalizatio|n  --> i18n

              1
     1---5----0
d) l|ocalizatio|n          --> l10n
Assume you have a dictionary and given a word, find whether its abbreviation is unique in the dictionary. A word's abbreviation is unique if no other word from the dictionary has the same abbreviation.

Example: 
Given dictionary = [ "deer", "door", "cake", "card" ]

isUnique("dear") -> false
isUnique("cart") -> true
isUnique("cane") -> false
isUnique("make") -> true
Hide Company Tags Google
Hide Tags Hash Table Design
Hide Similar Problems (E) Two Sum III - Data structure design (M) Generalized Abbreviation
*/



/*Use unordered_map to store the unique word 
for isUnique, just check if this abbreviation exist*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class ValidWordAbbr {
    private:
    unordered_map<string, unordered_set<string>> mymap;
public:
    ValidWordAbbr(vector<string> &dictionary) {
        for(string s:dictionary){
            int n = s.size();
            string newString = s[0] + to_string(n) + s[n-1];
            mymap[newString].insert(s);
        }
    }

    bool isUnique(string word) {
        int n = word.size();
        string newString = word[0] + to_string(n) + word[n-1];
        return mymap[newString].count(word) == mymap[newString].size();
    }
};


// Your ValidWordAbbr object will be instantiated and called as such:
// ValidWordAbbr vwa(dictionary);
// vwa.isUnique("hello");
// vwa.isUnique("anotherWord");




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class ValidWordAbbr {
    private HashMap<String, HashSet<String>> mymap;

    public ValidWordAbbr(String[] dictionary) {
        mymap = new HashMap<String, HashSet<String>>();
        for(String s:dictionary){
            String newString = getKey(s);
            //if s is already inserted, check if it is equal
            if(!mymap.containsKey(newString)){
                 mymap.put(newString, new HashSet<String>());
            }
            mymap.get(newString).add(s);
            // System.out.println(mymap.get(newString) + " " + newString);
        }
    }

    public boolean isUnique(String word) {
        String newString = getKey(word);
        // System.out.println(newString + " " + mymap.containsKey(newString));
        return !mymap.containsKey(newString) ||
            (mymap.get(newString).size()==1 && mymap.get(newString).contains(word));
    }
    
    public String getKey(String s){
        if(s.length() <=2 ) return s;
        int n = s.length();
        return s.charAt(0) + Integer.toString(n-2) + s.charAt(n-1);
    }
}


// Your ValidWordAbbr object will be instantiated and called as such:
// ValidWordAbbr vwa = new ValidWordAbbr(dictionary);
// vwa.isUnique("Word");
// vwa.isUnique("anotherWord");
