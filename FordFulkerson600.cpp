/*
Name: He Wu
CWID: 10406347
Course: CS-600-A
Project 8.2;
*/
#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <stack>
#include <climits>
#include <algorithm>

using namespace std;

struct GraphVNode{
	GraphVNode *head;
	GraphVNode *tail;
	int cweight;
	int flow;
	int nindex;  //the index of next node
};

class VNode{
public:
	GraphVNode *vnode;
	int vindex;
	bool isFirst(){
		if(vnode == NULL){
			vnode = new GraphVNode();
			return true;
		}
		else return false;
	}
	void addNext(int index, int cweight, int flow){
		//add the node into the latest vnode
		while(vnode->tail != NULL){
			vnode = vnode->tail;
		}
		vnode->tail = new GraphVNode();
		vnode->tail->head = vnode;
		vnode->tail->nindex = index;
		vnode->tail->cweight = cweight;
		vnode->tail->flow = flow;
		while(vnode->head != NULL){
			vnode = vnode->head;
		}
	}
	void rFirst(){
		//return the first vnode
		while(vnode->head != NULL){
			vnode = vnode->head;
		}
	}
};

class Graph{
private:
	vector<int> mflow;  //store the path of max flow
	vector<int> subflow;  //store the weight of node
	vector<vector<int> > verMatrix;  //store the weight to each node
	vector<VNode*> G;
	vector<char> ver; //stor the vertex
	int vsize;
	vector<pair<vector<char>,int> > edg;
public:
	Graph(vector<char> vertex, vector<pair<vector<char>,int> > edge){
		int verSize = vertex.size();
		vector<vector<int> > verMatrix_1(verSize, vector<int>(verSize,0));
		vector<VNode*> G_1(verSize);
		for(int i = 0; i < verSize; i++){
			G_1[i] = new VNode();
			G_1[i]->vindex = i;
		}

		for(int i = 0; i < edge.size(); i++){
			int e1 = patch(vertex, edge[i].first[0]);
			int e2 = patch(vertex, edge[i].first[1]);
			int eweight = edge[i].second;
			verMatrix_1[e1][e2] = edge[i].second;  //initialize the matrix

			if(G_1[e1]->isFirst()){
				G_1[e1]->vnode->cweight = eweight;
				G_1[e1]->vnode->flow = eweight;
				G_1[e1]->vnode->nindex = e2;
			}else{
				G_1[e1]->addNext(e2,eweight,eweight);
			}
			if(G_1[e2]->isFirst()){
				G_1[e2]->vnode->cweight = eweight;
				G_1[e2]->vnode->flow = 0;
				G_1[e2]->vnode->nindex = e1;
			}else{
				G_1[e2]->addNext(e1,eweight,0);
			}
		}
		G = G_1;
		verMatrix = verMatrix_1;
		vsize = verSize;
		ver = vertex;
		edg = edge;

		//print the graph
		cout << "**************************The Graph**************************" << endl;
		for(int i = 0; i < G.size(); i++){
			cout << i << " is " << vertex[i] ;
			if(G[i]->vnode != NULL){
				cout << "---" << G[i]->vnode->nindex << "(" << G[i]->vnode->flow << "/" << G[i]->vnode->cweight << ")";
				GraphVNode* temp = new GraphVNode();
				temp = G[i]->vnode;
				while(temp->tail != NULL){
					cout << "---" << temp->tail->nindex << "(" << temp->tail->flow << "/" << temp->tail->cweight << ")";
					temp = temp->tail;
				}
				cout << endl;
			}
		}
		cout << endl;
	}

	int patch(vector<char> vertex, char c){
		for(int i = 0; i < vertex.size(); i++){
			if(vertex[i]==c)
				return i;
		}
	}

	void isEnd(int s, int t, int detaf, bool &stop, int &maxflow){
		if(detaf != -1){
			int k = t;
			while(k != s){
				for(int i = 0; i < vsize; i++){
					G[i]->rFirst();
				}
				while(G[k]->vnode->nindex != subflow[k]){
					G[k]->vnode = G[k]->vnode->tail;
				}
				G[k]->vnode->flow += detaf;
				for(int i = 0; i < vsize; i++){
					G[k]->rFirst();
				}
				while(G[subflow[k]]->vnode->nindex != k){
					G[subflow[k]]->vnode = G[subflow[k]]->vnode->tail;
				}
				G[subflow[k]]->vnode->flow -= detaf;
				k = subflow[k];
				for(int i = 0; i < vsize; i++){
					G[i]->rFirst();
				}
			}
			maxflow += detaf;
		}else{
			stop = true;
		}
	}

	int MaxFlowFordFulkerson(int s, int t){
		//*****************************BFS*****************************
		cout << "*****************************BFS*****************************" << endl;
		bool stop = false;
		int maxflow = 0;
		while(stop == false){
			//find if there is an augmenting path for f
			//if there is, return the resudual capacoty detaf  
			int detaf = FindPath1(s,t);
			isEnd(s, t, detaf, stop, maxflow);
		}
		cout << "Max flow is " << maxflow << endl << endl;

		//*****************************DFS*****************************
		Graph *g2 = new Graph(ver,edg);
		cout << "*****************************DFS*****************************" << endl;
		stop = false;
		maxflow = 0;
		while(stop == false){
			//find if there is an augmenting path for f
			//if there is, return the resudual capacoty detaf  
			int detaf = g2->FindPath2(s,t);
			g2->isEnd(s, t, detaf, stop, maxflow);
		}
		cout << "Max flow is " << maxflow << endl << endl;

		//*************************Third Method*************************
		Graph *g3 = new Graph(ver,edg);
		cout << "*************************Third Method*************************" << endl;
		stop = false;
		maxflow = 0;
		while(stop == false){
			//find if there is an augmenting path for f
			//if there is, return the resudual capacoty detaf  
			int detaf = g3->FindPath3(s,t);
			g3->isEnd(s, t, detaf, stop, maxflow);
		}
		cout << "Max flow is " << maxflow << endl << endl;

		return maxflow;
	}

	//*****************************BFS*****************************
	int FindPath1(int s, int t){
		subflow.resize(vsize);
		mflow.resize(vsize);
		for(int i = 0; i < vsize; i++){
			subflow[i] = -1;
			mflow[i] = 0;
		}
		queue<VNode*> Q;
		Q.push(G[s]);
		subflow[s] = 0;
		mflow[s] = INT_MAX;
		while(!Q.empty()){
			VNode* temp = Q.front();
			Q.pop();
			if(temp->vindex == s){
				cout << ver[temp->vindex];
			}else{
				cout << "--->" << ver[temp->vindex] << "(" ;
				cout << mflow[temp->vindex] << ")"; 
			}
			if(temp->vindex == t){
				cout << endl;
				break;
			}
			while(temp->vnode != NULL){
				if(temp->vnode->flow>0 && subflow[temp->vnode->nindex]==-1){
					mflow[temp->vnode->nindex] = min(mflow[temp->vindex],temp->vnode->flow);
					subflow[temp->vnode->nindex] = temp->vindex;
					Q.push(G[temp->vnode->nindex]);
				}
				if(temp->vnode->tail == NULL)
					break;
				temp->vnode = temp->vnode->tail;
			}
		}
		for(int i = 0; i < vsize; i++){
			G[i]->rFirst();
		}
		if(subflow[t] == -1)
			return -1;
		return mflow[t];
	}

	//*****************************DFS*****************************
	int FindPath2(int s, int t){
		subflow.resize(vsize);
		mflow.resize(vsize);

		int minvalue = INT_MAX;
		int tempindex = 0;;

		for(int i = 0; i < vsize; i++){
			subflow[i] = -1;
			mflow[i] = 0;
		}
		stack<VNode*> Q;
		Q.push(G[s]);
		subflow[s] = 0;
		mflow[s] = INT_MAX;
		while(!Q.empty()){
			VNode* temp = Q.top();
			Q.pop();
			if(temp->vindex == s){
				cout <<  ver[temp->vindex];
				tempindex = temp->vindex;
			}else{
				cout << "--->" << ver[temp->vindex] << "(" ;
				subflow[temp->vindex] = tempindex;
				tempindex = temp->vindex;
				if(mflow[temp->vindex] > minvalue)
					mflow[temp->vindex] = minvalue;
				cout << mflow[temp->vindex] << ")"; 
			}
			if(temp->vindex == t){
				cout << endl;
				break;
			}
			while(temp->vnode != NULL){
				if(temp->vnode->flow>0 && subflow[temp->vnode->nindex]==-1){
					mflow[temp->vnode->nindex] = min(mflow[temp->vindex],temp->vnode->flow);
					minvalue = mflow[temp->vnode->nindex];
					subflow[temp->vnode->nindex] = temp->vindex;
					Q.push(G[temp->vnode->nindex]);
				}
				if(temp->vnode->tail == NULL)
					break;
				temp->vnode = temp->vnode->tail;
			}
		}
		for(int i = 0; i < vsize; i++){
			G[i]->rFirst();
		}
		if(subflow[t] == -1)
			return -1;

		return mflow[t];
	}

	//*************************Third Method*************************
	int FindPath3(int s, int t){
		subflow.resize(vsize);
		mflow.resize(vsize);
		int minvalue = INT_MAX;
		int tempindex = 0;
		for(int i = 0; i < vsize; i++){
			subflow[i] = -1;
			mflow[i] = 0;
		}
		vector<VNode*> Q;
		Q.push_back(G[s]);
		subflow[s] = 0;
		mflow[s] = INT_MAX;
		while(!Q.empty()){
			VNode* temp = Q.back();
			Q.pop_back();
			if(temp->vindex == s){
				cout <<  ver[temp->vindex];
				tempindex = temp->vindex;
			}else{
				cout << "--->" << ver[temp->vindex] << "(" ;
				subflow[temp->vindex] = tempindex;
				tempindex = temp->vindex;
				if(mflow[temp->vindex] > minvalue)
					mflow[temp->vindex] = minvalue;
				cout << mflow[temp->vindex] << ")"; 
			}
			if(temp->vindex == t){
				cout << endl;
				break;
			}
			while(temp->vnode != NULL){
				if(temp->vnode->flow>0 && subflow[temp->vnode->nindex]==-1){
					mflow[temp->vnode->nindex] = min(mflow[temp->vindex],temp->vnode->flow);
					minvalue = mflow[temp->vnode->nindex];
					subflow[temp->vnode->nindex] = temp->vindex;
					Q.push_back(G[temp->vnode->nindex]);
				}
				if(temp->vnode->tail == NULL){
					break;
				}
				temp->vnode = temp->vnode->tail;
			}
		}
		for(int i = 0; i < vsize; i++){
			G[i]->rFirst();
		}
		if(subflow[t] == -1)
			return -1;

		return mflow[t];
	}
};


int main(){
	vector<char> vertex = {'A','B','C','D'};
	vector<pair<vector<char>,int> > edge = {
		{{'A','B'},40},
		{{'A','C'},20},
		{{'C','B'},20},
		{{'C','D'},10},
		{{'D','B'},30}
	};
	
	Graph *g = new Graph(vertex,edge);
	int maxflow = g->MaxFlowFordFulkerson(0,1);
	
	return 0;
}

