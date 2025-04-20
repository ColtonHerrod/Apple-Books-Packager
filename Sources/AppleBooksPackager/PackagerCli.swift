import ArgumentParser
import BookLib

@main
struct PackagerCli: ParsableCommand, Decodable {
  @Option(help: "List of books to interact with.")
  public var bookList: String?

  @Option(help: "Action to perform on the books.")
  public var action: String?

  @Option(help: "Destination for the books.")
  public var destination: String?
  @Option(help: "Source for the books.")
  public var source: String?

  var appleBooks: AppleBooks = try! AppleBooks()

  public init() {
  }

  public func run() throws {
    // let kobo = Kobo()
    print("starting")

    if action == "copy" {
      for book in bookList!.split(separator: ",") {
        copyBook(bookTitle: String(book), destination: destination!)
      }
    } else if action == "remove" {
      removeBook()
    } else if action == "list" {
      print("Kobo Books:")
      // let koboList: [Book] = kobo.listBooks()
      // for book in koboList {
      //   print(book)
      // }
      print("Apple Books:")
      let appleBooksList = appleBooks.getBooks()
      for book in appleBooksList {
        print("Author: \(book.author), Title: \(book.title)")
      }
    } else if action == "list_services" || action == "services" {
      print("Kobo")
      print("Apple Books")
      print("Kindle")
      print("Calibre")
    } else {
      print("Please provide an action.")
    }
  }

  func copyBook(bookTitle: String, destination: String) {
    print("Copying \(bookTitle) to \(destination)...")
    let book = getAllBooks().first { $0.title == bookTitle }
    if book == nil {
      print("Book not found.")
      return
    }
    let destinationPath = (
      book?.serviceName == "Apple Books" ? self.appleBooks.defaultPath : ""
    )
    book!.copy(destinationPath: destinationPath)
  }

  func getAllBooks() -> [Book] {
    print("Getting all books...")
    var books: [Book] = []
    books.append(contentsOf: appleBooks.getBooks())
    return books
  }

  func removeBook() {
    print("Removing book...")
  }
}
