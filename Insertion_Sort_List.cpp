/*147. Insertion Sort List  QuestionEditorial Solution  My Submissions
Total Accepted: 81309 Total Submissions: 264126 Difficulty: Medium
Sort a linked list using insertion sort.

Subscribe to see which companies asked this question*/



/*insertion sort O(1) space
set a new start node, then from the beginning of the list,
insert each list node into the new start node */

/////////////////////////////////////////////////////////////////////////////////////
//C++
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
    ListNode* insertionSortList(ListNode* head) {
        if(head==NULL) return head;

        ListNode begin(INT_MIN);
        while(head){
            ListNode* temp = &begin;
            while(temp->next && temp->next->val < head->val){
                temp = temp->next;//find the right place to insert
            }

            //insert
            ListNode* next = head->next;
            head->next = temp->next;
            temp->next = head;
            head = next;
        }

        return begin.next;
    }
};



