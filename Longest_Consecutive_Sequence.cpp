/*
128. Longest Consecutive Sequence  QuestionEditorial Solution  My Submissions
Total Accepted: 74092
Total Submissions: 220568
Difficulty: Hard
Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

For example,
Given [100, 4, 200, 1, 3, 2],
The longest consecutive elements sequence is [1, 2, 3, 4]. Return its length: 4.

Your algorithm should run in O(n) complexity.

Hide Company Tags Google Facebook
Hide Tags Array Union Find
Hide Similar Problems (M) Binary Tree Longest Consecutive Sequence
*/



/*O(n) complexity
Whenever a new element n is inserted into the map, do two things:

See if n - 1 and n + 1 exist in the map, and if so, it means there is an existing sequence next to n. Variables left and right will be the length of those two sequences, while 0 means there is no sequence and n will be the boundary point later. Store (left + right + 1) as the associated value to key n into the map.
Use left and right to locate the other end of the sequences to the left and right of n respectively, and replace the value with the new length.
Everything inside the for loop is O(1) so the total time is O(n).
*/

class Solution {
public:
    int longestConsecutive(vector<int>& nums) {
        int ret = 0;
        map<int, int> mymap;
        for(int n:nums){
            if(mymap.find(n)==mymap.end()){
                int left = (mymap.find(n-1)==mymap.end()) ? 0 : mymap[n-1];
                int right = (mymap.find(n+1)==mymap.end()) ? 0: mymap[n+1];
                int sum = left + right + 1;
                mymap[n] = sum;

                ret = max(ret, sum);

                mymap[n-left] = sum;
                mymap[n+right] = sum;
            }else{
                continue;
            }
        }
        return ret;
    }
};

