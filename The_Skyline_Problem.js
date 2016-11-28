/*
A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Now suppose you are given the locations and height of all the buildings as shown on a cityscape photo (Figure A), write a program to output the skyline formed by these buildings collectively (Figure B).

 Buildings  Skyline Contour
The geometric information of each building is represented by a triplet of integers [Li, Ri, Hi], where Li and Ri are the x coordinates of the left and right edge of the ith building, respectively, and Hi is its height. It is guaranteed that 0 ≤ Li, Ri ≤ INT_MAX, 0 < Hi ≤ INT_MAX, and Ri - Li > 0. You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

For instance, the dimensions of all buildings in Figure A are recorded as: [ [2 9 10], [3 7 15], [5 12 12], [15 20 10], [19 24 8] ] .

The output is a list of "key points" (red dots in Figure B) in the format of [ [x1,y1], [x2, y2], [x3, y3], ... ] that uniquely defines a skyline. A key point is the left endpoint of a horizontal line segment. Note that the last key point, where the rightmost building ends, is merely used to mark the termination of the skyline, and always has zero height. Also, the ground in between any two adjacent buildings should be considered part of the skyline contour.

For instance, the skyline in Figure B should be represented as:[ [2 10], [3 15], [7 12], [12 0], [15 10], [20 8], [24, 0] ].

Notes:

The number of buildings in any input list is guaranteed to be in the range [0, 10000].
The input list is already sorted in ascending order by the left x position Li.
The output list must be sorted by the x position.
There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...[2 3], [4 5], [7 5], [11 5], [12 7]...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...[2 3], [4 5], [12 7], ...]

Credits:
Special thanks to @stellari for adding this problem, creating these two awesome images and all test cases.

Hide Company Tags Microsoft Google Facebook Twitter Yelp
Hide Tags Binary Indexed Tree Segment Tree Heap Divide and Conquer
*/






///////////////////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<pair<int, int>> getSkyline(vector<vector<int>>& buildings) {
        multimap<int, int> heights;
        for(const vector<int> &b:buildings){
            heights.emplace(b[0],b[2]);
            heights.emplace(b[1],-b[2]);
        }
        
        multiset<int> hset = {0};
        vector<pair<int, int> > heightMap;
        int x = -1;
        int y = 0;
        for(const pair<int,int> h:heights){
            if((x>=0) && (h.first!=x) && (heightMap.empty() || (heightMap.rbegin()->second != y))){
                heightMap.emplace_back(x,y);
            }
            
            if(h.second>=0){
                hset.insert(h.second);
            }else{
                hset.erase(hset.find(-h.second));
            }
            
            x = h.first;
            y = *hset.rbegin();
        }
        
        if(!heightMap.empty()){
           heightMap.emplace_back(x,0);
        }
        
        return heightMap;
    }
};





/*use heights = arraylist<int[]> to store the buildings
push into the list, set the left side as negative one, set the right side as positive one
sort the heights according to their position
for each h in heights
    if it is the left side of the building, push it into heightMap
    else minus the correspond building key
    use heightMap.firstKey() to get the curr height
    if it is not equal to pre one, add it into skyLine list

*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<int[]> getSkyline(int[][] buildings) {
        List<int[]> skyLine = new ArrayList<>();
        if(buildings==null ||buildings.length==0 || buildings[0].length==0) return skyLine;

        List<int[]> heights = new ArrayList<>();
        for(int[] b:buildings){
            heights.add(new int[]{b[0],-b[2]}); //set new int[]
            heights.add(new int[]{b[1],b[2]});
        }
        
        Collections.sort(heights, (a,b) -> (a[0]==b[0] ? a[1]-b[1] : a[0]-b[0]));
        //TreeMap can sorted the elements
        //key is the height of building's left side
        //value is how many buildings has this left side 
        TreeMap<Integer,Integer> heightMap = new TreeMap<>(Collections.reverseOrder());
        heightMap.put(0,1);
        
        int preHeight = 0;
        for(int[] h:heights){
            if(h[1] < 0){
                //this is the left side of one building
                Integer cur = heightMap.get(-h[1]);  //use Integer not int, we need to compare it with null
                cur = (cur==null ? 1 : cur+1);
                heightMap.put(-h[1],cur);
            } else {
                //this is the right side of the building
                Integer cur = heightMap.get(h[1]);
                if(cur==1){//only one building has this value, remove this building from map
                    heightMap.remove(h[1]);
                } else {
                    heightMap.put(h[1], cur-1);
                }
            }
            int curHeight = heightMap.firstKey(); //use firstKey() to get the lowest key in heightMap, since we initialize reverseOrder(), this return the largest key
            if(curHeight != preHeight){
                skyLine.add(new int[]{h[0],curHeight});
                preHeight = curHeight;
            }
        }
        
        return skyLine;
    }
}