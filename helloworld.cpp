#include <iostream>
#include <vector>
#include <string>

using namespace std;

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

int main() {
    Solution s1;
    vector<int> msg = s1.getRow(3);
    for (const int& word : msg) {
        cout << word << " ";
    }
    cout << endl;
}