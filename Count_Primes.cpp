/*
Description:

Count the number of prime numbers less than a non-negative number, n.
*/

class Solution {
public:
    int countPrimes(int n) {
        vector<bool> pnumber(n,true);
        pnumber[0]=false;
        pnumber[1]=false;
        for(int i = 0; i < sqrt(n); i++){
            if(pnumber[i]){
                for(int j = i*i; j < n; j+=i)
                    pnumber[j]=false;
            }
        }
        return count(pnumber.begin(),pnumber.end(),true);
    }
};