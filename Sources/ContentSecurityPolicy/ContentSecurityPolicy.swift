import Foundation

public struct ContentSecurityPolicy {
    public typealias MIMEType = String
    
    public struct Sources: Equatable, Hashable {
        public enum Source: Equatable, Hashable {
            public enum HashAlgorithm: String {
                case sha256, sha384, sha512
            }
            
            case `self`
            case unsafeInline
            case unsafeEval
            case strictDynamic
            case scheme(String)
            case host(String)
            case nonce(String)
            case hash(HashAlgorithm, Data)
        }
        
        public let value: String
        
        public static var all: Sources {
            return Sources(value: "*")
        }
        
        public static var none: Sources {
            return Sources(value: "'none'")
        }
        
        public init(_ sources: [Source]) {
            self.value = sources.map{ $0.description }.joined(separator: " ")
        }
        
        private init(value: String) {
            self.value = value
        }
    }
    
    /// default-src
    public var defaultSrc: Sources?
    
    /// base-uri
    public var baseURI: URL?
    
    /// child-src
    public var childSrc: Sources?
    
    /// connect-src
    public var connectSrc: Sources?
    
    /// font-src
    public var fontSrc: Sources?
    
    /// form-action
    public var formAction: Sources?
    
    /// frame-ancestors
    public var frameAncestors: Sources?
    
    /// frame-src
    public var frameSrc: Sources?
    
    /// img-src
    public var imgSrc: Sources?
    
    /// media-src
    public var mediaSrc: Sources?
    
    /// object-src
    public var objectSrc: Sources?
    
    /// plugin-types
    public var pluginTypes: [MIMEType]?
    
    /// report-uri
    public var reportURI: URL?
    
    /// srcipt-src
    public var scriptSrc: Sources?
    
    /// style-src
    public var styleSrc: Sources?
    
    /// upgrade-insecure-requests
    public var upgradeInsecureRequests: Bool = false
    
    /// worker-src
    public var workerSrc: Sources?
    
    public init(defaultSrc: Sources? = nil,
                baseURI: URL? = nil,
                childSrc: Sources? = nil,
                connectSrc: Sources? = nil,
                fontSrc: Sources? = nil,
                formAction: Sources? = nil,
                frameAncestors: Sources? = nil,
                frameSrc: Sources? = nil,
                imgSrc: Sources? = nil,
                mediaSrc: Sources? = nil,
                objectSrc: Sources? = nil,
                pluginTypes: [MIMEType]? = nil,
                reportURI: URL? = nil,
                scriptSrc: Sources? = nil,
                styleSrc: Sources? = nil,
                upgradeInsecureRequests: Bool = false,
                workerSrc: Sources? = nil)
    {
        self.defaultSrc = defaultSrc
        self.baseURI = baseURI
        self.childSrc = childSrc
        self.connectSrc = connectSrc
        self.fontSrc = fontSrc
        self.formAction = formAction
        self.frameAncestors = frameAncestors
        self.frameSrc = frameSrc
        self.imgSrc = imgSrc
        self.mediaSrc = mediaSrc
        self.objectSrc = objectSrc
        self.pluginTypes = pluginTypes
        self.reportURI = reportURI
        self.scriptSrc = scriptSrc
        self.styleSrc = styleSrc
        self.upgradeInsecureRequests = upgradeInsecureRequests
        self.workerSrc = workerSrc
    }
    
    public var policy: String {
        var directives: [String] = []
        
        if let defaultSrc = self.defaultSrc {
            directives.append("default-src: \(defaultSrc)")
        }
        
        if let baseURI = self.baseURI {
            directives.append("base-uri: \(baseURI.absoluteString)")
        }
        
        if let childSrc = self.childSrc {
            directives.append("child-src: \(childSrc)")
        }
        
        if let connectSrc = self.connectSrc {
            directives.append("connect-src: \(connectSrc)")
        }
        
        if let fontSrc = self.fontSrc {
            directives.append("font-src: \(fontSrc)")
        }
        
        if let formAction = self.formAction {
            directives.append("form-action: \(formAction)")
        }
        
        if let frameAncestors = self.frameAncestors {
            directives.append("frame-ancestors: \(frameAncestors)")
        }
        
        if let frameSrc = self.frameSrc {
            directives.append("frame-src: \(frameSrc)")
        }
        
        if let imgSrc = self.imgSrc {
            directives.append("img-src: \(imgSrc)")
        }
        
        if let mediaSrc = self.mediaSrc {
            directives.append("media-src: \(mediaSrc)")
        }
        
        if let objectSrc = self.objectSrc {
            directives.append("object-src: \(objectSrc)")
        }
        
        if let pluginTypes = self.pluginTypes {
            directives.append("plugin-types: \(pluginTypes.joined(separator: " "))")
        }
        
        if let reportURI = self.reportURI {
            directives.append("report-uri: \(reportURI.absoluteString)")
        }
        
        if let scriptSrc = self.scriptSrc {
            directives.append("script-src: \(scriptSrc)")
        }
        
        if let styleSrc = self.styleSrc {
            directives.append("style-src: \(styleSrc)")
        }
        
        if self.upgradeInsecureRequests {
            directives.append("upgrade-insecure-requests")
        }
        
        if let workerSrc = self.workerSrc {
            directives.append("worker-src: \(workerSrc)")
        }
        
        return directives.joined(separator: "; ")
    }
}

extension ContentSecurityPolicy: CustomStringConvertible {
    public var description: String {
        return policy
    }
}

extension ContentSecurityPolicy: CustomDebugStringConvertible {
    public var debugDescription: String {
        return policy.split(separator: ";").joined(separator: ";\n")
    }
}

extension ContentSecurityPolicy.Sources: CustomStringConvertible {
    public var description: String {
        return self.value
    }
}

extension ContentSecurityPolicy.Sources: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Source...) {
        self.init(elements)
    }
}

extension ContentSecurityPolicy.Sources: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .none
    }
}

extension ContentSecurityPolicy.Sources.Source: CustomStringConvertible {
    public var description: String {
        switch self {
        case .`self`:
            return "'self'"
        case .unsafeInline:
            return "'unsafe-inline'"
        case .unsafeEval:
            return "'unsafe-eval'"
        case .strictDynamic:
            return "'strict-dynamic'"
        case .scheme(let string):
            return string
        case .host(let string):
            return string
        case .nonce(let string):
            return "'nonce-\(string)'"
        case let .hash(algorithm, data):
            return "'\(algorithm)-\(data.base64EncodedString())'"
        }
    }
}
