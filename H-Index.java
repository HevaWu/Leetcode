/*274. H-Index Add to List
Description  Submission  Solutions
Total Accepted: 64094
Total Submissions: 198091
Difficulty: Medium
Contributors: Admin
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






/*

Multiple H value?
It is impossible, the line y=x, should only have one cross point with the bar graph

Solution 1:
O(nlogn) time, O(1) space
1. sort the array in descending order, use Arrays.sort(). Arrays.sort based on comparison sort, which take O(nlogn) time
2. check if the len-1-ith element is larger than i,citation[i] > i. O(n) time

Solution 2:
O(n) time, O(n) space
for example[1,3,2,3,100]
1. count each the paper, using an int[] array to count the number, size+1, if number larger than size, push it into the last element
    k       0 1 2 3 4 5
    count   0 1 1 2 0 1
2. check from the end of the array, check if current sum number is less than i, if it is not, return current i
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int hIndex(int[] citations) {
        if(citations.length == 0) return 0;
        Arrays.sort(citations);
        int i = 0;
        int len = citations.length;
        while(i < len && citations[len-1-i] > i){
            i++;
        }
        return i;
    }
}


//Solution 2
public class Solution {
    public int hIndex(int[] citations) {
        if(citations.length == 0) return 0;
        int len = citations.length;
        int[] temp = new int[len+1];
        for(int citation: citations){ //count the papers
            temp[Math.min(len, citation)]++;
        }

        int i = len;
        for(int sum = temp[len]; i > sum && i >= 0; sum += temp[i]){
            i--;
        }
        return i;
    }
}
