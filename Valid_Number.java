/*65. Valid Number Add to List
Description  Submission  Solutions
Total Accepted: 62737
Total Submissions: 495241
Difficulty: Hard
Contributors: Admin
Validate if a given string is numeric.

Some examples:
"0" => true
" 0.1 " => true
"abc" => false
"1 a" => false
"2e10" => true
Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one.

Update (2015-02-10):
The signature of the C++ function had been updated. If you still see your function signature accepts a const char * argument, please click the reload button  to reset your code definition.

Hide Company Tags LinkedIn
Hide Tags Math String
Hide Similar Problems (M) String to Integer (atoi)
 */






/*
Solution 2 faster than Solution 3 faster than Solution 1

Solution 1: string pattern one line 48 ms/ 1481 test
check if string satisfy pattern
    return s.matches("(\\s*)[+-]?((\\.[0-9]+)|([0-9]+(\\.[0-9]*)?))(e[+-]?[0-9]+)?(\\s*)");

Solution 2: 6 ms/ 1481 test
    isNumber(s)==true if and only if s=s1 or s1+'e'+s2, where s1, s2
    are valid strings of a number without the char 'e', and s2 is aninteger.
    'e' : valid_count=0~1; Valid chars in a string of a number without 'e' [boolean hasE]
    ' ' : valid_count=0~n; must appear at two ends
    '+/-' : valid_count=0~1; must be the first non-space valid char; [boolean hasFirst]
    '.' : valid_count=0~1; cannot appear after 'e'; [boolean hasDot]
    '0~9' : valid_count=1~n; [boolean hasDigit]

Solution 3: design the rules 29 ms/ 1481 test

 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: string pattern
public class Solution {
    public boolean isNumber(String s) {
        return s.matches("(\\s*)[+-]?((\\.[0-9]+)|([0-9]+(\\.[0-9]*)?))(e[+-]?[0-9]+)?(\\s*)");
        /*
         *  (\\s*) ---
                (X)  as a capturing group
                \\s  a whitespace character
                X*   X,zero or one more times
            [+-]? ---
                [X]  grouping
                X?   once or not at all
            \\.[0-9]+ ---
                X+   one or more times
                \\.  .
         */
    }
}



//Solution 2:
public class Solution {
    public boolean isNumber(String s) {
        if(s==null || s.length()==0) return false;

        boolean hasDigit = false;
        boolean hasDot = false;
        boolean hasE = false;
        boolean hasFirst = false;
        s = s.trim(); //remove the whitespace before and after
        for(int i = 0; i < s.length(); ++i){
            char c = s.charAt(i);
            if(c>='0' && c<='9'){
                hasDigit = true;
                hasFirst = true;
                continue;
            }
            switch(c){
                case 'e':
                    if(hasE || !hasDigit) return false;
                    hasE = true;
                    hasFirst = hasDigit = false; //reset for exponential number
                    hasDot = true; //the exponential must be an integer, should not accept the digital number at the end
                    continue;
                case '+':
                case '-':
                    if(hasFirst) return false;
                    hasFirst = true;
                    continue;
                case '.':
                    if(hasDot) return false;
                    hasFirst = hasDot = true;
                    continue;
                default:
                    return false;
            }
        }

        return hasDigit;
    }
}





//Solution 3
public class Solution {
    interface NumberValidate{
        boolean validate(String s);
    }

    abstract class NumberValidateTemp implements NumberValidate{
        public boolean validate(String s){
            if(checkStringEmpty(s)) return false;
            s = checkAndProcessHeader(s);
            if(s.length() == 0) return false;
            return doValidate(s);
        }

        private boolean checkStringEmpty(String s){
            if(s.equals("")) return true;
            return false;
        }

        private String checkAndProcessHeader(String s){
            s = s.trim();
            if(s.startsWith("+") || s.startsWith("-")){
                s = s.substring(1);
            }
            return s;
        }

        protected abstract boolean doValidate(String s);
    }

    class NumberValidator implements NumberValidate{
        private List<NumberValidate> validators = new ArrayList<>();

        public NumberValidator(){
            addValidators();
        }

        private void addValidators(){
            NumberValidate nv = new IntegerValidate();
            validators.add(nv);

            nv = new FloatValidate();
            validators.add(nv);

            nv = new HexValidate();
            validators.add(nv);

            nv = new ScienceFormatValidate();
            validators.add(nv);
        }

        @Override
        public boolean validate(String s){
            for(NumberValidate nv: validators){
                if(nv.validate(s) == true) return true;
            }
            return false;
        }
    }

    class IntegerValidate extends NumberValidateTemp{
        protected boolean doValidate(String integer){
            for(int i = 0; i < integer.length(); ++i){
                if(Character.isDigit(integer.charAt(i)) == false) return false;
            }
            return true;
        }
    }

    class HexValidate extends NumberValidateTemp{
        private char[] valids = new char[]{'a','b','c','d','e','f'};
        protected boolean doValidate(String hex){
            hex = hex.toLowerCase();
            if(hex.startsWith("0x")){
                hex = hex.substring(2);
            } else {
                return false;
            }

            for(int i = 0; i < hex.length(); ++i){
                if(Character.isDigit(hex.charAt(i)) == false
                    && isValidChar(hex.charAt(i)) == false) return false;
            }
            return true;
        }

        private boolean isValidChar(char c){
            for(int i = 0; i < valids.length; ++i){
                if(c == valids[i]) return true;
            }
            return false;
        }
    }

    class ScienceFormatValidate extends NumberValidateTemp{
        protected boolean doValidate(String s){
            s = s.toLowerCase();
            int pos = s.indexOf("e");
            if(pos==-1) return false;
            if(s.length() == 1) return false;
            String first = s.substring(0,pos);
            String second = s.substring(pos+1, s.length());

            if(validatePartBeforeE(first) == false
                || validatePartAfterE(second) == false) return false;
            return true;
        }

        private boolean validatePartBeforeE(String first){
            if(first.equals("") == true) return false;
            if(checkHeadAndEndForSpace(first) == false) return false;

            NumberValidate integerValidate = new IntegerValidate();
            NumberValidate floatValidate = new FloatValidate();
            if(integerValidate.validate(first) == false
                && floatValidate.validate(first) == false) return false;
            return true;
        }

        private boolean validatePartAfterE(String second){
            if(second.equals("") == true) return false;
            if(checkHeadAndEndForSpace(second) == false) return false;

            NumberValidate integerValidate = new IntegerValidate();
            if(integerValidate.validate(second) == false) return false;
            return true;
        }

        private boolean checkHeadAndEndForSpace(String part){
            if(part.startsWith(" ") || part.endsWith(" ")) return false;
            return true;
        }
    }

    class FloatValidate extends NumberValidateTemp{
        protected boolean doValidate(String s){
            int pos = s.indexOf(".");
            if(pos == -1) return false;
            if(s.length() == 1) return false;

            NumberValidate nv = new IntegerValidate();
            String first = s.substring(0, pos);
            String second = s.substring(pos+1, s.length());

            if(checkFirstPart(first) == true && checkFirstPart(second) == true) return true;
            return false;
        }

        private boolean checkFirstPart(String first){
            if(first.equals("")==false && checkPart(first)==false) return false;
            return true;
        }

        private boolean checkPart(String part){
            if(Character.isDigit(part.charAt(0)) == false
                || Character.isDigit(part.charAt(part.length()-1)) == false)
                return false;
            NumberValidate nv = new IntegerValidate();
            if(nv.validate(part) == false) return false;
            return true;
        }
    }

    public boolean isNumber(String s) {
        NumberValidate nv = new NumberValidator();
        return nv.validate(s);
    }
}
