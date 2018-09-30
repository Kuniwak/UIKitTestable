import UIKit



public protocol KeyWindowReadWriterProtocol: KeyWindowReaderProtocol, KeyWindowWriterProtocol {}



public class KeyWindowReadWriter: KeyWindowReadWriterProtocol {
    private let reader: KeyWindowReaderProtocol
    private let writer: KeyWindowWriterProtocol


    public init(readingBy reader: KeyWindowReaderProtocol, writingBy writer: KeyWindowWriterProtocol) {
        self.reader = reader
        self.writer = writer
    }


    public convenience init(reading application: UIApplication, modifying window: UIWindow) {
        self.init(
            readingBy: KeyWindowReader(whoHaveKeyWindow: application),
            writingBy: KeyWindowWriter(modifying: window)
        )
    }


    public var keyWindow: UIWindow? {
        return self.reader.keyWindow
    }


    public func makeKey() {
        self.writer.makeKey()
    }


    public func becomeKey() {
        self.writer.becomeKey()
    }


    public func resignKey() {
        self.writer.resignKey()
    }
}