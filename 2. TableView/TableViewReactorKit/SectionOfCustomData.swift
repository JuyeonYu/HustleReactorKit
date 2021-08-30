import RxDataSources

enum MultipleSectionModel {
    case CommentSection(title: String, items: [SectionItem])
    case PostSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case CommentSectionItem(_: CommentModel)
    case PostSectionItem(_: PostModel)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch  self {
        case .CommentSection(title: _, items: let items):
            return items.map { $0 }
        case .PostSection(title: _, items: let items):
            return items.map { $0 }
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case .CommentSection(title: let title, items: _):
            self = .CommentSection(title: title, items: items)
        case .PostSection(title: let title, items: _):
            self = .PostSection(title: title, items: items)
        }
    }
}

extension MultipleSectionModel {
    var title: String {
        switch self {
        case .CommentSection(title: let title, items: _):
            return title
        case .PostSection(title: let title, items: _):
            return title
        }
    }
}
