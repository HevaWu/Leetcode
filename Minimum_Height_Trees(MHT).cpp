/*310. Minimum Height Trees  QuestionEditorial Solution  My Submissions
Total Accepted: 17816
Total Submissions: 64292
Difficulty: Medium
For a undirected graph with tree characteristics, we can choose any node as the root. The result graph is then a rooted tree. Among all possible rooted trees, those with minimum height are called minimum height trees (MHTs). Given such a graph, write a function to find all the MHTs and return a list of their root labels.

Format
The graph contains n nodes which are labeled from 0 to n - 1. You will be given the number n and a list of undirected edges (each edge is a pair of labels).

You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.

Example 1:

Given n = 4, edges = [[1, 0], [1, 2], [1, 3]]

        0
        |
        1
       / \
      2   3
return [1]

Example 2:

Given n = 6, edges = [[0, 3], [1, 3], [2, 3], [4, 3], [5, 4]]

     0  1  2
      \ | /
        3
        |
        4
        |
        5
return [3, 4]

Hint:

How many MHTs can a graph have at most?
Note:

(1) According to the definition of tree on Wikipedia: “a tree is an undirected graph in which any two vertices are connected by exactly one path. In other words, any connected graph without simple cycles is a tree.”

(2) The height of a rooted tree is the number of edges on the longest downward path between the root and a leaf.

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.*/




/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    struct Node{
        unordered_set<int> brother;
        bool isLeaf() const{return brother.size()==1;}
    };
    
    vector<int> findMinHeightTrees(int n, vector<pair<int, int>>& edges) {
        vector<int> temp1;
        vector<int> temp2;
        vector<int>* pt1 = &temp1;
        vector<int>* pt2 = &temp2;
        
        if(n==1){
            temp1.push_back(0);
            return temp1;
        }
        
        vector<Node> nodes(n);
        for(auto e:edges){//build the tree
            nodes[e.first].brother.insert(e.second);
            nodes[e.second].brother.insert(e.first);
        }
        
        for(int i = 0; i < n; ++i){//find all leaves
            if(nodes[i].isLeaf()){
                pt1->push_back(i);
            }
        }
        
        while(1){
            for(int i : *pt1){
                for(auto o:nodes[i].brother){
                    nodes[o].brother.erase(i);
                    if(nodes[o].isLeaf()){
                        pt2->push_back(o);
                    }
                }
            }
            if(pt2->empty()){
                return *pt1;
            }
            pt1->clear();
            swap(pt1,pt2);
        }
    }
};






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {

    public List<Integer> findMinHeightTrees(int n, int[][] edges) {
        if(n == 1){
            return Collections.singletonList(0); //singletonList-----returns an immutable set containing only the specified object
        }
        
        List<Set<Integer> > brother = new ArrayList<>(n);
        for(int i = 0; i < n; ++i){
            brother.add(new HashSet<>());
        }
        
        for(int[] e:edges){
            brother.get(e[0]).add(e[1]);
            brother.get(e[1]).add(e[0]);
        }
        
        List<Integer> leaves = new ArrayList<>();
        for(int i = 0; i < n; ++i){
            if(brother.get(i).size() == 1){
                leaves.add(i);
            }
        }
        
        while(n>2){
            n -= leaves.size();
            List<Integer> newLeaves = new ArrayList<>();
            for(int v:leaves){
                int j = brother.get(v).iterator().next();
                brother.get(j).remove(v);
                if(brother.get(j).size() == 1){
                    newLeaves.add(j);
                }
            }
            leaves = newLeaves;
        }
        return leaves;
    }
}