/*133. Clone Graph  QuestionEditorial Solution  My Submissions
Total Accepted: 75994
Total Submissions: 305146
Difficulty: Medium
Clone an undirected graph. Each node in the graph contains a label and a list of its neighbors.


OJ's undirected graph serialization:
Nodes are labeled uniquely.

We use # as a separator for each node, and , as a separator for node label and each neighbor of the node.
As an example, consider the serialized graph {0,1,2#1,2#2,2}.

The graph has a total of three nodes, and therefore contains three parts as separated by #.

First node is labeled as 0. Connect node 0 to both nodes 1 and 2.
Second node is labeled as 1. Connect node 1 to node 2.
Third node is labeled as 2. Connect node 2 to node 2 (itself), thus forming a self-cycle.
Visually, the graph looks like the following:

       1
      / \
     /   \
    0 --- 2
         / \
         \_/
Hide Company Tags Pocket Gems Google Uber Facebook
Hide Tags Depth-first Search Breadth-first Search Graph
Hide Similar Problems (H) Copy List with Random Pointer
*/




/*
use hashmap<Integer, UndirectedgraphNode> to store the map
in this map, key is node.label, value is node
push each node into the map,
    if this node already been pushed ,return the neighbors of this node
    else 
        create a new node for this node
        and copy the node.neighbors to this new node*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for undirected graph.
 * struct UndirectedGraphNode {
 *     int label;
 *     vector<UndirectedGraphNode *> neighbors;
 *     UndirectedGraphNode(int x) : label(x) {};
 * };
 */
class Solution {
private:
    unordered_map<UndirectedGraphNode*, UndirectedGraphNode*> mymap;
public:
    UndirectedGraphNode *cloneGraph(UndirectedGraphNode *node) {
        if(!node){
            return node;
        }
        
        if(mymap.find(node) == mymap.end()){
            mymap[node] = new UndirectedGraphNode(node->label);
            for(auto x:node->neighbors){
                (mymap[node]->neighbors).push_back(cloneGraph(x));
            }
        }
        return mymap[node];
    }
};







/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for undirected graph.
 * class UndirectedGraphNode {
 *     int label;
 *     List<UndirectedGraphNode> neighbors;
 *     UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 * };
 */
public class Solution {
    private HashMap<Integer, UndirectedGraphNode> mymap = new HashMap<>();
    
    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        if(node == null){
            return null;
        }
        
        //check if mymap containsKey, remember "containsKey", not "contains"
        if(mymap.containsKey(node.label)){
            return mymap.get(node.label);
        }
        
        UndirectedGraphNode clonenode = new UndirectedGraphNode(node.label);
        mymap.put(clonenode.label, clonenode);
        for(UndirectedGraphNode n:node.neighbors){
            clonenode.neighbors.add(cloneGraph(n)); //remember clone graph n
        }
        
        return clonenode;
    }
}