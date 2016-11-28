/*355. Design Twitter  QuestionEditorial Solution  My Submissions
Total Accepted: 5807
Total Submissions: 24962
Difficulty: Medium
Design a simplified version of Twitter where users can post tweets, follow/unfollow another user and is able to see the 10 most recent tweets in the user's news feed. Your design should support the following methods:

postTweet(userId, tweetId): Compose a new tweet.
getNewsFeed(userId): Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent.
follow(followerId, followeeId): Follower follows a followee.
unfollow(followerId, followeeId): Follower unfollows a followee.
Example:

Twitter twitter = new Twitter();

// User 1 posts a new tweet (id = 5).
twitter.postTweet(1, 5);

// User 1's news feed should return a list with 1 tweet id -> [5].
twitter.getNewsFeed(1);

// User 1 follows user 2.
twitter.follow(1, 2);

// User 2 posts a new tweet (id = 6).
twitter.postTweet(2, 6);

// User 1's news feed should return a list with 2 tweet ids -> [6, 5].
// Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
twitter.getNewsFeed(1);

// User 1 unfollows user 2.
twitter.unfollow(1, 2);

// User 1's news feed should return a list with 1 tweet id -> [5],
// since user 1 is no longer following user 2.
twitter.getNewsFeed(1);
Subscribe to see which companies asked this question*/




/////////////////////////////////////////////////////////////////////////////////////
//C++
/*Complexity: O(1) post/follow/unfollow, O(k log n) newsfeed for getting k tweets from n followed users

Use std::vector to store tweets, std::unordered_set to store followed users, std::unordered_map to associate each user with their tweets and followed users.

Use a heap to merge most recent k tweets from followed users. std::make/push/pop_heap provide finer control than std::priority_queue.*/

class Twitter {
    struct Tweet{
        int time;
        int id;
        Tweet(int time, int id): time(time), id(id){}
    };
    
    unordered_map<int, vector<Tweet> > tweets; //array of tweets posted by userself
    unordered_map<int, unordered_set<int>> following; //array of tweets poseted by users followed by user
    int total_time;
    
public:
    /** Initialize your data structure here. */
    Twitter() {
        total_time = 0;
    }
    
    /** Compose a new tweet. */
    void postTweet(int userId, int tweetId) {
        tweets[userId].emplace_back(total_time++, tweetId);
    }
    
    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    vector<int> getNewsFeed(int userId) {
        vector<pair<Tweet*, Tweet*>> tpointer; //pair of pointers(begin, current)
        
        for(auto &u:following[userId]){
            auto &t = tweets[u];
            if(t.size() > 0){
                tpointer.emplace_back(t.data(), t.data() + t.size() - 1);
            }
        }
        
        auto &t = tweets[userId];
        if(t.size() > 0){
            tpointer.emplace_back(t.data(), t.data() + t.size() - 1);
        }
        
        auto f = [](const pair<Tweet*, Tweet*>& x, const pair<Tweet*, Tweet*>& y){
            return x.second->time < y.second->time;
        };
        
        make_heap(tpointer.begin(), tpointer.end(), f);
        
        const int n = 10;
        vector<int> ret;
        ret.reserve(n);
        for(int i = 0; i<n && !tpointer.empty(); ++i){
            pop_heap(tpointer.begin(), tpointer.end(), f);
            auto &tpointerBack = tpointer.back();
            ret.push_back(tpointerBack.second->id);
            
            if(tpointerBack.first == tpointerBack.second--){
                tpointer.pop_back();
            }else{
                push_heap(tpointer.begin(), tpointer.end(), f);
            }
        }
        
        return ret;
    }
    
    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    void follow(int followerId, int followeeId) {
        if(followerId != followeeId){
            following[followerId].insert(followeeId);
        }
    }
    
    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    void unfollow(int followerId, int followeeId) {
        following[followerId].erase(followeeId);
    }
};

/**
 * Your Twitter object will be instantiated and called as such:
 * Twitter obj = new Twitter();
 * obj.postTweet(userId,tweetId);
 * vector<int> param_2 = obj.getNewsFeed(userId);
 * obj.follow(followerId,followeeId);
 * obj.unfollow(followerId,followeeId);
 */







/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Twitter {
    private static int total_time = 0;
    private Map<Integer, User> userMap;
    
    private class Tweet{
        public int id;
        public int time;
        public Tweet next; //add next Tweet Link so that we can save a lot of time when we execute getNewsFeed
        
        public Tweet(int id){
            this.id = id;
            time = total_time++;
            next = null;
        }
    }
    
    //OO design so User can follow, unfollow and post itself
    public class User{
        public int id;
        public Set<Integer> followed;
        public Tweet tweet;
        
        public User(int id){
            this.id = id;
            followed = new HashSet<>();
            follow(id); //first follow itself
            tweet = null;
        }
        
        public void follow(int id){
            followed.add(id);
        }
        
        public void unfollow(int id){
            followed.remove(id);
        }
        
        public void post(int tweet_id){//everytime user post a new tweet, add it to the head of tweet list
            Tweet t = new Tweet(tweet_id);
            t.next = tweet;
            tweet = t;
        }
    }
    
    
    
    

    /** Initialize your data structure here. */
    public Twitter() {
        userMap = new HashMap<Integer, User>();
    }
    
    /** Compose a new tweet. */
    public void postTweet(int userId, int tweetId) {
        if(!userMap.containsKey(userId)){
            User u = new User(userId);
            userMap.put(userId, u);
        }
        userMap.get(userId).post(tweetId);
    }
    
    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    public List<Integer> getNewsFeed(int userId) {
        List<Integer> ret = new LinkedList<>();
        
        if(!userMap.containsKey(userId))
            return ret;
        
        //first, get all tweet lists from user including itself and all people it followed    
        Set<Integer> users = userMap.get(userId).followed;
        
        //then, add all tweet into a max heap
        PriorityQueue<Tweet> q = new PriorityQueue<Tweet>(users.size(), (a,b)->(b.time-a.time));
        
        for(int u:users){
            Tweet t = userMap.get(u).tweet;
            if(t!=null){ //if we add null to the head we are screwed
                q.add(t);
            }
        }
        
        //everytime we poll a tweet with largest time stamp from the heap
        //then we only need to add 9 tweets at most into this heap before the 10 most recent tweet
        int n = 0;
        while(!q.isEmpty() && n<10){
            Tweet t = q.poll();
            ret.add(t.id);
            n++;
            if(t.next != null){
                q.add(t.next);
            }
        }
        
        return ret;
    }
    
    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    public void follow(int followerId, int followeeId) {
        if(!userMap.containsKey(followerId)){
            User u = new User(followerId);
            userMap.put(followerId, u);
        }
        if(!userMap.containsKey(followeeId)){
            User u = new User(followeeId);
            userMap.put(followeeId, u);
        }
        userMap.get(followerId).follow(followeeId);
    }
    
    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    public void unfollow(int followerId, int followeeId) {
        if(!userMap.containsKey(followerId) || followerId==followeeId)
            return;
        userMap.get(followerId).unfollow(followeeId);
    }
}

/**
 * Your Twitter object will be instantiated and called as such:
 * Twitter obj = new Twitter();
 * obj.postTweet(userId,tweetId);
 * List<Integer> param_2 = obj.getNewsFeed(userId);
 * obj.follow(followerId,followeeId);
 * obj.unfollow(followerId,followeeId);
 */