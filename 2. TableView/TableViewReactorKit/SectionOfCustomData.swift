import RxDataSources

struct SectionOfCustomData {
  var header: String
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = CommentModel

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
