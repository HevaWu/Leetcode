/*346. Moving Average from Data Stream  QuestionEditorial Solution  My Submissions
Total Accepted: 9570 Total Submissions: 17066 Difficulty: Easy
Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.

For example,
MovingAverage m = new MovingAverage(3);
m.next(1) = 1
m.next(10) = (1 + 10) / 2
m.next(3) = (1 + 10 + 3) / 3
m.next(5) = (10 + 3 + 5) / 3
Hide Company Tags Google
Hide Tags Design Queue
*/



/*O(1) time
keep the sum so for and update the sum by replacing the oldest number 
set a new sum for the size element
set a arr array which size is size user give
set a n for current array size
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class MovingAverage {
    private:
    vector<int> arr; //store the cur val which size is size
    int index; //index for next ele
    int n;  //number of cur ele
    long sum; //the sum of ele in arr
    
public:
    /** Initialize your data structure here. */
    MovingAverage(int size) {
        vector<int> newArr(size);
        arr = newArr;
        index = 0;
        sum = 0;
        n = 0;
    }
    
    double next(int val) {
        if(n<arr.size()) n++;
        sum -= arr[index]; //delete the oldest value
        sum += val;
        arr[index] = val;
        index = (index+1)%arr.size();
        
        return (double)sum / n;//double just for sum
    }
};

/**
 * Your MovingAverage object will be instantiated and called as such:
 * MovingAverage obj = new MovingAverage(size);
 * double param_1 = obj.next(val);
 */




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class MovingAverage {
    private int[] arr;  //store the cur val which size is size
    private int n;      //number of cur ele
    private int index; //index for next ele
    private int sum;  //the sum of ele in arr
    
    /** Initialize your data structure here. */
    public MovingAverage(int size) {
        arr = new int[size];
        int n = 0;
        int index = 0;
        int sum = 0;
    }
    
    public double next(int val) {
        if(n<arr.length) n++;
        sum -= arr[index]; //delete the oldest value
        sum += val;
        arr[index] = val;
        index = (index+1) % arr.length;
        return (double)sum / n; //double just for sum
    }
}

/**
 * Your MovingAverage object will be instantiated and called as such:
 * MovingAverage obj = new MovingAverage(size);
 * double param_1 = obj.next(val);
 */
