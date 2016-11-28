/*418. Sentence Screen Fitting   QuestionEditorial Solution  My Submissions
Total Accepted: 921 Total Submissions: 3975 Difficulty: Medium Contributors: Admin
Given a rows x cols screen and a sentence represented by a list of words, find how many times the given sentence can be fitted on the screen.

Note:

A word cannot be split into two lines.
The order of words in the sentence must remain unchanged.
Two consecutive words in a line must be separated by a single space.
Total words in the sentence won't exceed 100.
Length of each word won't exceed 10.
1 ≤ rows, cols ≤ 20,000.
Example 1:

Input:
rows = 2, cols = 8, sentence = ["hello", "world"]

Output: 
1

Explanation:
hello---
world---

The character '-' signifies an empty space on the screen.
Example 2:

Input:
rows = 3, cols = 6, sentence = ["a", "bcd", "e"]

Output: 
2

Explanation:
a-bcd- 
e-a---
bcd-e-

The character '-' signifies an empty space on the screen.
Example 3:

Input:
rows = 4, cols = 5, sentence = ["I", "had", "apple", "pie"]

Output: 
1

Explanation:
I-had
apple
pie-I
had--

The character '-' signifies an empty space on the screen.
Hide Company Tags Google
Hide Tags Dynamic Programming
*/



/*
use an index to mark each time the sentence end
first, we join the sentence by seperate each word in a space
abc de f 
then we start to count the index
eg: 
"abc de"
"f abc "
"de f  "
"abc de"

"abc de f abc de f abc de f ..." // index=0
 012345                          // index=index+cols+adjustment=0+6+1=7 (1 space removed in screen string)
        012345                   // index=7+6+0=13
              012345             // index=13+6-1=18 (1 space added)
                   012345        // index=18+6+1=25 (1 space added)
                          012345
after end of repeating, return index/s.length
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int wordsTyping(vector<string>& sentence, int rows, int cols) {
        string s;
        for(string sen:sentence){
            s += sen + " ";
        }
        int index = 0;
        int len = s.size();
        for(int i = 0; i < rows; ++i){
            index += cols;
            if(s[index % len] == ' '){
                index++;
            } else {
                while(index>0 && s[(index-1)%len]!=' '){ //use index -1 
                    index--;
                }
            }
        }
        return index/len;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int wordsTyping(String[] sentence, int rows, int cols) {
        String str = String.join(" ",sentence) + " "; //join the words in sentence
        int index = 0; //mark each first element in row
        int len = str.length();
        for(int i = 0; i < rows; ++i){
            //for each row find its first start index
            index += cols;
            if(str.charAt(index%len) == ' '){
                index++;
            } else {
                //str[index%len] is not ' '
                while(index>0 && str.charAt((index-1)%len)!=' '){
                     //check index-1
                     index--;
                }
            }
        }
        return index/len; //count the appearence for this sentence 
    }
}
