/*
A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

Every adjacent pair of words differs by a single letter.
Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
sk == endWord
Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].



Example 1:

Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
Explanation: There are 2 shortest transformation sequences:
"hit" -> "hot" -> "dot" -> "dog" -> "cog"
"hit" -> "hot" -> "lot" -> "log" -> "cog"
Example 2:

Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
Output: []
Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.


Constraints:

1 <= beginWord.length <= 5
endWord.length == beginWord.length
1 <= wordList.length <= 1000
wordList[i].length == beginWord.length
beginWord, endWord, and wordList[i] consist of lowercase English letters.
beginWord != endWord
All the words in wordList are unique.
*/


/*The solution contains two steps 1 Use BFS to construct a graph. 2. Use DFS to construct the paths from end to start.Both solutions got AC within 1s.

The first step BFS is quite important. I summarized three tricks

Using a MAP to store the min ladder of each word, or use a SET to store the words visited in current ladder, when the current ladder was completed, delete the visited words from unvisited. That's why I have two similar solutions.
Use Character iteration to find all possible paths. Do not compare one word to all the other words and check if they only differ by one character.
One word is allowed to be inserted into the queue only ONCE.*/

public
class Solution
{
private
    Map<String, List<String>> mymap;
private
    List<List<String>> ret;

public
    List<List<String>> findLadders(String beginWord, String endWord, Set<String> wordList)
    {
        ret = new ArrayList<List<String>>();
        if (wordList.size() == 0)
        {
            return ret;
        }

        int min = Integer.MAX_VALUE;

        Queue<String> q = new ArrayDeque<String>();
        q.add(beginWord);

        mymap = new HashMap<String, List<String>>();

        Map<String, Integer> ladder = new HashMap<String, Integer>();
        for (String w : wordList)
        {
            ladder.put(w, Integer.MAX_VALUE);
        }
        ladder.put(beginWord, 0);

        wordList.add(endWord);
        while (!q.isEmpty())
        { // BFS:Dijisktra search
            String word = q.poll();
            int step = ladder.get(word) + 1; // step indicates how many steps are needed to travel to one word
            if (step > min)
                break;

            for (int i = 0; i < word.length(); i++)
            {
                StringBuilder sb = new StringBuilder(word);
                for (char ch = 'a'; ch <= 'z'; ch++)
                {
                    sb.setCharAt(i, ch);
                    String newWord = sb.toString();
                    if (ladder.containsKey(newWord))
                    {
                        if (step > ladder.get(newWord))
                        {
                            continue;
                        }
                        else if (step < ladder.get(newWord))
                        {
                            q.add(newWord);
                            ladder.put(newWord, step);
                        }
                        else
                            ; // If one word already appeared in one ladder
                        // do not insert the same word inside the queue twice, otherwise it gets TLE

                        if (mymap.containsKey(newWord))
                        {
                            mymap.get(newWord).add(word);
                        }
                        else
                        {
                            List<String> newList = new LinkedList<String>();
                            newList.add(word);
                            mymap.put(newWord, newList);
                            // mymap.put(newWord, new LinkedList<String>(Arrays.asList(new String[]{word})));
                        }

                        if (newWord.equals(endWord))
                        {
                            min = step;
                        }
                    } // end if wordList contains newWord
                }     // end if iteration from 'a' to 'z'
            }         // end if iteration from the first to the last
        }

        LinkedList<String> res = new LinkedList<String>();
        backTrace(endWord, beginWord, res);

        return ret;
    }

private
    void backTrace(String word, String start, List<String> list)
    {
        if (word.equals(start))
        {
            list.add(0, start);
            ret.add(new ArrayList<String>(list));
            list.remove(0);
            return;
        }
        list.add(0, word);
        if (mymap.get(word) != null)
        {
            for (String s : mymap.get(word))
            {
                backTrace(s, start, list);
            }
        }
        list.remove(0);
    }
}