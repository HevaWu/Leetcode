/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode *temp;
    bool isPalindrome(ListNode* head) {
        temp = head;
        return checkNode(head);
    }
    
    bool checkNode(ListNode* head1)
    {
        if(head1 == NULL)
            return true;
        bool isPal;
        isPal = checkNode(head1->next) & (temp->val == head1->val);
        temp = temp->next;
        return isPal;
    }
};