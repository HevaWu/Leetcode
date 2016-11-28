/*
Implement an iterator over a binary search tree (BST). Your iterator will be initialized with the root node of a BST.

Calling next() will return the next smallest number in the BST.

Note: next() and hasNext() should run in average O(1) time and uses O(h) memory, where h is the height of the tree.
*/





/*Use stack to store the node of the tree, always push the left node in the tree
next(): pop one node in the stack, then push the right node of current node into the stack
hasnext(): check if there is node in the stack*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for binary tree
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class BSTIterator {
    private:
    stack<TreeNode *> myStack;
public:
    BSTIterator(TreeNode *root) {
        pushNode(root);
    }

    /** @return whether we have a next smallest number */
    bool hasNext() {
        return !myStack.empty();
    }

    /** @return the next smallest number */
    int next() {
        TreeNode* node1 = myStack.top();
        myStack.pop();
        pushNode(node1->right);
        return node1->val;        
    }
    
    void pushNode(TreeNode *node){
        for(;node != NULL; myStack.push(node), node = node->left);  //always push the left node which has the small value
    }
};

/**
 * Your BSTIterator will be called like this:
 * BSTIterator i = BSTIterator(root);
 * while (i.hasNext()) cout << i.next();
 */








/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for binary tree
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */

public class BSTIterator {
    private Stack<TreeNode> myStack = new Stack<TreeNode>();

    public BSTIterator(TreeNode root) {
        pushNode(root);
    }
    
    public void pushNode(TreeNode node){
        for(; node != null; myStack.push(node), node = node.left);
    }

    /** @return whether we have a next smallest number */
    public boolean hasNext() {
        return !myStack.isEmpty();
    }

    /** @return the next smallest number */
    public int next() {
        TreeNode temNode = myStack.pop();
        pushNode(temNode.right);
        return temNode.val;
    }
}

/**
 * Your BSTIterator will be called like this:
 * BSTIterator i = new BSTIterator(root);
 * while (i.hasNext()) v[f()] = i.next();
 */