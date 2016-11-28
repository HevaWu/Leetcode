/*
Compare two version numbers version1 and version2.
If version1 > version2 return 1, if version1 < version2 return -1, otherwise return 0.

You may assume that the version strings are non-empty and contain only digits and the . character.
The . character does not represent a decimal point and is used to separate number sequences.
For instance, 2.5 is not "two and a half" or "half way to version three", it is the fifth second-level revision of the second first-level revision.

Here is an example of version numbers ordering:

0.1 < 1.1 < 1.2 < 13.37
*/

class Solution {
public:

    int compareVersion(string version1, string version2) {
       // int size1 = version1.size(), size2=version2.size();
        string subVersion1, subVersion2;
        int inumber1, inumber2, istart1=0, istart2=0, ipos1=0, ipos2=0;
        
        while(istart1 < version1.size() || istart2 < version2.size()){
            if(istart1 >= version1.size())  inumber1 = 0;
            else{
                ipos1 = version1.find_first_of('.', istart1);  //find the first position of '.'
                if(-1 == ipos1) ipos1 = version1.size();  //judge if it is the end of the string
                subVersion1.assign(version1, istart1, ipos1-istart1);  //assign is the function using "." to use
                inumber1 = stoi(subVersion1);  //transfer string to int
            }
            
            if(istart2 >= version2.size())  inumber2 = 0;
            else{
                ipos2 = version2.find_first_of('.', istart2);
                if(-1 == ipos2) ipos2 = version2.size();
                subVersion2.assign(version2, istart2, ipos2-istart2);
                inumber2 = stoi(subVersion2);
            }
            
            if(inumber1 > inumber2) return 1;
            else if(inumber1 < inumber2) return -1;
            
            istart1 = ipos1+1;  //compare the number after '.'
            istart2 = ipos2+1;
            
        }
        return 0;
    }
};