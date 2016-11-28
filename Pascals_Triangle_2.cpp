/*
Given an index k, return the kth row of the Pascal's triangle.

For example, given k = 3,
Return [1,3,3,1].

Note:
Could you optimize your algorithm to use only O(k) extra space?
*/

class Solution {
public:
    vector<int> getRow(int rowIndex) {
        vector<int> ntriangle(rowIndex+1, 0);  //remember +1
        ntriangle[0]=1; //initialize the first element
        for(int i = 1; i < rowIndex+1; i++){
            for(int j = i; j>=1; j--)   //j--
                ntriangle[j] += ntriangle[j-1];
        }
        return ntriangle;
    }
};