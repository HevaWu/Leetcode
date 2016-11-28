/*398. Random Pick Index   QuestionEditorial Solution  My Submissions
Total Accepted: 6955 Total Submissions: 18950 Difficulty: Medium Contributors: Admin
Given an array of integers with possible duplicates, randomly output the index of a given target number. You can assume that the given target number must exist in the array.

Note:
The array size can be very large. Solution that uses too much extra space will not pass the judge.

Example:

int[] nums = new int[] {1,2,3,3,3};
Solution solution = new Solution(nums);

// pick(3) should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
solution.pick(3);

// pick(1) should return 0. Since in the array only nums[0] is equal to 1.
solution.pick(1);
Subscribe to see which companies asked this question

Hide Tags Reservoir Sampling
Hide Similar Problems (M) Linked List Random Node
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*init the Solution class
use count variable to control the random value
judge random.nextInt(count++) to randomly return the ret value*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
	//Reservoir Sampling
    private int[] nums;
    private Random rand;

    public Solution(int[] nums) {
        this.nums = nums;
        this.rand = new Random(); //init rand
    }
    
    public int pick(int target) {
        int count = 0;
        int ret = -1; //if no target in the nums[], return -1
        for(int i = 0; i < nums.length; ++i){
            if(nums[i] != target){
                continue;
            }
            if(rand.nextInt(++count)==0){ //++count, since nextInt(0) is not exist
                //if == target, push into random list
                ret = i;
            }
        }
        return ret;
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(nums);
 * int param_1 = obj.pick(target);
 */




public class Solution {
    //use HashMap<>()
    private Map<Integer,List<Integer>> mymap = new HashMap<>();
    
    public Solution(int[] nums) {
        for(int i = 0; i < nums.length; ++i){
            if(!mymap.containsKey(nums[i])){
                mymap.put(nums[i], new ArrayList<>());
            }
            mymap.get(nums[i]).add(i);
        }
    }
    
    public int pick(int target) {
        int ret = -1; //if no target in the nums[], return -1
        Random rand = new Random();
        if(mymap.containsKey(target)){
            int size = mymap.get(target).size();
            ret = mymap.get(target).get(rand.nextInt(size));
        }
        return ret;
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * Solution obj = new Solution(nums);
 * int param_1 = obj.pick(target);
 */