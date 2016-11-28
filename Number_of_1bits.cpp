/*
Write a function that takes an unsigned integer and returns the number of ’1' bits it has (also known as the Hamming weight).

For example, the 32-bit integer ’11' has binary representation 00000000000000000000000000001011, so the function should return 3.
*/



/*through n &= n-1, to delete one bit*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int hammingWeight(uint32_t n) {
        int nbits = 0;
        while(n){
            n &= n-1;  //Each time of "n &= n - 1", we delete one '1' from n.
            nbits++;
        }
        return nbits;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    // you need to treat n as an unsigned value
    public int hammingWeight(int n) {
        int ret = 0;
        while(n!=0){
            n &= n-1;
            ret++;
        }
        
        return ret;
    }
}