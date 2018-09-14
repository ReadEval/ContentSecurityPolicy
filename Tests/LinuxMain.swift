import XCTest

import ContentSecurityPolicyTests

var tests = [XCTestCaseEntry]()
tests += ContentSecurityPolicyTests.allTests()
XCTMain(tests)