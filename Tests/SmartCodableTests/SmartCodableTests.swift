import XCTest
@testable import SmartCodable

final class SmartCodableTests: XCTestCase {
    func testExample() {
        
        struct User: Codable, SmartCodable, SnakeCasable {
            var name: String
            var mobile: String
            var isRegister: Bool
            var info: TagInfo
            var num: Num
        }
        
        struct TagInfo: Codable, SmartCodable, SnakeCasable {
            var title: String
            var imageUrl: String
        }
        
        
        enum Num: Int, Codable, SmartCodable, SmartCaseable {
            case one = 1
            case two = 2
            case unkonwn
        }
        let json = Data(#"{ "num" : 4, "name" : "KK", "mobile" : "18888888888", "is_register" : "1", "info" : {"title" : "single", "image_url" : "https://www.baidu.com" }}"#.utf8)
        do {
            let user = try json.decoded() as User
            print(user)
        } catch {
            print(error)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
