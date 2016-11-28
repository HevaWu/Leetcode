/*
You are climbing a stair case. It takes n steps to reach to the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
*/

class Solution {
public:
    int climbStairs(int n) {
        if(n==0 || n==1 || n==2) return n;
        
        vector<int> nway(n,0);  //set this to contral the distinct ways to climb to the top
        nway[0]=1;
        nway[1]=2;
        for(int i = 2; i < nway.size(); i++){
            nway[i] = nway[i-1]+nway[i-2];
        }
        return nway[n-1];
    }
};