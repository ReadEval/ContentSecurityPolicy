# ContentSecurityPolicy

A Swift library for defining
[Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
header values.

---

## Requirements

-   Swift 4.0+

## Installation

### Swift Package Manager

Add the ContentSecurityPolicy package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/ReadEval/ContentSecurityPolicy",
        from: "0.0.1"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

### Carthage

To use ContentSecurityPolicy in your Xcode project using Carthage,
specify it in `Cartfile`:

```
github "ReadEval/ContentSecurityPolicy" ~> 0.0.1
```

Then run the `carthage update` command to build the framework,
and drag the built ContentSecurityPolicy.framework into your Xcode project.

## Usage

Create a `ContentSecurityPolicy` object
using the designated initializer;
each parameter has a default values,
so you can specify only the directives relevant to your use case:

```swift
import ContentSecurityPolicy

let csp = ContentSecurityPolicy(
            defaultSrc: [.`self`],
            baseURI: URL(string: "https://readeval.press")!,
            upgradeInsecureRequests: true
          )
csp.policy
// default-src: 'self'; base-uri: https://readeval.press; upgrade-insecure-requests
```

You can use the computed `policy` property value
to set the `"Content-Security-Policy"` header on HTTP response headers.
Here's how you might do this using Vapor:

```swift
import Vapor

let response = response ...
response.headers["Content-Security-Policy"] = csp.policy
```

## License

MIT

## Contact

Read Evaluate Press, LLC
([@ReadEvalPress](https://twitter.com/ReadEvalPress))
