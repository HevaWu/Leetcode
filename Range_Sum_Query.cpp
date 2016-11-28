class NumArray {
public:
    NumArray(vector<int> &nums) : psum(nums.size()+1, 0) {
        partial_sum( nums.begin(), nums.end(), psum.begin()+1);
    }

    int sumRange(int i, int j) {
        return psum[j+1] - psum[i];
    }
private:
    vector<int> psum;    
};




class NumArray {
public:
    NumArray(vector<int> &nums):snums(nums.size()+1,0) {
        partial_sum(nums.begin(),nums.end(),snums.begin()+1);
    }

    int sumRange(int i, int j) {
        return snums[j+1] - snums[i];
    }
private:
    vector<int> snums;    
};


// Your NumArray object will be instantiated and called as such:
// NumArray numArray(nums);
// numArray.sumRange(0, 1);
// numArray.sumRange(1, 2);
