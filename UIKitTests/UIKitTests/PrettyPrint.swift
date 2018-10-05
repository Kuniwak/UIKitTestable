public protocol PrettyPrintable: CustomStringConvertible {
    var descriptionLines: [IndentedLine] { get }
}



extension PrettyPrintable {
    public var description: String {
        return format(self.descriptionLines)
    }
}



public indirect enum IndentedLine: Equatable {
    case indent(IndentedLine)
    case content(String)


    public func format(indentWidth: Int) -> String {
        switch self {
        case .indent(let line):
            let indent = String(repeating: " ", count: indentWidth)
            return indent + line.format(indentWidth: indentWidth)
        case .content(let content):
            return content
        }
    }
}



public func format<Lines: Sequence>(
    _ lines: Lines,
    indentWidth: Int = 4
) -> String where Lines.Element == IndentedLine {
    return lines
        .map { line in line.format(indentWidth: indentWidth) }
        .joined(separator: "\n")
}



public func indent<Lines: Sequence>(
    _ lines: Lines
) -> [IndentedLine] where Lines.Element == IndentedLine {
    return lines.map { .indent($0) }
}



public func lines<Lines: Sequence>(
    _ lines: Lines
) -> [IndentedLine] where Lines.Element == String {
    return lines.map { .content($0) }
}



public func section<Lines: Sequence>(
    name: String,
    body: Lines
) -> [IndentedLine] where Lines.Element == IndentedLine {
    return [.content("\(name):")] + indent(body)
}



public func sections<Sections: Sequence, Lines: Sequence>(
    _ sectionsInfo: Sections
) -> [IndentedLine] where Sections.Element == (name: String, body: Lines), Lines.Element == IndentedLine {
    let sectionLines = sectionsInfo.map { sectionInfo in
        return section(name: sectionInfo.name, body: sectionInfo.body)
    }

    let verticalSpace = [IndentedLine.content("")]

    return intersperse(sectionLines, verticalSpace).flatMap { $0 }
}



public func sections<Sections: Sequence, Lines: Sequence>(
    _ sectionsInfo: Sections
) -> [IndentedLine] where Sections.Element == Lines, Lines.Element == IndentedLine {
    return sections(sectionsInfo
        .enumerated()
        .map { (name: "\($0.0)", body: $0.1) })
}



public func descriptionList<Items: Sequence>(
    _ items: Items
) -> [IndentedLine] where Items.Element == (label: String, description: String) {
    return items.map { item in .content("\(item.label): \(item.description)") }
}