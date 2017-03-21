/*245. Shortest Word Distance III
Description  Submission  Solutions  Add to List
Total Accepted: 16586
Total Submissions: 33531
Difficulty: Medium
Contributors: Admin
This is a follow up of Shortest Word Distance. The only difference is now word1 could be the same as word2.

Given a list of words and two words word1 and word2, return the shortest distance between these two words in the list.

word1 and word2 may be the same and they represent two individual words in the list.

For example,
Assume that words = ["practice", "makes", "perfect", "coding", "makes"].

Given word1 = “makes”, word2 = “coding”, return 1.
Given word1 = "makes", word2 = "makes", return 3.

Note:
You may assume word1 and word2 are both in the list.

Hide Company Tags LinkedIn
Hide Tags Array
Hide Similar Problems (E) Shortest Word Distance (M) Shortest Word Distance II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 2 is faster than Solution 1 faster than Solution 3

Solution 1:
init the dis as Integer.MAX_VALUE
init two index as dis and -dis
remember to set the dis and two index as long, to avoid overflow
only use two int to record the index of the last time word1 and word2 appears
then, compare two index
also can set a boolean flag to minimize the compare times

Solution 2:
Same to solution 1, just init dis as len-1, len = words.length;
shorten the compare

Solution 3:
use two list to store the index of word1 and word2
then compare two index, find the minimum distance
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int shortestWordDistance(String[] words, String word1, String word2) {
        if(words.length <= 0 || word1.length()<=0 || word2.length()<=0) return 0;

        long dis = Integer.MAX_VALUE; //set long to avoid overflow
        long w1 = dis; //init two index and the dis
        long w2 = -dis;

        for(int i = 0; i < words.length; ++i){
            if(words[i].equals(word1)){
                w1 = i;
            }
            if(words[i].equals(word2)){
                if(word1.equals(word2)){
                    w1 = w2; //let i1 be the first time this word appears before
                }
                w2 = i;
            }
            //System.out.println(w1 + " " + w2 + " " + Math.abs(w1-w2));
            dis = Math.min(dis, Math.abs(w2-w1));
        }
        return (int)dis;
    }
}


//Solution 2
public class Solution {
    public int shortestWordDistance(String[] words, String word1, String word2) {
        if(words.length<=0 || word1.length()<=0 || word2.length()<=0) return 0;;

        int dis = words.length-1;
        int index = -1;
        for(int i = 0; i < words.length; ++i){
            if(words[i].equals(word1) || words[i].equals(word2)){
                if(index != -1 && ((!words[index].equals(words[i]) || word1.equals(word2)))){
                    dis = Math.min(dis, Math.abs(i-index));
                }
                index = i;
            }
        }
        return dis;
    }
}


//Solution 3
public class Solution {
    public int shortestWordDistance(String[] words, String word1, String word2) {
        if(words.length <= 0 || word1.length() <= 0 || word2.length() <= 0) return -1;

        List<Integer> w1 = new ArrayList<>(); //store the index of word1 appears
        List<Integer> w2 = new ArrayList<>(); //store the index of word2 appears

        for(int i = 0; i < words.length; ++i){
            if(words[i].equals(word1)){ //use .equals() to check if two strings are equal
                w1.add(i);
            }
            if(words[i].equals(word2)){
                w2.add(i);
            }
        }

        int dis = 0; //the return distance
        for(int i1 : w1){
            for(int i2:w2){
                int temp = Math.abs(i1-i2);
                //System.out.println(temp);
                dis = dis!=0 ? (temp!=0 ? Math.min(dis,temp) : dis) : temp;
            }
        }

        return dis;
    }
}

