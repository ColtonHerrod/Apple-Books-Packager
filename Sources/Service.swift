import Foundation
import EPUBKit

class Service: Decodable {
    enum CodingKeys: String, CodingKey {
        case defaultPath
        case serviceName
        case currentBooks
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        defaultPath = try container.decode(String.self, forKey: .defaultPath)
        serviceName = try container.decode(String.self, forKey: .serviceName)
        currentBooks = try container.decode([Book].self, forKey: .currentBooks)
    }
    
    // Add properties and methods for the Service class here
    let defaultPath: String
    var serviceName: String
    var currentBooks: [Book] = []

    init(defaultPath: String, serviceName: String) {
        self.defaultPath = defaultPath
        self.serviceName = serviceName
        self.currentBooks = getCurrentBooks(path: defaultPath)
    }

    func getCurrentBooks(path: String) -> [Book] {
        let fileManager = FileManager.default
        var books: [Book] = []
        do {
            // print("Getting books at:", path)
            let book_paths = try fileManager.contentsOfDirectory(atPath: path)
            // print(book_paths)
            for book: String in book_paths {
                let book_url = URL(fileURLWithPath: "\(path)/\(book)")
                if book_url.pathExtension != "epub" {
                    // print("Skipping non-EPUB file:", book_url.path)
                    continue
                }
                guard let book = EPUBDocument(url: book_url) else {
                    print("Failed to open book at \(book_url.path)")
                    continue
                }
                // let book_metadata = book!.metadata
                let book_title = (book.title)!
                let book_author = (book.author)!
                let new_book = Book(title: book_title, author: book_author, path: path, service_name: serviceName)
                books.append(new_book)
            }
            return books
        } catch {
            print("Failed to list books: \(error)")
            return []
        }
    }

    func listBooks() -> [Book] {
        return currentBooks
    }

    func copyBook(bookTitle: String, to: String) {
        let book = currentBooks.first { $0.title == bookTitle }
        if book == nil {
            print("Book not found.")
            return
        }
        book!.copy(destination_path: to)
    }
}