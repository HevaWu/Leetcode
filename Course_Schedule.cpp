/*
There are a total of n courses you have to take, labeled from 0 to n - 1.

Some courses may have prerequisites, for example to take course 0 you have to
first take course 1, which is expressed as a pair: [0,1]

Given the total number of courses and a list of prerequisite pairs, is it
possible for you to finish all courses?

For example:

2, [[1,0]]
There are a total of 2 courses to take. To take course 1 you should have
finished course 0. So it is possible.

2, [[1,0],[0,1]]
There are a total of 2 courses to take. To take course 1 you should have
finished course 0, and to take course 0 you should also have finished course 1.
So it is impossible.

Note:
The input prerequisites is a graph represented by a list of edges, not adjacency
matrices. Read more about how a graph is represented.

click to show more hints.

Hints:
This problem is equivalent to finding if a cycle exists in a directed graph. If
a cycle exists, no topological ordering exists and therefore it will be
impossible to take all courses. Topological Sort via DFS - A great video
tutorial (21 minutes) on Coursera explaining the basic concepts of Topological
Sort. Topological sort could also be done via BFS.
*/
class Solution {
 public:
  bool canFinish(int numCourses, vector<pair<int, int> > &prerequisites) {
    vector<unordered_set<int> > graph(numCourses);
    for (int i = 0; i < prerequisites.size(); i++) {
      graph[prerequisites[i].second].insert(prerequisites[i].first);
    }

    vector<int> course(graph.size(), 0);
    for (auto gra : graph) {
      for (int g : gra) {
        course[g]++;
      }
    }

    for (int i = 0; i < numCourses; i++) {
      int j = 0;
      for (; j < numCourses; j++) {
        if (!course[j]) break;
      }
      if (j == numCourses) return false;
      course[j] = -1;
      for (auto gra : graph[j]) {
        course[gra]--;
      }
    }

    return true;
  }

  // bool canFinish(int numCourses, vector<pair<int, int>>& prerequisites) {
  //     vector<unordered_set<int> > graph = makeGraph(numCourses,
  //     prerequisites); vector<int> course = makeCourse(graph); for(int i = 0;
  //     i < numCourses; i++){
  //         int j = 0;
  //         for(; j < numCourses; j++)
  //             if(!course[j]) break;
  //         if(j == numCourses) return false;
  //         course[j] = -1;
  //         for(auto gra:graph[j])
  //             course[gra]--;
  //     }
  //     return true;
  // }

  // vector<unordered_set<int> > makeGraph(int numCourses, vector<pair<int, int>
  // > prerequisites){
  //     vector<unordered_set<int> > graph(numCourses);
  //     for(int i = 0; i < prerequisites.size(); i++){
  //         graph[prerequisites[i].second].insert(prerequisites[i].first);
  //         //build graph to store each prerequisites course of one course
  //     }
  //     /*
  //     for(auto pre:prerequisites){
  //         graph[pre.second].insert(pre.first);
  //     }
  //     */
  //     return graph;
  // }

  // vector<int> makeCourse(vector<unordered_set<int> > graph){
  //     vector<int> course(graph.size(),0);
  //     for(auto gra:graph){
  //         for(int pre:gra){
  //             course[pre]++;   //add each prerequisites course
  //         }
  //     }

  //     return course;
  // }
};
