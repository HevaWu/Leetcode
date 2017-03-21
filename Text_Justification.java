/*68. Text Justification Add to List
Description  Submission  Solutions
Total Accepted: 50056
Total Submissions: 271991
Difficulty: Hard
Contributors: Admin
Given an array of words and a length L, format the text such that each line has exactly L characters and is fully (left and right) justified.

You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly L characters.

Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line do not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.

For the last line of text, it should be left justified and no extra space is inserted between words.

For example,
words: ["This", "is", "an", "example", "of", "text", "justification."]
L: 16.

Return the formatted lines as:
[
   "This    is    an",
   "example  of text",
   "justification.  "
]
Note: Each word is guaranteed not to exceed L in length.

click to show corner cases.

Corner Cases:
A line other than the last line might contain only one word. What should you do in this case?
In this case, that line should be left-justified.
Hide Company Tags LinkedIn Airbnb Facebook
Hide Tags String
 */






/*
String
each time check if current line has enough word, if it is do addSpace()
after add, update the line and strlist
addSpace() function to help add space in one line
addLastLine() function to add the space in the last line
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> fullJustify(String[] words, int maxWidth) {
        List<String> text = new ArrayList<>();
        if(words.length == 0) return text;

        int line = 0; //current char in this line
        List<String> strlist = new ArrayList<>(); //current words in this line
        for(String word: words){
            int temp = line + word.length();
            if(temp > maxWidth){
                //current strlist is full
                //combine them together
                //count how many space we need to add in this line
                String cur = addSpace(strlist, line, maxWidth);
                //System.out.println(strlist.size());

                //add to the text list
                text.add(cur);

                //reset this line
                //add this word to next line
                temp = word.length();
                strlist = new ArrayList<>();
            }
            //System.out.println("temp: " + temp);
            line = temp + 1; //there is a space between two words
            strlist.add(word);
        }

        //add the last line
        String cur = addLastLine(strlist, line, maxWidth);
        text.add(cur);

        return text;
    }

    public String addSpace(List<String> strlist, int line, int maxWidth){
        //System.out.println(line + " " + strlist.get(0));
        int space = maxWidth - (line-strlist.size());
        int strsize = strlist.size()-1;
        if(strsize == 0){
            //only one word in this line
            String cur = "" + strlist.get(0);
            for(int i = 0; i < space; ++i){
                cur = cur + " ";
            }
            return cur;
        }

        int eachadd = space / strsize; //add between each words
        int moreadd = space % strsize; //the left part need to add more space

        String strspace = "";
        for(int i = 0; i < eachadd; ++i){
            strspace += " ";
        }

        String cur = "";
        for(int i = 0; i < strlist.size()-1; ++i){
            String s = strlist.get(i);
            if(moreadd > 0){
                cur = cur + s + strspace + " ";
                moreadd--;
            } else {
                cur = cur + s + strspace;
            }
        }
        //add the last word
        cur = cur + strlist.get(strlist.size()-1);
        return cur;
    }

    public String addLastLine(List<String> strlist, int line, int maxWidth){
        int space = maxWidth - line;
        if(strlist.size()==1 && line==maxWidth+1) return strlist.get(0);

        String strspace = "";
        for(int i = 0; i < space; ++i){
            strspace += " ";
        }

        String cur = "";
        for(String s : strlist){
            cur = cur + s + " ";
        }

        cur = cur + strspace;
        return cur;
    }
}
