/*274. H-Index  QuestionEditorial Solution  My Submissions
Total Accepted: 46137
Total Submissions: 149096
Difficulty: Medium
Given an array of citations (each citation is a non-negative integer) of a researcher, write a function to compute the researcher's h-index.

According to the definition of h-index on Wikipedia: "A scientist has index h if h of his/her N papers have at least h citations each, and the other N − h papers have no more than h citations each."

For example, given citations = [3, 0, 6, 1, 5], which means the researcher has 5 papers in total and each of them had received 3, 0, 6, 1, 5 citations respectively. Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, his h-index is 3.

Note: If there are several possible values for h, the maximum one is taken as the h-index.

Hint:

An easy approach is to sort the array first.
What are the possible values of h-index?
A faster approach is to use extra space.
Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Bloomberg Google Facebook
Hide Tags Hash Table Sort
Hide Similar Problems (M) H-Index II
*/



/*O(n) time
1. use a array count to get the amount of the certifications of each paper
2. according to the defination of h-index, index i is his h-index if the summation of all elements from counts[i] to counts[citations.size] is no less than k. 
scanning from citations.size to 0

count[citations.size()+1]
if one papers contains larger than citations.size() citations, count[citation.size()]++
else count[cur]++

then scanning count[] from citations.size() to 0
if cur += count[i] is larger than i, return current i, which is h-index
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int hIndex(vector<int>& citations) {
        int len = citations.size();
        vector<int> count(len+1);
        
        for(int c:citations){
            if(c>len){
                count[len]++;
            } else {
                count[c]++;
            }
        }
        
        int total = 0;
        for(int i = len; i >= 0; --i){
            total += count[i];
            if(total >= i){
                return i;
            }
        }
        
        return 0;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int hIndex(int[] citations) {
        if(citations.length==0) return 0;
        int len = citations.length;
        int[] count = new int[len+1];
        
        //check each paper
        for(int c:citations){
            if(c>len){
                count[len]++;
            } else {
                count[c]++;
            }
        }
        
        int total = 0;
        for(int i = len; i >= 0; --i){
            total += count[i];
            if(total >= i){
                //this paper is h-index
                return i;
            }
        }
        
        return 0;
    }
}
