class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        string sprefix = "";
        for(int i = 0; strs.size()>0; sprefix += strs[0][i],i++)
        {
            for(int j = 0; j < strs.size(); j++)
            {
                if((i>=strs[j].size()) || (j>0 && strs[j][i]!=strs[j-1][i]))
                    return sprefix;
            }
        }
        return sprefix;
    }
};
