/*
Name: He Wu
CWID: 10406347
Course: CS-600-A
Project 8.2;
*/
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
			Trie *temp = checkChild(node,s);
			if(temp->tvalue.empty())
				node = addChar(node,s);
			else
				node = temp;
		}
		for(int i = 0; i < node->npage.size(); i++){
			if(node->npage[i][0] == pagenumber){
				node->npage[i][1]++;
				return;
			} 
		}
		node->npage.push_back(vector<int>{pagenumber,1});
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
			if(temp->child.empty())
				continue;
			else if(temp->child.size()>1 || !temp->npage.empty()){
				for(int i = 0; i < temp->child.size(); i++){
					S.push(temp->child[i]);
				}
			}
			if(temp->child.size()==1 && temp->npage.empty()){
				temp->npage = temp->child[0]->npage;
				temp->tvalue = temp->tvalue + temp->child[0]->tvalue;
				if(!temp->child[0]->child.empty())
					for(int i = 0; i < temp->child[0]->child.size(); i++){
						temp->child.push_back(temp->child[0]->child[i]);
						S.push(temp);
					}
				temp->child.erase(temp->child.begin()); 
			}
		}
	}

	void checkKey(Trie *t, string s,vector<int> totalword){
		nappear++;
		Trie *node = t;
		int k = 0;
		char c[s.size()+1];
		strcpy(c,s.c_str());
		string temp="";
		statement1:while(!node->child.empty()){
			int i = 0;
			statement2:for( ; i < node->child.size(); ){
				string s1 = node->child[i]->tvalue;
				char nodeT[s1.size()+1];
				strcpy(nodeT,s1.c_str());
				int n = 0;
				if(s1.size()>0){
					while(n < s1.size() && k< s.size()){
						if(nodeT[n] == c[k]){
							k++;
							n++;
						}else{
							i++;
							goto statement2;
						}
					}
				}
				if(nodeT[n-1] == c[k-1]){
					temp += node->child[i]->tvalue;
					if(k == s.size()){
						node = node->child[i];
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
						cout << setw(10) << left << s << "-----";
						for(int j = 0; j < node->npage.size(); j++)
							cout << "(page: " << node->npage[j][0] << " freq: " << node->npage[j][1] << "/" << totalword[node->npage[j][0]-1] << ") ";
						cout << endl;
						return;
					}
					node = node->child[i];
					goto statement1;
				}
			}
			cout << setw(10) << left << s << "-----" <<" Can not find the keywords." << endl;
			return;
		}
	}

	void Freq(){
		unordered_map<int, FreqNode> m;
		for(int i = 0; i < tcount.size(); i++){
			for(int j = 0; j < tcount[i]->npage.size(); j++){
				FreqNode f;
				unordered_map<int, FreqNode>::const_iterator it = m.find(tcount[i]->npage[j][0]);
				if(it != m.end()){
					f = it->second;
					f.keywords = f.keywords+1;
					if(tcount[i]->npage[j][1] < f.freq)
						f.freq = tcount[i]->npage[j][1];
					f.pList.push_back(tcount[i]->tword);
					m[tcount[i]->npage[j][0]] = f;
				}else{
					f.keywords = 1;
					f.freq = tcount[i]->npage[j][1];
					f.pList.push_back(tcount[i]->tword);
					m.insert({tcount[i]->npage[j][0],f});
				}
			}
		}
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

int inputLine(string line,Trie *t,Engine *e, int pagenumber){
	vector<string> ignoreword={
		"a","an","the","some",
		"at","in","on","during","for","over","above","below","before","after","by","with","through","except","but",
		"I","i","me","we","us","you","he","him","she","her","it","they","them"
	};
	int totalword = 0; //count useful words in this line

	for(int i = 0; i < line.size(); i++){
			if((line[i]>='a'&&line[i]<='z') || (line[i]>='A'&&line[i]<='Z'))
				continue;
			else
				line[i] = ' ';
		}
		for(int i = 1; i < line.size(); i++){
			if(line[i-1]==' ' && line[i]==' '){
				line.erase(line.begin()+i);
				i = i -1;
			}
		}

		string line1 = line;
		int s = 0, s1 = 0;
		bool ifstop = false;
		while(ifstop == false){
			int s1=line1.find(" ");
			
			bool ifignore = false;

			if(s1 == -1){
				string line2 = line1.substr(0,line1.size());

				//check if this word is articles/prepositions/pronouns
				for(int i = 0; i < ignoreword.size(); i++){
					if(line2 == ignoreword[i])
						ifignore = true;
				}
				if(ifignore == true){
					ifstop=true;
					continue;
				}

				e->addLine(t,line2,pagenumber);
				totalword++;
				ifstop = true;
				continue;
			}
			string line2 = line1.substr(0,s1);

			//check if this word is articles/prepositions/pronouns
				for(int i = 0; i < ignoreword.size(); i++){
					if(line2 == ignoreword[i])
						ifignore = true;
				}
				if(ifignore == true){
					line1.erase(0,s1+1);
					continue;
				}

			e->addLine(t,line2,pagenumber);
			totalword++;
			line1.erase(0,s1+1);
		}
		cout << line << endl;

		return totalword;
}

int main(int argc, const char * argv[]){
	Trie *t = new Trie();
	Engine *e = new Engine();
	ifstream PAGE1(FILE_PAGE1);
	ifstream PAGE2(FILE_PAGE2);
	ifstream PAGE3(FILE_PAGE3);
	string line;
	vector<int> totalword;
	int totalword1=0;
	int totalword2=0;
	int totalword3=0;
	cout << "------------------------Page1------------------------" << endl;
	while(getline(PAGE1, line)){
		totalword1 += inputLine(line,t,e,1);
	}
	totalword.push_back(totalword1);
	cout << endl;

	cout << "------------------------Page2------------------------" << endl;
	while(getline(PAGE2, line)){
		totalword2 += inputLine(line,t,e,2);
	}
	totalword.push_back(totalword2);
	cout << endl;

	cout << "------------------------Page3------------------------" << endl;
	while(getline(PAGE3, line)){
		totalword3 += inputLine(line,t,e,3);
	}
	totalword.push_back(totalword3);
	cout << endl;

	cout << "-----------------Freq Table(each Key)-----------------" << endl;
	e->compressTrie(t);
	e->checkKey(t,"hello",totalword);
	e->checkKey(t,"arashi",totalword);
	e->checkKey(t,"yooooooo",totalword);
	e->checkKey(t,"lucky",totalword);
	e->checkKey(t,"asdfhuif",totalword);
	cout << endl;

	cout << "-----------------Freq Table(all Keys)-----------------" << endl;
	e->Freq();

	return 0;
}
