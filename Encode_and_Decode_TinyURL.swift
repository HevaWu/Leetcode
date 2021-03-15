/*
Note: This is a companion problem to the System Design problem: Design TinyURL.
TinyURL is a URL shortening service where you enter a URL such as https://leetcode.com/problems/design-tinyurl and it returns a short URL such as http://tinyurl.com/4e9iAk.

Design the encode and decode methods for the TinyURL service. There is no restriction on how your encode/decode algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be decoded to the original URL.
*/

/*
https://leetcode.com/discuss/interview-question/124658/Design-a-URL-Shortener-(-TinyURL-)-System/

Solution: If you don't know about TinyURL, just check it. Basically we need a one to one mapping to get shorten URL which can retrieve original URL later. This will involve saving such data into database.
We should check the following things:

What's the traffic volume / length of the shortened URL?
What's the mapping function?
Single machine or multiple machines?
Traffic: Let's assume we want to serve more than 1000 billion URLs. If we can use 62 characters [A-Z, a-z, 0-9] for the short URLs having length n, then we can have total 62^n URLs. So, we should keep our URLs as short as possible given that it should fulfill the requirement. For our requirement, we should use n=7 i.e the length of short URLs will be 7 and we can serve 62^7 ~= 3500 billion URLs.

Basic solution:
To make things easier, we can assume the alias is something like http://tinyurl.com/<alias_hash> and alias_hash is a fixed length string.
To begin with, let’s store all the mappings in a single database. A straightforward approach is using alias_hash as the ID of each mapping, which can be generated as a random string of length 7.

Therefore, we can first just store <ID, URL>. When a user inputs a long URL “http://www.google.com”, the system creates a random 7-character string like “abcd123” as ID and inserts entry <“abcd123”, “http://www.google.com”> into the database.

In the run time, when someone visits http://tinyurl.com/abcd123, we look up by ID “abcd123” and redirect to the corresponding URL “http://www.google.com”.

Problem with this solution:
We can't generate unique hash values for the given long URL. In hashing, there may be collisions (2 long urls map to same short url) and we need a unique short url for every long url so that we can access long url back but hash is one way function.

Better Solution:

One of the most simple but also effective one, is to have a database table set up this way:

Table Tiny_Url(
ID : int PRIMARY_KEY AUTO_INC,
Original_url : varchar,
Short_url : varchar
)
Then the auto-incremental primary key ID is used to do the conversion: (ID, 10) <==> (short_url, BASE). Whenever you insert a new original_url, the query can return the new inserted ID, and use it to derive the short_url, save this short_url and send it to cilent.

Multiple machines:

If we are dealing with massive data of our service, distributed storage can increase our capacity. The idea is simple, get a hash code from original URL and go to corresponding machine then use the same process as a single machine. For routing to the correct node in cluster, Consistent Hashing is commonly used.

Following is the pseudo code for example,

Get shortened URL

hash original URL string to 2 digits as hashed value hash_val

use hash_val to locate machine on the ring

insert original URL into the database and use getShortURL function to get shortened URL short_url

Combine hash_val and short_url as our final_short_url (length=8) and return to the user

Retrieve original from short URL

get first two chars in final_short_url as hash_val

use hash_val to locate the machine

find the row in the table by rest of 6 chars in final_short_url as short_url

return original_url to the user

Other factors:

One thing I’d like to further discuss here is that by using GUID (Globally Unique Identifier) as the entry ID, what would be pros/cons versus incremental ID in this problem?

If you dig into the insert/query process, you will notice that using random string as IDs may sacrifice performance a little bit. More specifically, when you already have millions of records, insertion can be costly. Since IDs are not sequential, so every time a new record is inserted, the database needs to go look at the correct page for this ID. However, when using incremental IDs, insertion can be much easier – just go to the last page.

References: http://blog.gainlo.co/index.php/2016/03/08/system-design-interview-question-create-tinyurl-system/
https://www.geeksforgeeks.org/how-to-design-a-tiny-url-or-url-shortener/
*/

class Codec {
    // Encodes a URL to a shortened URL.
    func encode(_ longUrl: String) -> String {
        return TinyURL.shared.generateTinyURL(longUrl)
    }
    
    // Decodes a shortened URL to its original URL.
    func decode(_ shortUrl: String) -> String {
        return TinyURL.shared.getOriginalURL(shortUrl)
    }
}

class TinyURL {
    static let shared = TinyURL()
    
    private let letters: String = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
    private let shortUrlPrefix: String = "https://tinyURL/"  
    
    // key is longUrl
    // value is id
    private var map = [String: Int]()
    
    private var cache = [TinyURLObject]()
    private var curID: Int = 0
    
    private init() { }
    
    // auto-increase id
    func generateTinyURL(_ longUrl: String) -> String {
        if let id = map[longUrl] {
            return cache[id-1].shortUrl
        }
        
        curID += 1
        let shortUrl = genShortURLFromID(curID)
        let newObject = TinyURLObject(id: curID, originalUrl: longUrl, shortUrl: shortUrl)
        cache.append(newObject)
        map[longUrl] = curID
        return shortUrl
    }
    
    private func genShortURLFromID(_ id: Int) -> String {
        var id = id
        var short = [Character]()
        while id != 0 {
            short.insert(letters[letters.index(letters.startIndex, offsetBy: id % 62)], at: 0)
            id /= 62
        }
        return shortUrlPrefix+short
    }
    
    func getOriginalURL(_ shortUrl: String) -> String {
        let id = getIDFromShortUrl(shortUrl)
        // print(id, cache)
        return id == 0 ? "" : cache[id-1].originalUrl
    }
    
    private func getIDFromShortUrl(_ shortUrl: String) -> Int {
        if !shortUrl.hasPrefix(shortUrlPrefix) { return 0 }
        var shortUrl = shortUrl
        shortUrl.removeFirst(shortUrlPrefix.count)
        
        var id = 0
        
        for c in shortUrl {
            if c >= "a", c <= "z" {
                id = id*62 + Int(c.asciiValue! - Character("a").asciiValue!)
            } else if c >= "0", c <= "9" {
                id = id*62 + 26 + Int(c.asciiValue! - Character("0").asciiValue!)
            } else if c >= "A", c <= "Z" {
                id = id*62 + 36 + Int(c.asciiValue! - Character("A").asciiValue!)
            }
        }
        return id
    }
}

struct TinyURLObject {
    let id: Int
    let originalUrl: String
    let shortUrl: String
}

/**
 * Your Codec object will be instantiated and called as such:
 * let obj = Codec()
 * val s = obj.encode(longUrl)
 * let ans = obj.decode(s)
*/