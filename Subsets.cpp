/*78. Subsets  QuestionEditorial Solution  My Submissions
Total Accepted: 113312
Total Submissions: 333944
Difficulty: Medium
Given a set of distinct integers, nums, return all possible subsets.

Note: The solution set must not contain duplicate subsets.

For example,
If nums = [1,2,3], a solution is:

[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]
Subscribe to see which companies asked this question*/



/*umber of subsets for {1 , 2 , 3 } = 2^3 .

therefore , total = 2*2*2 = 2^3 = { { } , {1} , {2} , {3} , {1,2} , {1,3} , {2,3} , {1,2,3} }

Lets assign bits to each outcome  -> First bit to 1 , Second bit to 2 and third bit to 3
Take = 1
Dont take = 0

0) 0 0 0  -> Dont take 3 , Dont take 2 , Dont take 1 = { }
1) 0 0 1  -> Dont take 3 , Dont take 2 ,   take 1       =  {1 }
2) 0 1 0  -> Dont take 3 ,    take 2       , Dont take 1 = { 2 }
3) 0 1 1  -> Dont take 3 ,    take 2       ,      take 1    = { 1 , 2 }
4) 1 0 0  ->    take 3      , Dont take 2  , Dont take 1 = { 3 }
5) 1 0 1  ->    take 3      , Dont take 2  ,     take 1     = { 1 , 3 }
6) 1 1 0  ->    take 3      ,    take 2       , Dont take 1 = { 2 , 3 }
7) 1 1 1  ->    take 3     ,      take 2     ,      take 1     = { 1 , 2 , 3 }

In the above logic ,Insert S[i] only if (j>>i)&1 ==true   { j E { 0,1,2,3,4,5,6,7 }   i = ith element in the input array }

element 1 is inserted only into those places where 1st bit of j is 1
   if( j >> 0 &1 )  ==> for above above eg. this is true for sl.no.( j )= 1 , 3 , 5 , 7

element 2 is inserted only into those places where 2nd bit of j is 1
   if( j >> 1 &1 )  == for above above eg. this is true for sl.no.( j ) = 2 , 3 , 6 , 7

element 3 is inserted only into those places where 3rd bit of j is 1
   if( j >> 2 & 1 )  == for above above eg. this is true for sl.no.( j ) = 4 , 5 , 6 , 7

Time complexity : O(n*2^n) , for every input element loop traverses the whole solution set length i.e. 2^n*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<vector<int>> subsets(vector<int>& nums) {

        sort(nums.begin(), nums.end());
        int nSize = nums.size();
        int subSize = pow (2, nSize);

        vector<vector<int> > sub_set(subSize, vector<int>());
        for(int i = 0; i < nSize; i++){
            for(int j = 0; j < subSize; j++){
                if((j>>i) & 1){
                    sub_set[j].push_back(nums[i]);
                }
            }
        }

        return sub_set;
    }
};
/*class Solution {
public:
vector<vector<int> > subsets(vector<int> &S) {
	vector<vector<int> > res(1, vector<int>());
	sort(S.begin(), S.end());

	for (int i = 0; i < S.size(); i++) {
		int n = res.size();
		for (int j = 0; j < n; j++) {
			res.push_back(res[j]);
			res.back().push_back(S[i]);
		}
	}

	return res;
  }
};*/






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<List<Integer>> subsets(int[] nums) {
        Arrays.sort(nums);
        int nSize = nums.length;
        double subSize = Math.pow(2.0, nSize);
        List<List<Integer> > sub_set = new ArrayList<>();

        for(int i = 0; i < subSize; ++i){
            sub_set.add(new ArrayList<Integer>());
        }

        for(int i = 0; i < nSize; ++i){
            for(int j = 0; j < subSize; ++j){
                if(((j>>i) & 1)!=0){
                    sub_set.get(j).add(nums[i]);
                }
            }
        }

        return sub_set;
    }
}
