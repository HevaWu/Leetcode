/*
int compareVersion(string s1, string s2) {
    int size1 = s1.length();
    int size2 = s2.length();
    int sum1 = 0;
    int sum2 = 0, index1 = 0, index2 = 0;
    for(index1 = 0, index2 = 0; index1 < size1 || index2 < size2; index1++, index2++) {
        sum1 = 0;
        while(index1 < size1 && s1[index1] != '.') {
            sum1 = sum1*10 + s1[index1] - '0';
            ++index1;
        }
        
        sum2 = 0;
        while(index2 < size2 && s2[index2] != '.') {
            sum2 = sum2 * 10 + s2[index2] - '0';
            ++index2;
        }
        if(sum1 > sum2) {
            return 1;
        } else {
            if(sum1 < sum2) {
                return -1;
            }
        }
    }
    return 0;
}
*/

int compareVersion(string s1, string s2){
    int size1 = s1.length();
    int size2 = s2.length();
    int num1 = 0, num2 = 0, index1 = 0; index2 = 0;
    for(;index1 < size1 || index2 < size2; index1++, index2++){
        //in first loop, compare "major", then compare"minor", then "patch"
        num1 = 0;
        while(index1<size1 && s1[index1]!='.'){  
            num1 = num1*10 + (s1[index1]-'0'); 
            ++index1;
        }

        num2 = 0;
        while(index2<size2 && s2[index2]!='.'){
            num2 = num2*10 + (s2[index2]-'0');
            ++index2;
        }

        if(num1 > num2)  //if version s1 > version s2
            return 1;
        else if(num1 < num2) //if version s1 < version s2
            return -1;
    }
    return 0;  //after comparing all of the string, if there is no return before, the two string should be equal to each other
}

/*
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
*/