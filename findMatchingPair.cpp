int findMatchingPair(const string& input) {
    stack<char> s;
    if(input.length() == 0)
        return -1;
    if(input[0] >= 'a' && input[0] <= 'z' )
        return -1;
    int i = 0;
    while(i < input.length()) {
        if(input[i] >= 'A' && input[i] <= 'Z') {
            cout<< i <<endl;
            s.push(input[i]);
        } else {
            char c = s.top();
            cout << c << "c c  " << endl;
            cout << toupper(input[i]) << " ss" << endl;
            if(strcmp(toupper(input[i]),c) != 0) {
                return i - 1;
            } else {
                s.pop();
            }
        }
        i++;
    }
    return 0;
}