public typealias ArrayLongerThan0<Element> = [Element]
public typealias ArrayLongerThan1<Element> = PrefixedArray<Element, ArrayLongerThan0<Element>>
public typealias ArrayLongerThan2<Element> = PrefixedArray<Element, ArrayLongerThan1<Element>>



public struct PrefixedArray<Element, RestElements> {
    public let prefix: Element
    public let rest: RestElements


    public var first: Element {
        return self.prefix
    }


    public init(prefix: Element, _ rest: RestElements) {
        self.prefix = prefix
        self.rest = rest
    }


    public func dropFirst() -> RestElements {
        return self.rest
    }
}



extension PrefixedArray: Equatable where Element: Equatable, RestElements: Equatable {
    public static func ==(lhs: PrefixedArray<Element, RestElements>, rhs: PrefixedArray<Element, RestElements>) -> Bool {
        return lhs.prefix == rhs.prefix
            && lhs.rest == rhs.rest
    }
}



extension PrefixedArray: Hashable where Element: Hashable, RestElements: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.prefix)
        hasher.combine(self.rest)
    }
}



extension PrefixedArray where RestElements == ArrayLongerThan0<Element> {
    public var count: Int {
        return self.rest.count + 1
    }


    public var last: Element {
        guard let last = self.rest.last else {
            return self.first
        }
        return last
    }


    public var secondLast: Element? {
        guard let array1 = ArrayLongerThan1(self.rest) else {
            return nil
        }

        guard let array2 = ArrayLongerThan2(array1) else {
            return self.first
        }

        return array2.secondLast
    }


    // TODO: Implement memory views
    public subscript(_ range: Range<Int>) -> ArrayLongerThan0<Element> {
        return Array(self.relaxed()[range])
    }


    public init?<C: Collection>(_ array: C) where C.Element == Element {
        guard let first = array.first else {
            return nil
        }

        self.init(prefix: first, Array(array.dropFirst()))
    }


    public init<C: Collection>(suffix: Element, _ array: C) where C.Element == Element {
        guard let first = array.first else {
            self.init(prefix: suffix, [])
            return
        }

        var rest = Array(array.dropFirst())
        rest.append(suffix)

        self.init(prefix: first, rest)
    }


    public func map<TransformedElement>(
        _ f: (Element) -> TransformedElement
    ) -> ArrayLongerThan1<TransformedElement> {
        return ArrayLongerThan1<TransformedElement>(
            prefix: f(self.prefix),
            self.rest.map(f)
        )
    }


    public func compactMap<TransformedElement>(
        _ f: (Element) -> TransformedElement?
    ) -> ArrayLongerThan0<TransformedElement> {
        return self.relaxed().compactMap(f)
    }


    public func flatMap<TransformedElement, S: Sequence>(
        _ f: (Element) -> S
    ) -> ArrayLongerThan0<TransformedElement> where S.Element == TransformedElement {
        return self.relaxed().flatMap(f)
    }


    public func filter(_ f: (Element) -> Bool) -> ArrayLongerThan0<Element> {
        return self.relaxed().filter(f)
    }


    public func enumerated() -> ArrayLongerThan1<(Int, Element)> {
       return ArrayLongerThan1(
           prefix: (0, self.first),
           self.rest.enumerated().map { indexAndElement in
               let (index, element) = indexAndElement
               return (index + 1, element)
           }
       )
    }


    public mutating func append(_ newElement: Element) {
        var newRest = self.rest
        newRest.append(newElement)

        self = ArrayLongerThan1(
            prefix: self.prefix,
            newRest
        )
    }


    public func relaxed() -> ArrayLongerThan0<Element> {
        return [self.prefix] + self.rest
    }
}



extension PrefixedArray where Element == String, RestElements == ArrayLongerThan0<String> {
    public func joined(separator: String) -> String {
        return self.relaxed().joined(separator: separator)
    }
}



extension PrefixedArray where RestElements == ArrayLongerThan1<Element> {
    public var count: Int {
        return self.rest.count + 1
    }


    public var second: Element {
        return self.rest.first
    }


    public var last: Element {
        return self.rest.last
    }


    public var secondLast: Element {
        guard let secondLast = self.rest.secondLast else {
            return self.first
        }

        return secondLast
    }


    // TODO: Implement memory views
    public subscript(_ range: Range<Int>) -> ArrayLongerThan0<Element> {
        return Array(self.relaxed()[range])
    }


    public init?<C: Collection>(_ array: C) where C.Element == Element, C.Index == Int {
        guard array.count >= 2 else {
            return nil
        }

        self.init(
            prefix: array[0],
            ArrayLongerThan1<Element>(
                prefix: array[1],
                Array(array.dropFirst(2))
            )
        )
    }


    public init?(_ array: ArrayLongerThan1<Element>) {
        self.init(array.relaxed())
    }


    public func map<TransformedElement>(
        _ f: (Element) -> TransformedElement
    ) -> ArrayLongerThan2<TransformedElement> {
        return .init(prefix: f(self.prefix), self.rest.map(f))
    }


    public func compactMap<TransformedElement>(
        _ f: (Element) -> TransformedElement?
    ) -> ArrayLongerThan0<TransformedElement> {
        return self.relaxed().compactMap(f)
    }


    public func flatMap<TransformedElement, S: Sequence>(
        _ f: (Element) -> S
    ) -> ArrayLongerThan0<TransformedElement> where S.Element == TransformedElement {
        return self.relaxed().flatMap(f)
    }


    public func filter(_ f: (Element) -> Bool) -> ArrayLongerThan0<Element> {
        return self.relaxed().filter(f)
    }


    public func enumerated() -> ArrayLongerThan2<(Int, Element)> {
        return ArrayLongerThan2(
            prefix: (0, self.first),
            self.rest.enumerated().map { indexAndElement in
                let (index, element) = indexAndElement
                return (index + 1, element)
            }
        )
    }


    public mutating func append(_ newElement: Element) {
        var newRest = self.rest
        newRest.append(newElement)

        self = ArrayLongerThan2(
            prefix: self.prefix,
            newRest
        )
    }


    public func relaxed() -> ArrayLongerThan1<Element> {
        return .init(prefix: self.prefix, self.rest.relaxed())
    }
}



extension PrefixedArray where Element == String, RestElements == ArrayLongerThan1<String> {
    public func joined(separator: String) -> String {
        return self.relaxed().joined(separator: separator)
    }
}



public func zip<Element>(
    _ a: ArrayLongerThan1<Element>,
    _ b: ArrayLongerThan1<Element>
) -> ArrayLongerThan1<(Element, Element)> {
    return ArrayLongerThan1<(Element, Element)>(
        prefix: (a.prefix, b.prefix),
        Array(Swift.zip(a.rest, b.rest))
    )
}



public func zip<Element>(
    _ a: ArrayLongerThan2<Element>,
    _ b: ArrayLongerThan2<Element>
) -> ArrayLongerThan2<(Element, Element)> {
    return ArrayLongerThan2<(Element, Element)>(
        prefix: (a.prefix, b.prefix),
        zip(a.rest, b.rest)
    )
}



public func zip<A, B, C, AS: Sequence, BS: Sequence, CS: Sequence>(
    _ a: AS,
    _ b: BS,
    _ c: CS
) -> [(A, B, C)] where AS.Element == A, BS.Element == B, CS.Element == C {
    return zip(zip(a, b), c)
        .map {
            let ((a, b), c) = $0
            return (a, b, c)
        }
}



public func zip<A, B, C>(
    _ a: ArrayLongerThan1<A>,
    _ b: ArrayLongerThan1<B>,
    _ c: ArrayLongerThan1<C>
) -> ArrayLongerThan1<(A, B, C)> {
    return ArrayLongerThan1(
        prefix: (a.first, b.first, c.first),
        zip(a.rest, b.rest, c.rest)
    )
}



public func zip<A, B, C>(
    _ a: ArrayLongerThan2<A>,
    _ b: ArrayLongerThan2<B>,
    _ c: ArrayLongerThan2<C>
) -> ArrayLongerThan2<(A, B, C)> {
    return ArrayLongerThan2(
        prefix: (a.first, b.first, c.first),
        zip(a.rest, b.rest, c.rest)
    )
}
