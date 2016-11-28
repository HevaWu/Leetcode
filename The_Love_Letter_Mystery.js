/*
James找到了他的朋友Harry要给女朋友的情书。James很爱恶作剧，所以他决定要胡搞一下。他把信中的每个单字都变成了回文。对任何给定的字符串，他可以减少其中任何一个字符的值，例如'd'可以变成'c'，这算是一次操作。(另外，他最多只能将字符的值减少至'a'，'a'不能再被减少成'z')。找出将给定字符串转换成回文所需的最少操作次数。


输入格式 
第一行包含整数 T 代表测试数据的组数。 
接着 T 行各包含一个字符串。

输出格式 
每个测试数据各输出一行，代表此数据需要的最少操作次数。

取值范围 
1 ≤ T ≤ 10
1 ≤ 字符串长度 ≤ 104

样例输入 #00

3
abc
abcba
abcd
样例输出 #00

2
0
4
样例解析

第一组数据：ab*c* -> ab*b* -> ab*a*。 
第二组数据：abcba本身已经是回文了。 
第三组数据：abc*d* -> abc*c* -> abc*b* -> abc*a* = ab*c*a -> ab*b*a。
*/

function processData(input) {
    //Enter your code here
    var data = input.split('\n');
    //var nsize = data[0];
    var nsize = parseInt(data[0]);
    for(var i = 1; i <= nsize; i++){
        var count = 0;
        var current_string = data[i];  //var current_string=input.split('\n')[i+1];
        var len = current_string.length-1;
        var slen = 0;
        while(slen <= len){
            count += Math.abs(current_string.charCodeAt(len)-current_string.charCodeAt(slen));
            slen++;
            len--;
        }
         console.log(count);
    }
   
} 

process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});
