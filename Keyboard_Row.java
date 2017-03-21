/*500. Keyboard Row
Description  Submission  Solutions  Add to List
Total Accepted: 4027
Total Submissions: 6549
Difficulty: Easy
Contributors: Admin
Given a List of words, return the words that can be typed using letters of alphabet on only one row's of American keyboard like the image below.


American keyboard


Example 1:
Input: ["Hello", "Alaska", "Dad", "Peace"]
Output: ["Alaska", "Dad"]
Note:
You may use one character in the keyboard more than once.
You may assume the input string will only contain letters of alphabet.
Hide Company Tags Mathworks
Hide Tags Hash Table
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 1 faster than Solution 2 faster than Solution 3

Solution 1:
use map to store the character in the keyboard
key is char, value is the row index

Solution 2:
use a map to store the character in the keyboard
key is the row index, value is the character in this row
for each word, we check if the letter in this word are in one line
if not, break this word loop,
if it is in one line, add it to the return list
at the end, transfer the return list to the string array

Solution 3:
the slowest solution
just one line
use Stream.of().filter(s->s.toLowerCase().matches()) to find the word
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public String[] findWords(String[] words) {
        if(words.length <= 0) return new String[0];

        String[] keyboard = new String[]{"qwertyuiop","asdfghjkl","zxcvbnm"};
        Map<Character, Integer> mymap = new HashMap<>();

        //put the keyboard into mymap
        for(int i = 0; i < keyboard.length; ++i){
            for(char c: keyboard[i].toCharArray()){
                mymap.put(c,i);
            }
        }

        List<String> mylist = new ArrayList<>();
        for(String word: words){
            int row = mymap.get(word.toLowerCase().charAt(0));  //use word.toLowerCase() to conver the upper letter
            int i = 1;
            for(char c: word.toLowerCase().toCharArray()){
                if(mymap.get(c) != row){
                    row = -1;
                    break;
                }
            }
            if(row != -1){  //check if we scan this word to the end
                mylist.add(word);
            }
        }

        return mylist.toArray(new String[mylist.size()]);
    }
}



//Solution 2
public class Solution {
    public String[] findWords(String[] words) {
        if(words.length<=0) return new String[0];

        Map<Integer, List<Character>> mymap = new HashMap<>();
        //use Arrays.asList() to init a ArrayList
        mymap.put(0, new ArrayList<Character>(Arrays.asList('q','w','e','r','t','y','u','i','o','p')));
        mymap.put(1, new ArrayList<Character>(Arrays.asList('a','s','d','f','g','h','j','k','l')));
        mymap.put(2, new ArrayList<Character>(Arrays.asList('z','x','c','v','b','n','m')));

        List<String> ret = new ArrayList<>();
        for(String word: words){
            int row = -1; //init it should be at -1 row
            int i = 0;
            for(i = 0; i < word.length(); ++i){
                char c = word.charAt(i);
                if(c >='A' && c<='Z'){
                    c = (char)(c+32);//convert upper letter to lower letter
                } //also can use word.toLowerCase() to conver the upper letter
                if(row==-1){
                    if(mymap.get(0).contains(c)){
                        row = 0;
                    } else if(mymap.get(1).contains(c)){
                        row = 1;
                    } else if(mymap.get(2).contains(c)){
                        row = 2;
                    } else {
                        break;
                    }
                    //System.out.println(row);
                } else {
                    if(mymap.get(row).contains(c)){
                        continue;
                    } else {
                        break;
                    }
                }
            }
            if(i == word.length()){ //this letter in this word is in a line
                ret.add(word);
            }
        }

        String[] arr = new String[ret.size()];
        ret.toArray(arr);
        return arr;
    }
}


//Solution 3
public class Solution {
    public String[] findWords(String[] words) {
        return Stream.of(words).filter(s -> s.toLowerCase().matches("[qwertyuiop]*|[asdfghjkl]*|[zxcvbnm]*")).toArray(String[]::new);
    }
}

