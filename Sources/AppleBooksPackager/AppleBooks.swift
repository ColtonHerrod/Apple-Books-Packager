import Foundation

class AppleBooks: Service {
    // Properties and methods specific to Apple Books can be added here
    let fileManager = FileManager.default

    enum CodingKeys: String, CodingKey {
        case defaultPath
        case currentBooks
    }

    required init(from decoder: Decoder) throws {
        print("Decoding AppleBooks")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let defaultPath = try container.decode(String.self, forKey: .defaultPath)
        super.init(defaultPath: defaultPath, serviceName: "Apple Books")
    }

    init() throws {
        do {
            let libraryURL = try fileManager.url(
                for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false
            )
            var booksURL: URL
            // Inelegant way to check if tests are running
            if ProcessInfo.processInfo.environment["IS_UNIT_TESTING"] == "1" {
                // Code only executes when tests are running
                booksURL = URL(fileURLWithPath: "./Tests/PackagerTests/Books")
            } else {
                booksURL = libraryURL.appendingPathComponent(Constants.appleBooksBasePath)
            }
            super.init(defaultPath: booksURL.path, serviceName: "Apple Books")
        } catch {
            print("Error obtaining library URL: \(error)")
            super.init(defaultPath: "", serviceName: "Apple Books")
        }
    }
}
