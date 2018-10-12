public struct TypeName: Hashable {
    public let text: String


    public init(text: String) {
        self.text = text
    }


    public init(of any: Any) {
        self.init(text: "\(Mirror(reflecting: any).subjectType)")
    }
}
