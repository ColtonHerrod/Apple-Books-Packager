import Foundation

class AppleBooks: Service {
    // Properties and methods specific to Kobo can be added here
    let basePath: String = "Mobile Documents/iCloud\\~com\\~apple\\~iBooks/Documents/"
    let fileManager = FileManager.default
    
    init() {
        do {
            let libraryURL = try fileManager.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let booksURL = libraryURL.appendingPathComponent(basePath)
            print(booksURL)
            super.init(defaultPath: booksURL.path)
        } catch {
            print("Error obtaining library URL: \(error)")
            super.init(defaultPath: "")
        }
    }
}