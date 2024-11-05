# Challenge: Implement a Cache with Time-to-Live (TTL) using Property Wrappers

All code is in `PropertyWrapperCacheTests`.

## Problem Statement
You need to create a cache system that stores values in memory with an expiration time. Once a value’s TTL has expired, the cache should automatically return nil instead of the stored value. You will use a custom property wrapper to manage the cache, handle the TTL, and invalidate the values once the TTL is reached.

## Requirements:

1.	Create a property wrapper called Cached that will:
- Store a value of any type.
- Allow you to specify a TTL (in seconds).
- Invalidate the cached value after the TTL expires.
- Return nil once the TTL has expired.
2.	The cached values should persist as long as the TTL is valid. If the TTL is expired, accessing the property should trigger an invalidation and return nil.

## Example Usage:
```swift
struct MyDataModel {
    @Cached(ttl: 5) var cachedString: String? = "Hello, World!"
    
    func checkCache() {
        if let value = cachedString {
            print("Cached value: \(value)")
        } else {
            print("Cache expired or empty.")
        }
    }
}
```