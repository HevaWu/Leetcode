// Forward declaration of isBadVersion API.
bool isBadVersion(int version);

class Solution {
public:
    int firstBadVersion(int n) {
        int low, high, mid;
        low = 1;
        high = n;
        while(low < high)
        {
            mid = low + (high-low)/2; //mid should use this function to calculate, unless it will cause "time limited"
            if(!isBadVersion(mid)) low = mid+1;
            else high= mid; //if the mid is not the bad version, low should change into (mid+1)
        }
        return low;
        
        /*
        int low, high, mid;
        low = 1;
        high = n;
        while(low < high)
        {
            mid = (low + high)/2;
            if(isBadVersion(mid)) high = mid;
            else low = mid+1; //if the mid is not the bad version, low should change into (mid+1)
        }
        return high;
        */
    }
};