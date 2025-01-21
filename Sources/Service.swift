import Foundation
import EPUBKit

class Service {
    // Add properties and methods for the Service class here
    let defaultPath: String
    var currentBooks: [Book] = []

    init(defaultPath: String) {
        self.defaultPath = defaultPath
        self.currentBooks = getCurrentBooks(path: defaultPath)
    }

    func getCurrentBooks(path: String) -> [Book] {
        let fileManager = FileManager.default
        var books: [Book] = []
        do {
            print("Getting books at:", path)
            let book_paths = try fileManager.contentsOfDirectory(atPath: path)

            for path in book_paths {
                let book_url = URL(fileURLWithPath: path)
                print("Getting book:", book_url.path)
                guard let book = EPUBDocument(url: book_url) else {
                    print("Failed to open book at \(book_url.path)")
                    continue
                }
                print(book)
                // let book_metadata = book!.metadata
                let book_title = (book.title)!
                let book_author = (book.author)!
                let new_book = Book(title: book_title, author: book_author, path: path)
                books.append(new_book)
                print(books)
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
}