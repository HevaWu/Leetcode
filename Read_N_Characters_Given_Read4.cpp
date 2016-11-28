/*158. Read N Characters Given Read4 II - Call multiple times   QuestionEditorial Solution  My Submissions
Total Accepted: 15212 Total Submissions: 62751 Difficulty: Hard Contributors: Admin
The API: int read4(char *buf) reads 4 characters at a time from a file.

The return value is the actual number of characters read. For example, it returns 3 if there is only 3 characters left in the file.

By using the read4 API, implement the function int read(char *buf, int n) that reads n characters from the file.

Note:
The read function may be called multiple times.

Hide Company Tags Bloomberg Google Facebook
Hide Tags String
Hide Similar Problems (E) Read N Characters Given Read4


Think that you have 4 chars "a, b, c, d" in the file, and you want to call your function twice like this:

read(buf, 1); // should return 'a'
read(buf, 3); // should return 'b, c, d'
All the 4 chars will be consumed in the first call. So the tricky part of this question is how can you preserve the remaining 'b, c, d' to the second call.*/



/*
use buffPtr buffer pointer and buffCounter to store the data received in previous calls
if buffPtr reches current buffCounter, set it as 0 and to be ready to read new data*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
// Forward declaration of the read4 API.
int read4(char *buf);

class Solution {
    private:
    int buffPtr = 0;
    int buffCounter = 0;
    char buff[5];
    
public:
    /**
     * @param buf Destination buffer
     * @param n   Maximum number of characters to read
     * @return    The number of characters read
     */
    int read(char *buf, int n) {
        int ret = 0;
        while(ret < n){
            if(buffPtr == 0){
                buffCounter = read4(buff);
            }
            if(buffCounter == 0) break;
            while(ret<n && buffPtr<buffCounter){
                buf[ret++] = buff[buffPtr++];
            }
            if(buffPtr==buffCounter) buffPtr = 0;
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
/* The read4 API is defined in the parent class Reader4.
      int read4(char[] buf); */

public class Solution extends Reader4 {
    private int buffPtr = 0;
    private int buffCounter = 0;
    private char[] buff = new char[4];
    /**
     * @param buf Destination buffer
     * @param n   Maximum number of characters to read
     * @return    The number of characters read
     */
    public int read(char[] buf, int n) {
        int ret = 0;
        while(ret < n){
            if(buffPtr == 0){
                buffCounter = read4(buff);
            }
            if(buffCounter == 0) break; //buffer is no place for new element
            while(ret<n && buffPtr<buffCounter){
                buf[ret++] = buff[buffPtr++];
            }
            //buffer is full, read new data
            if(buffPtr == buffCounter){
                buffPtr = 0;
            }
        }
        return ret;
    }
}
