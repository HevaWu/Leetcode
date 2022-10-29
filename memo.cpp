// pointer

int i = 3;
int* ptr = &i;  // A pointer to variable i or "stores the address of i"
int& ref = i;   // A reference (or alias) for i.

// int
to_string(1);  // convert int to string

// string
sort(str.begin(), str.end());  // sort string

// array

int arr[7] = {1, 5, 10, 50, 100, 500, 1000};

// vector

vector<int> result{duplicate, missing};  // init
for (auto it = begin(vector); it != end(vector); ++it) {
  it->doSomething();
}
for (auto& it : freq) {
  list.push_back(it);
}
sort(list.begin(), list.end(), cmp);  // sort with compare
static bool cmp(pair<string, int>& a, pair<string, int>& b) {
  return a.second == b.second ? a.first < b.first : a.second > b.second;
}
vector<pair<int, int>> seeds; // sort pair
for(int i = 0; i < n; i++) {
    seeds.push_back({plantTime[i], growTime[i]});
}
sort(seeds.begin(), seeds.end(), [](pair<int, int>& s1, pair<int, int>& s2) -> bool {
    return s1.second > s2.second;
});

// map

unordered_map<string, int> freq;
for (auto& word : words) {
  if (freq.find(word) != freq.end()) {
    freq[word] = freq[word] + 1;
  } else {
    freq[word] = 0;
  }
}
freq.count(key);  // if (freq.count(key)) {key exists}
for (string& word : words) mp[word]++;
map<int, std::string> mapPerson;
mapPerson.insert(pair<int, string>(1, "Jim"));
mapPerson[3] = "Jerry";
it = mapPerson.begin();
itEnd = mapPerson.end();
iterator erase(iterator first, iterator last);  //删除一个范围
vector<vector<string>> group;                   // group all values in map
for (unordered_map<string, vector<string>>::iterator it = anagram.begin();
     it != anagram.end(); it++) {
  group.push_back(it->second);
}
