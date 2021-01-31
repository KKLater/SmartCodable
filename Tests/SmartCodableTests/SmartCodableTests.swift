import XCTest
@testable import SmartCodable

final class SmartCodableTests: XCTestCase {
    func testExample() {
        
        struct User: Codable, SmartCodable, SnakeCasable {
            var name: String
            var mobile: String
            var isRegister: Bool
            var info: TagInfo
        }
        
        struct TagInfo: Codable, SmartCodable, SnakeCasable {
            var title: String
            var imageUrl: String
        }
        
        let json = Data(#"{"name" : "KK", "mobile" : "18888888888", "is_register" : "1", "info" : {"title" : "single", "image_url" : "https://www.baidu.com" }}"#.utf8)
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
