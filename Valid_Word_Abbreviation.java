/*408. Valid Word Abbreviation
Description  Submission  Solutions  Add to List
Total Accepted: 7193
Total Submissions: 26219
Difficulty: Easy
Contributors: Admin
Given a non-empty string s and an abbreviation abbr, return whether the string matches with the given abbreviation.

A string such as "word" contains only the following valid abbreviations:

["word", "1ord", "w1rd", "wo1d", "wor1", "2rd", "w2d", "wo2", "1o1d", "1or1", "w1r1", "1o2", "2r1", "3d", "w3", "4"]
Notice that only the above abbreviations are valid abbreviations of the string "word". Any other string is not a valid abbreviation of "word".

Note:
Assume s contains only lowercase letters and abbr contains only lowercase letters and digits.

Example 1:
Given s = "internationalization", abbr = "i12iz4n":

Return true.
Example 2:
Given s = "apple", abbr = "a2e":

Return false.
Hide Company Tags Google
Hide Tags String
Hide Similar Problems (H) Minimum Unique Word Abbreviation
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
set 2 index to check the two string
ai for abbr, wi for word
need to pay attention:
1. once current char is a number, we need to control its index for not out of limit
	and if the first char number is 0, should return false
	like: a 01 return false
2. once jump the number, need to update the index of word
3. at the end, check if the two index is at the end of the string
	if not, return false
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//short the code, increase the time
public class Solution {
    public boolean validWordAbbreviation(String word, String abbr) {
        if(word.length()==0 && abbr.length()==0) return true;
        if(word.length()==0 || abbr.length()==0) return false;

        int ai=0; //index of abbr
        int wi=0; //index of word
        while(ai < abbr.length() && wi < word.length()){
            if(word.charAt(wi) == abbr.charAt(ai)){
                ai++; //update ai and wi here
                wi++;
                continue;
            }
            //not equal. should be number
            if(abbr.charAt(ai)<='0' || abbr.charAt(ai)>'9'){//the first index is 0, eg: a 01 --- false
                return false;
            }
            int tempa = ai;
            while(ai < abbr.length() && abbr.charAt(ai)>='0' && abbr.charAt(ai)<='9'){ //need to pay attention at the index of abbr, ai
                ai++;
            }
            //System.out.println(tempa + " " + ai);
            int alen = Integer.parseInt(abbr.substring(tempa, ai));
            wi += alen; //remember update wi
        }

        return ai==abbr.length() && wi==word.length();
    }
}


public class Solution {
    public boolean validWordAbbreviation(String word, String abbr) {
        if(word.length()==0 && abbr.length()==0) return true;
        if(word.length()==0 || abbr.length()==0) return false;

        int ai=0; //index of abbr
        int wi=0; //index of word
        while(ai < abbr.length() && wi < word.length()){
            if(abbr.charAt(ai)>='0' && abbr.charAt(ai)<='9'){ //is number
                int tempa = ai;
                while(ai < abbr.length() && abbr.charAt(ai)>='0' && abbr.charAt(ai)<='9'){ //need to pay attention at the index of abbr, ai
                    ai++;
                }
                int alen = Integer.parseInt(abbr.substring(tempa, ai));
                if(abbr.charAt(tempa) == '0'){//the first index is 0, eg: a 01 --- false
                    return false;
                }
                wi += alen; //remember update wi
            } else { //is character
                if(word.charAt(wi) != abbr.charAt(ai)){
                    //System.out.println(wi + " " + ai);
                    return false;
                } else {//this char is equal
                    ai++;
                    wi++;
                }
            }
        }

        if(ai==abbr.length() && wi==word.length()){
            return true;
        } else {
            return false;
        }

    }
}

