/*269. Alien Dictionary  QuestionEditorial Solution  My Submissions
Total Accepted: 14270 Total Submissions: 58658 Difficulty: Hard
There is a new alien language which uses the latin alphabet. However, the order among letters are unknown to you. You receive a list of words from the dictionary, where words are sorted lexicographically by the rules of this new language. Derive the order of letters in this language.

For example,
Given the following words in dictionary,

[
  "wrt",
  "wrf",
  "er",
  "ett",
  "rftt"
]
The correct order is: "wertf".

Note:
You may assume all letters are in lowercase.
If the order is invalid, return an empty string.
There may be multiple valid order of letters, return any one of them is fine.
Hide Company Tags Google Airbnb Facebook Twitter Snapchat Pocket Gems
Hide Tags Graph Topological Sort
Hide Similar Problems (M) Course Schedule II
*/



/*
1. build map for each char in all words
	HashMap<char, Set<char>>mymap --- store the set of next char after char
	HashMap<char, Integer>mymapSize --- store the size of next char after char
	w: 0, r: 0, t: 0, f: 0, e: 0
2. find first different letters between two words
	wrt->wrf --- t->f
	wrf->er  --- w->e
	er->ett  --- r->t
	ett->rftt --- e->r

	remember wrtkf->wrt  return ""
	wrt->wrtkf  break
3. build graph
	use queue to build graph,at the first push all 0 points in queue
	w->e->f->t->f
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
	string alienOrder(vector<string>& words) {
		string ret = "";
		if (words.size() == 0) return ret;

		//set all letters in the words 0
		unordered_map<char, set<char>> mymap; //store the set of next char after char
		unordered_map<char, int> mymapSize;   //store how many next chars after char
		for (string s : words) {
			for (char c : s) {
				mymapSize.emplace(c, 0);
			}
		}

		//find the set of next char after cur c
		for (int i = 0; i < words.size() - 1; ++i) {
			string cur = words[i];
			string next = words[i + 1];
			int len = max(cur.size(), next.size());
			for (int j = 0; j < len; ++j) {
				if (j < cur.size() && j < next.size()) {
					if (cur[j] != next[j]) {
						set<char> newSet;
						if (mymap.find(cur[j]) != mymap.end()) {
							newSet = mymap[cur[j]];
						}
						if (newSet.find(next[j]) == newSet.end()) {
							newSet.insert(next[j]);
							mymap[cur[j]].emplace(newSet);
							mymapSize[cur[j]]++;
						}
						break;
					}
				}
				else if (j >= cur.size()) {
					break;
				} else if (j >= next.size()) {
					return "";
				}
			}
		}

		//build the graph
		queue<char> Q;
		vector<char> keys;
		for (auto kv : mymapSize) {
			keys.push_back(kv.first);
		}

		for (char c : keys) {
			if (mymapSize[c] == 0) {
				Q.push(c);
			}
		}

		while (!Q.empty()) {
			char c = Q.front();
			Q.pop();
			ret += c;
			if (mymap.find(c) != mymap.end()) {
				for (char c1 : mymap[c]) {
					mymapSize[c1]--;
					if (mymapSize[c1] == 0) {
						Q.push(c1);
					}
				}
			}
		}

		return ret.size() == mymap.size() ? ret : "";
	}
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {

	public String alienOrder(String[] words) {

		String ret = "";
		if (words == null || words.length == 0) return ret;

		Map<Character, Set<Character>> mymap = new HashMap<>(); //store the set of chars after char
		Map<Character, Integer> mymapSize = new HashMap<>(); //store the size of set chars after char

		//set all char in words to 0
		for (String s : words) {
			for (char c : s.toCharArray()) {
				mymapSize.put(c, 0);
			}
		}

		//find the first different char between two words
		for (int i = 0; i < words.length - 1; ++i) {
			String cur = words[i];
			String next = words[i + 1];
			int len = Math.max(cur.length(), next.length()); //find the shorter len
			for (int j = 0; j < len; ++j) {
				if (j < cur.length() && j < next.length()) {
					char c1 = cur.charAt(j);  //use charAt() get character
					char c2 = next.charAt(j);
					if (c1 != c2) {
						//find this char
						Set<Character> newSet = new HashSet<>();
						if (mymap.containsKey(c1)) {
							//check if the set contains next[j]
							newSet = mymap.get(c1);
						}
						if (!newSet.contains(c2)) {
							//if not contains, add this char
							newSet.add(c2);
							mymap.put(c1, newSet);
							mymapSize.put(c2, mymapSize.get(c2) + 1); //update "c2" size,
						}
						break; //since we have already find the character
					}
				} else if (j >= next.length()) { //wrtkh  -> wrt  return ""
					return "";
				} else if (j >= cur.length()) { //wrt-> wrtkh  reutrn "wrtkh"
					continue;
				}
			}
		}

		//build the graph
		Queue<Character> Q = new LinkedList<>();
		for (char c : mymapSize.keySet()) { //use keySet()  to get key
			if (mymapSize.get(c) == 0) {
				//find all 0 points
				Q.add(c);
			}
		}

		while (!Q.isEmpty()) {
			char c = Q.poll();
			ret += c;
			// System.out.println(ret);
			if (mymap.containsKey(c)) {
				for (char c2 : mymap.get(c)) {
					mymapSize.put(c2, mymapSize.get(c2) - 1);
					if (mymapSize.get(c2) == 0) {
						Q.add(c2);
					}
				}
			}
		}

		return (ret.length() != mymapSize.size()) ? "" : ret;

	}

}
