### HTTP Layout:

Abstraction that will allow to easily substitute the implementation for different cases. 

```
protocol HTTPClient {
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error>
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse)
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ())
}
```

implementation in `extension` of `URLSession`. This gives us the ability to substitute HTTPClient. For example, it will be convenient for testing.

```
extension URLSession: HTTPClient  {
    
    // HTTPClient implementation based on Combine
    func publisher(request: URLRequest) -> AnyPublisher<(data: Data, response: HTTPURLResponse), Error> {
        ...
    }
    
    // HTTPClient implementation based on Async/Await
    func data(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        ...
    }
    
    // HTTPClient implementation based on Callback
    func make(request: URLRequest, _ completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> ()) {
        ...
    }
}
```

**HTTPProvider**
Provides the ability to generate a query with data in a specific scenario.

### Testing

- The module is covered by **95% Tests**.
