#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <fstream>
#include <sstream>
#include <cstring>
#include <stack>
#include <unordered_map>
#include <iomanip>

#define FILE_KEY "keywords.dat"
#define FILE_PAGE1 "page1.dat"
#define FILE_PAGE2 "page2.dat"
#define FILE_PAGE3 "page3.dat"

using namespace std;

struct Trie{
	Trie* tnode;
	string tvalue;
	string tword;
	vector<vector<int> > npage; //store each page
	vector<Trie*> child;  //store the children of this node
};

struct FreqNode{
	int keywords;
	// vector<int> freq;
	int freq;
	vector<string> pList;
};

class Engine{
private:
	int nappear; //store the appearance times of the word;
	vector<Trie *> tcount;
public:
	void addLine(Trie *t, string line, int pagenumber){
		Trie *node = t;
		char c[line.size()];
		strcpy(c,line.c_str());

		for(int i = 0; i < line.size()+1; i++){
			string s(1,c[i]);
			// cout << "string c " << s << endl;
			Trie *temp = checkChild(node,s);
			// Trie *temp = checkChild(t,s);
			if(temp->tvalue.empty())
				node = addChar(node,s);
			else
				node = temp;
			// cout << "tvalue " << node->tvalue << node->npage.size() << endl;
		}

		// for(int i = 0; i < line.size()+1; i++){
		// 	if(c[i]==' ')
		// 		continue;
		// 	if(i==0 || (c[i-1]==' ' && c[i]!=' ')){
		// 		if(i!=0){
		// 			cout << "do it? " << endl;
		// 			// string s1(1,'\0');
		// 			// cout << "s1 "<<s1 << endl;
		// 			node = addChar(node," ");
		// 			node->npage.push_back(vector<int>{pagenumber,1});

		// 			for(int i = 0; i < node->npage.size(); i++){
		// 				// cout << "run? " << node->npage[i][0] << pagenumber << endl;
		// 				if(node->npage[i][0] == pagenumber){
		// 					node->npage[i][1]++;
		// 					cout << "page1 " << node->tvalue << node->npage.size() << node->npage[i][1] << endl;
		// 					 goto nextWord;
		// 					// return;
		// 				} 
		// 			}

		// 		}
		// 		nextWord: node = t;
		// 	}

		// 	string s(1,c[i]);
		// 	// cout << "string c " << s << endl;
		// 	Trie *temp = checkChild(node,s);
		// 	// Trie *temp = checkChild(t,s);
		// 	if(temp->tvalue.empty())
		// 		node = addChar(node,s);
		// 	else
		// 		node = temp;
		// 	cout << "tvalue " << node->tvalue << node->npage.size() << endl;
		// }

		for(int i = 0; i < node->npage.size(); i++){
			// cout << "run? " << node->npage[i][0] << pagenumber << endl;
			if(node->npage[i][0] == pagenumber){
				node->npage[i][1]++;
				// cout << "page2 " << node->tvalue << node->npage.size() << node->npage[0][0]<<node->npage[0][1] <<endl;
				return;
			} 
		}
		
		// cout << "page " << node->tvalue << node->npage.size() << endl;

		node->npage.push_back(vector<int>{pagenumber,1});
		// cout << "page2 " << node->tvalue << node->npage.size() << node->npage[0][1] <<endl;
		// for(int i = 0; i < t->child.size(); i++)
		// 	cout << t->child[i]->tvalue << endl;
		// cout << "t size " << t->child.size() << endl;
	}

	Trie* checkChild(Trie *t, string s){
		//if the list of child exist node t then return , else return null node
		Trie *temp = new Trie();
		if(t->child.empty())
			return temp;
		for(int i = 0; i < t->child.size(); i++){
			if(t->child[i]->tvalue == s)
				return t->child[i];
		}
		return temp;
	}

	Trie* addChar(Trie *t, string s){
		//add node t into the list of child
		Trie *temp = new Trie();
		temp->tvalue = s;
		t->child.push_back(temp);
		return temp;
	}	

	void compressTrie(Trie *t){
		stack<Trie*> S;
		for(int i = 0; i < t->child.size(); i++){
			S.push(t->child[i]);
		}
		while(!S.empty()){
			Trie *temp = S.top();
			S.pop();
			// cout << "compress begin " << temp->tvalue << temp->child.empty() << temp->child.size() << temp->npage.size() << endl;
			if(temp->child.empty())
				continue;
			else if(temp->child.size()>1 || !temp->npage.empty()){
				// cout << "do it? " << endl;
				for(int i = 0; i < temp->child.size(); i++){
					S.push(temp->child[i]);
					// cout << "next push " << temp->tvalue << endl;
				}
			}
			if(temp->child.size()==1 && temp->npage.empty()){
				temp->npage = temp->child[0]->npage;
				// cout << "temp value " << temp->tvalue << " page " << temp->npage.size() << endl;
				temp->tvalue = temp->tvalue + temp->child[0]->tvalue;
				if(!temp->child[0]->child.empty())
					for(int i = 0; i < temp->child[0]->child.size(); i++){
						temp->child.push_back(temp->child[0]->child[i]);
						S.push(temp);
						// cout << "next continue push " << temp->tvalue <<" " <<temp->child[0]->child[i]->tvalue<<" " << temp->child.size() << endl;
					}

				// cout << "erase " << temp->child[0]->tvalue << temp->child.size() << endl;
				temp->child.erase(temp->child.begin()); 
				// cout << temp->child.size() << temp->child[0]->tvalue << temp->child[0]->child[0]->tvalue << endl;
			}
			// cout << "compress total " << temp->tvalue << temp->npage.size() << endl;
		}
	}

	void checkKey(Trie *t, string s){
		nappear++;
		Trie *node = t;
		int k = 0;
		char c[s.size()+1];
		strcpy(c,s.c_str());
		string temp="";
		// cout << "check begin " << endl;
		// cout << node->tvalue << node->child.size() << node->child[0]->tvalue<< endl;
		statement1:while(!node->child.empty()){
			int i = 0;
			statement2:for( ; i < node->child.size(); ){
				string s1 = node->child[i]->tvalue;
				char nodeT[s1.size()+1];
				strcpy(nodeT,s1.c_str());
				int n = 0;
				// cout << "i is " << i << node->child[i]->tvalue << s1.size() << endl;
				if(s1.size()>0){
					while(n < s1.size() && k< s.size()){
						if(nodeT[n] == c[k]){
							k++;
							n++;
							// cout << "n is " << n << " k is " << k << endl;
						}else{
							i++;
							goto statement2;
						}
					}
				}
				// cout << "node n " << nodeT[n-1] << c[k-1] << endl;
				if(nodeT[n-1] == c[k-1]){
					temp += node->child[i]->tvalue;
					// cout << "nodechild " << node->child[i]->tvalue << node->child[i]->npage.size() << endl;
					if(k == s.size()){
						node = node->child[i];
						// node->tword = temp;
						node->tword = s;

						if(node->npage.size() == 0){
							Trie *temp1 = node;
							for(int t = 0; t < temp1->child.size(); t++){
								for(int m = 0; m < temp1->npage.size(); m++){
									node->npage.push_back(vector<int>{temp1->npage[m][0],temp1->npage[m][1]});
								}
							}
						}

						tcount.push_back(node);
						// cout << "nodesize " << node->npage.size() << endl;
						cout << setw(10) << left << s << "-----";
						for(int j = 0; j < node->npage.size(); j++)
							cout << "(page: " << node->npage[j][0] << " freq: " << node->npage[j][1] << ") ";
						cout << endl;
						return;
					}
					// k++;
					node = node->child[i];
					goto statement1;
				}
			}
			cout << "Can not find the keywords." << endl;
			return;
		}
	}

	void Freq(){
		unordered_map<int, FreqNode> m;

		for(int i = 0; i < tcount.size(); i++){
			for(int j = 0; j < tcount[i]->npage.size(); j++){
				FreqNode f;
				unordered_map<int, FreqNode>::const_iterator it = m.find(tcount[i]->npage[j][0]);
				// cout << "show " << tcount[i]->npage[j][0] << endl;
				if(it != m.end()){
					// f = it->second;
					// cout << "it->second " << it->second.keywords << it->second.freq << endl;
					// f.keywords = f.keywords+1;
					// if(tcount[i]->npage[j][1] < f.freq)
					// 	f.freq = tcount[i]->npage[j][1];
					// cout << "show next " << f.keywords << f.freq << endl;
					// f.pList.push_back(tcount[i]->tword);

					// cout << "it->second " << it->second.keywords << it->second.freq << endl;
					// it->second.keywords++;
					// if(tcount[i]->npage[j][1] < it->second.freq)
					// 	it->second.freq = tcount[i]->npage[j][1];
					// cout << "show next " << it->second.keywords << it->second.freq << endl;
					// it->second.pList.push_back(tcount[i]->tword);
					// cout << "it List " << it->second.pList[it->second.pList.size()-1];

					// f = it->second;
					// cout << "it->second " << it->second->keywords << it->second->freq << endl;
					// f->keywords++;
					// if(tcount[i]->npage[j][1] < f->freq)
					// 	f->freq = tcount[i]->npage[j][1];
					// f->pList.push_back(tcount[i]->tword);
					// it->second = f;
					// cout << "show next " << f->keywords << f->freq << endl;

					f = it->second;
					// cout << "it->second " << it->second.keywords << it->second.freq << endl;
					f.keywords = f.keywords+1;
					if(tcount[i]->npage[j][1] < f.freq)
						f.freq = tcount[i]->npage[j][1];
					f.pList.push_back(tcount[i]->tword);
					m[tcount[i]->npage[j][0]] = f;
					// cout << "show next " << f.keywords << f.freq << endl;
					
					
				}else{
					f.keywords = 1;
					f.freq = tcount[i]->npage[j][1];
					// cout << "no find " << f.keywords << f.freq << endl;
					f.pList.push_back(tcount[i]->tword);
					m.insert({tcount[i]->npage[j][0],f});
					// cout << "f plist " << f.pList[f.pList.size()-1] << endl;

					// f->keywords = 1;
					// f->freq = tcount[i]->npage[j][1];
					// cout << "no find " << f->keywords << f->freq << endl;
					// f->pList.push_back(tcount[i]->tword);
					// m.insert({tcount[i]->npage[j][0],f});
					// cout << "f plist " << f->pList[f->pList.size()-1] << endl;
				}
				// f.pList.push_back(tcount[i]->tword);
				
				// m.insert({tcount[i]->npage[j][0],f});
			}
		}

		// for(int i = 0; i < tcount.size(); i++){
		// 	for(int j = 0; j < tcount[i]->npage.size(); j++){
		// 		// unordered_map<int, FreqNode>::const_iterator it2 = m.find(tcount[i]->npage[j][0]);
		// 		// if(it2 == m.end())
		// 		// 	continue;
		// 		// cout << "map " << tcount[i]->npage[j][0] << "int " << it2->first << "FreqNode " << it2->second.keywords << " " <<it2->second.freq << endl; 
		// 		// if(it2->second.pList.size() > 0){
		// 		// 	for(int k = 0; k < it2->second.pList.size(); k++)
		// 		// 		cout << "pList " << it2->second.pList[i] << endl;
		// 		// }
		// 		cout << "tcount "<<tcount[i]->tword << tcount[i]->npage[j][0] << endl;
		// 	}
		// }

		showFreq(m);
	}

	void showFreq(unordered_map<int, FreqNode> m){
		cout << setw(10) << left << "Page" << setw(10) << "Key" << setw(20) << "Freq" << endl;
		// cout << "appear" << nappear << endl;
		for(int i = nappear; i>=1; i--){
			for(auto it = m.begin(); it != m.end(); ++it){
				if(i == it->first){
					cout << setw(10) << left << it->first << setw(10) << it->second.keywords << setw(20) << it->second.freq << "(";
					for(string s:it->second.pList)
						cout << s << " ";
					cout << ")" << endl;
				}
			}
		}
	}

	void printNode(Trie *t){
		if(!t->child.empty()){
			for(int i = 0; i < t->child.size(); i++){
				if(t->child[i]->tvalue.size()>0){
					cout << t->child[i]->tvalue << "   ";
					printNode(t->child[i]);
				}
			}
		}
	}
};

int main(int argc, const char * argv[]){
	Trie *t = new Trie();
	Engine *e = new Engine();
	// ifstream KEY(FILE_KEY);
	ifstream PAGE1(FILE_PAGE1);
	ifstream PAGE2(FILE_PAGE2);
	ifstream PAGE3(FILE_PAGE3);
	string line;
	cout << "------------------------Page1------------------------" << endl;
	while(getline(PAGE1, line)){
		string line1 = line;
		int s = 0, s1 = 0;
		bool ifstop = false;
		while(ifstop == false){
			int s1=line1.find(" ");
			if(s1 == -1){
				string line2 = line1.substr(0,line1.size());
				e->addLine(t,line2,1);
				// cout << "end line " << line2 << endl;
				ifstop = true;
				continue;
			}
			string line2 = line1.substr(0,s1);
			e->addLine(t,line2,1);
			line1.erase(0,s1+1);
			// cout << "line2" << line2 << endl;
		}


		// e->addLine(t,line,1);
		cout << line << endl;
	}
	cout << endl;

	cout << "------------------------Page2------------------------" << endl;
	while(getline(PAGE2, line)){
		string line1 = line;
		int s = 0, s1 = 0;
		bool ifstop = false;
		while(ifstop == false){
			int s1=line1.find(" ");
			if(s1 == -1){
				string line2 = line1.substr(0,line1.size());
				e->addLine(t,line2,2);
				// cout << "end line " << line2 << endl;
				ifstop = true;
				continue;
			}
			string line2 = line1.substr(0,s1);
			e->addLine(t,line2,2);
			line1.erase(0,s1+1);
			// cout << "line2" << line2 << endl;
		}

		// e->addLine(t,line,2);
		cout << line << endl;
	}
	cout << endl;

	cout << "------------------------Page3------------------------" << endl;
	while(getline(PAGE3, line)){
		string line1 = line;
		int s = 0, s1 = 0;
		bool ifstop = false;
		while(ifstop == false){
			int s1=line1.find(" ");
			if(s1 == -1){
				string line2 = line1.substr(0,line1.size());
				e->addLine(t,line2,3);
				// cout << "end line " << line2 << endl;
				ifstop = true;
				continue;
			}
			string line2 = line1.substr(0,s1);
			e->addLine(t,line2,3);
			line1.erase(0,s1+1);
			// cout << "line2" << line2 << endl;
		}

		// e->addLine(t,line,3);
		cout << line << endl;
	}
	cout << endl;

	e->compressTrie(t);
	// e->printNode(t);
	// // cout << endl;

	// cout << endl;
	e->checkKey(t,"hello");
	e->checkKey(t,"arashi");
	e->checkKey(t,"yooooooo");
	e->checkKey(t,"lucky");
	cout << endl;

	e->Freq();

}