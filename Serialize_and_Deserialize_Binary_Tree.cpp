/*297. Serialize and Deserialize Binary Tree  QuestionEditorial Solution  My Submissions
Total Accepted: 27119
Total Submissions: 92241
Difficulty: Hard
Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

For example, you may serialize the following tree

    1
   / \
  2   3
     / \
    4   5
as "[1,2,3,null,null,4,5]", just the same as how LeetCode OJ serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.
Note: Do not use class member/global/static variables to store states. Your serialize and deserialize algorithms should be stateless.

Credits:
Special thanks to @Louis1992 for adding this problem and creating all test cases.

Subscribe to see which companies asked this question

Hide Company Tags LinkedIn Google Uber Facebook Amazon Microsoft Yahoo Bloomberg
Hide Tags Tree Design
Hide Similar Problems (M) Encode and Decode Strings

*/




/*serialize the tree DFS
Java: Use stringbuilder the append the root.val , once the root==null, append"X,"
C++: use ostringstream to add the root->val, once the root==NULL, add"# "

deserialize the tree
Java: first, according to the "," to split the string
then the node.val=="X", should add null, otherwise add the new node
C++: use istringstream, once val=="#", add the null, otherwise, add the new node*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Codec {
private:
    void serialize(TreeNode* root, ostringstream& out){
        if(root){
            out << root->val << ' ';
            serialize(root->left, out);
            serialize(root->right, out);
        } else {
            out << "# ";  //there is a " "(space) after "#"
        }
    }
    
    TreeNode* deserialize(istringstream& in){
        string val;
        in >> val;
        if(val == "#"){
            return nullptr;
        }
        
        TreeNode* root = new TreeNode(stoi(val));
        root->left = deserialize(in);
        root->right = deserialize(in);
        return root;
    }
    
public:

    // Encodes a tree to a single string.
    string serialize(TreeNode* root) {
        ostringstream out;
        serialize(root, out);
        return out.str();
    }

    // Decodes your encoded data to tree.
    TreeNode* deserialize(string data) {
        istringstream in(data);
        return deserialize(in);
    }
};

// Your Codec object will be instantiated and called as such:
// Codec codec;
// codec.deserialize(codec.serialize(root));







/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public class Codec {

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        StringBuilder str = new StringBuilder();
        buildString(str, root);
        return str.toString();
    }
    
    public void buildString(StringBuilder str, TreeNode node){
        if(node==null){
            str.append("X,");
        } else {
            str.append(node.val).append(",");
            buildString(str, node.left);
            buildString(str, node.right);
        }
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        List<String> str = new LinkedList<>();
        str.addAll(Arrays.asList(data.split(",")));
        return buildTree(str);
    }
    
    public TreeNode buildTree(List<String> str){
        String cur = str.remove(0); //always remove the first element
        if(cur.equals("X")){
            return null;
        }
        
        //valueOf(String s) --- returns an integer object holding the value of the specified string
        TreeNode node = new TreeNode(Integer.valueOf(cur));
        node.left = buildTree(str);
        node.right = buildTree(str);
        return node;
    }
}

// Your Codec object will be instantiated and called as such:
// Codec codec = new Codec();
// codec.deserialize(codec.serialize(root));