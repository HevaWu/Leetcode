/*23. Merge k Sorted Lists  QuestionEditorial Solution  My Submissions
Total Accepted: 108022 Total Submissions: 430858 Difficulty: Hard
Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

Hide Company Tags LinkedIn Google Uber Airbnb Facebook Twitter Amazon Microsoft
Hide Tags Divide and Conquer Linked List Heap
Hide Similar Problems (E) Merge Two Sorted Lists (M) Ugly Number II
*/



/*O(nlogk) n is the total elments, k means the size of list
each time merge two list,then combine them together
once merging the first two lists, remove them from the vector, and add new lists in
merge two list --- two list pointer to finish it*/

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
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        if(lists.empty()) return NULL;
        if(lists.size()==1) return lists[0];
        if(lists.size()==2) return mergeTwoList(lists[0],lists[1]);
        vector<ListNode*> first(&lists[0],&lists[lists.size()/2]);
        vector<ListNode*> second(&lists[lists.size()/2],&lists[lists.size()]);
        return mergeTwoList(
                mergeKLists(first), mergeKLists(second));
        /*
        while(lists.size()>1){
            lists.push_back(mergeTwoList(lists[0],lists[1]));
            lists.erase(lists.begin());//remove first two lists
            lists.erase(lists.begin());
        }
        return lists.front();*/
    }
    
    ListNode* mergeTwoList(ListNode *l1, ListNode *l2){
        if(l1==NULL) return l2;
        if(l2==NULL) return l1;
        if(l1->val <= l2->val){
            l1->next = mergeTwoList(l1->next,l2);
            return l1;
        } else {
            l2->next = mergeTwoList(l1,l2->next);
            return l2;
        }
    }
};


/* O(nlogk) n is the total elments, k means the size of list
each time merge two list
merge two list --- set a head listnode and cur listnode*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode mergeKLists(ListNode[] lists) {
    	//frist transfer array to arraylist
        ArrayList<ListNode> list = new ArrayList<>(Arrays.asList(lists));
        if(list.size() == 0) return null;
        if(list.size() == 1) return list.get(0);
        if(list.size() == 2) return mergeTwoList(list.get(0),list.get(1));

        //when do sublist, transfer arraylist to array
        return mergeTwoList(
                mergeKLists(list.subList(0, list.size()/2)
                                .toArray(new ListNode[list.size()/2])),
                mergeKLists(list.subList(list.size()/2,list.size())
                                .toArray(new ListNode[list.size()-list.size()/2])));
    }
    
    public ListNode mergeTwoList(ListNode l1, ListNode l2){
        if(l1==null) return l2;
        if(l2==null) return l1;
        
        ListNode head=null;
        ListNode cur = null;
        while(l1!=null && l2!=null){
            if(l1.val <= l2.val){
                if(cur==null){
                    cur = l1;
                } else {
                    cur.next = l1;
                }
                
                if(head==null){
                    head = cur;
                } else {
                    cur = cur.next;
                }
                
                l1 = l1.next; // remember change it into the next one
            } else {
                if(cur==null){
                    cur = l2;
                } else {
                    cur.next = l2;
                }
                
                if(head==null){
                    head = cur;
                } else {
                    cur = cur.next;
                }
                
                l2 = l2.next;
            }
        }
        
        //since end, there must be one list is null
        if(l2!=null) l1 = l2;  //l1 is already null, copy l2 into l1
        cur.next = l1; //insert the last element
        return head;
    }
}
