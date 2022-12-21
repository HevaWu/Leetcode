// pointer

int i = 3;
int* ptr = &i;  // A pointer to variable i or "stores the address of i"
int& ref = i;   // A reference (or alias) for i.
INT_MIN;        // min integer value
INT_MAX;        // max integer value
ListNode* low = head;
if (fast != nullptr) {
}  // check if pointer is null
low = low->next;  // point to its next variable

// int
to_string(1);  // convert int to string
char a = '4';
int ia = a - '0'; /* check here if ia is bounded by 0 and 9 */

// string
stoi("12");                    // convert string to int
sort(str.begin(), str.end());  // sort string
str.substr(3, 2);              // substring start from index 3, with length 2
str.substr(3);                 // substring after index 3
s.substr(i) + s.substr(0, i);
size_t pos;
(pos = s.find(
     ' ')) != string::npos;  // check if can find related position in string

// char
islower(c1);  // check if character is lowercase
tolower(c1);  // convert to lower char

// array

int arr[7] = {1, 5, 10, 50, 100, 500, 1000};

// vector

vector<int> result{duplicate, missing};  // init
vector<int> freq1(26, 0);  // init with len is 26, all default is 0
vector<vector<int>> vec(n, vector<int>(m, 0));  // 2d vector init
for (auto it = begin(vector); it != end(vector); ++it) {
  it->doSomething();
}
numArr.insert(numArr.begin(), num % 10);  // insert into vector
for (auto& it : freq) {
  list.push_back(it);
}
sort(list.begin(), list.end(), cmp);  // sort with compare
static bool cmp(pair<string, int>& a, pair<string, int>& b) {
  return a.second == b.second ? a.first < b.first : a.second > b.second;
}
vector<pair<int, int>> seeds;  // sort pair
for (int i = 0; i < n; i++) {
  seeds.push_back({plantTime[i], growTime[i]});
}
sort(seeds.begin(), seeds.end(),
     [](pair<int, int>& s1, pair<int, int>& s2) -> bool {
       return s1.second > s2.second;
     });
result.back();      // last element in vector
result.pop_back();  // remove last element

// map

unordered_map<string, int> freq;
for (auto& word : words) {
  if (freq.find(word) != freq.end()) {
    freq[word] = freq[word] + 1;
  } else {
    freq[word] = 0;
  }
  // above equal to bellow, default value will auto set as 0
  freq[word] = freq[word] + 1;
}
freq.count(key);  // if (freq.count(key)) {key exists}
for (string& word : words) mp[word]++;
map<int, std::string> mapPerson;
mapPerson.insert(pair<int, string>(1, "Jim"));
mapPerson[3] = "Jerry";
it = mapPerson.begin();
itEnd = mapPerson.end();
iterator erase(iterator first, iterator last);  // 删除一个范围
vector<vector<string>> group;                   // group all values in map
for (unordered_map<string, vector<string>>::iterator it = anagram.begin();
     it != anagram.end(); it++) {
  group.push_back(it->second);
}
freq.erase(key);  // remove a key in map

// pair

pair<int, int> newPair;
int firstVal = newPair.first;
int secondVal = newPair.second;

// stack

stack<char> st;
st.top();      // return top element
st.pop();      // just remove top element, return void
st.push(ele);  // add element to stack

// set

unordered_set<int> newset;  // init hashset
newset.insert(val);         // insert val to set
if (newset.find(val) == newset.end()) {
  // not contains val in set
}
newset.erase(val);  // remove val from set

// get random element from 0..<arr.size()
int getRandom() { return arr[rand() % arr.size()]; }
