import Foundation

struct QiitaModel: Codable {
    let urlStr: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case urlStr = "url"
        case title
    }
}
