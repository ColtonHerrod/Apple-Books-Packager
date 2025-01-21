import Foundation

class Kobo: Service {
    // Properties and methods specific to Kobo can be added here

    init() {
        super.init(defaultPath: FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Kobo").path)
    }
}