/*406. Queue Reconstruction by Height   QuestionEditorial Solution  My Submissions
Total Accepted: 5571 Total Submissions: 10222 Difficulty: Medium Contributors: Admin
Suppose you have a random list of people standing in a queue. Each person is described by a pair of integers (h, k), where h is the height of the person and k is the number of people in front of this person who have a height greater than or equal to h. Write an algorithm to reconstruct the queue.

Note:
The number of people is less than 1,100.

Example

Input:
[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]

Output:
[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]
Hide Company Tags Google
Hide Tags Greedy
Hide Similar Problems (H) Count of Smaller Numbers After Self
*/



/*
sort according to the first value, then according to the second value
after sorting, insert each element in people, by adding this element at ele.second position

Pick out tallest group of people and sort them in a subarray (S). Since there's no other groups of people taller than them, therefore each guy's index will be just as same as his k value.
For 2nd tallest group (and the rest), insert each one of them into (S) by k value. So on and so forth.
E.g.
input: [[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]
subarray after step 1: [[7,0], [7,1]]
subarray after step 2: [[7,0], [6,1], [7,1]]*/

class Solution {
public:
    vector<pair<int, int>> reconstructQueue(vector<pair<int, int>>& people) {
        sort(people.begin(), people.end(), [](pair<int,int> p1, pair<int,int> p2){
            return p1.first > p2.first
                || (p1.first==p2.first && p1.second < p2.second);
        });

        vector<pair<int,int> > ret;
        for(auto p:people){
            ret.insert(ret.begin() + p.second, p);
        }
        return ret;
    }
};
