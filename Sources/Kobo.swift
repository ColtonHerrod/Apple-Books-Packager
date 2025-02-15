import Foundation

class Kobo: Service {
    // Properties and methods specific to Kobo can be added here
    // Properties and methods specific to Apple Books can be added here
    let fileManager = FileManager.default

    enum CodingKeys: String, CodingKey {
        case defaultPath
        case currentBooks
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let defaultPath = try container.decode(String.self, forKey: .defaultPath)
        super.init(defaultPath: defaultPath, serviceName: "Kobo")
    }

    init() {
        super.init(defaultPath: FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Kobo").path, serviceName: "Kobo")
    }
}