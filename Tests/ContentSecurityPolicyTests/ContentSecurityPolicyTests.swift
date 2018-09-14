import XCTest
@testable import ContentSecurityPolicy

final class ContentSecurityPolicyTests: XCTestCase {
    func testExample() {
        let csp = ContentSecurityPolicy(
            defaultSrc: [.`self`],
            baseURI: URL(string: "https://readeval.press")!,
            upgradeInsecureRequests: true
        )
        
        let expected = """
        default-src: 'self'; base-uri: https://readeval.press; upgrade-insecure-requests
        """
        
        XCTAssertEqual(csp.policy, expected)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
