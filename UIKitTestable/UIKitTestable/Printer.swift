public protocol PrinterProtocol {
    func print(_ x: String)
}



extension PrinterProtocol {
    public static func stub() -> PrinterStub {
        return PrinterStub()
    }


    public static func spy() -> PrinterSpy {
        return PrinterSpy()
    }
}



public struct StdoutPrinter: PrinterProtocol {
    public init() {}


    public func print(_ x: String) {
        Swift.print(x)
    }
}



public struct PrinterStub: PrinterProtocol {
    public init() {}


    public func print(_ x: String) {}
}



public class PrinterSpy: PrinterProtocol {
    public var inherited: PrinterProtocol
    public private(set) var lines: [String] = []


    public var printed: String {
        return self.lines.joined(separator: "\n")
    }


    public init(inherit inherited: PrinterProtocol = PrinterStub()) {
        self.inherited = inherited
    }


    public func print(_ x: String) {
        self.lines.append(x)
        self.inherited.print(x)
    }
}