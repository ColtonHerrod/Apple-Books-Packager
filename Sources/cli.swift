import ArgumentParser

@main
struct cli: ParsableCommand {
  @Option(help: "List of books to interact with.")
  public var bookList: String?

  @Option(help: "Action to perform on the books.")
  public var action: String?

  @Option(help: "Destination for the books.")
  public var to: String?
  @Option(help: "Source for the books.")
  public var from: String?

  var appleBooks: AppleBooks? = try? AppleBooks()

  public func run() throws {
    // let kobo = Kobo()
    print("starting")

    if action == "copy" {
      for book in bookList!.split(separator: ",") {
        copyBook(bookTitle: String(book), to: to!)
      }
    }
    else if action == "remove" {
      removeBook()
    }
    else if action == "list" {
      print("Kobo Books:")
      // let koboList: [Book] = kobo.listBooks()
      // for book in koboList {
      //   print(book)
      // }
      print("Apple Books:")
      let appleBooksList = appleBooks?.listBooks()
      for book in appleBooksList ?? [] {
        print("Author: \(book.author), Title: \(book.title)")
      }
    }
    else if action == "list_services" || action == "services" {
      print("Kobo")
      print("Apple Books")
      print("Kindle")  
      print("Calibre")
    }
    else {
      print("Please provide an action.")
    }
  }

  func copyBook(bookTitle: String, to: String) {
    print("Copying \(bookTitle) to \(to)...")
    let book = getAllBooks().first { $0.title == bookTitle }
    if book == nil {
      print("Book not found.")
      return
    }
    guard let destination_path = (book?.service_name == "Apple Books" ? appleBooks?.defaultPath : "") else { return  }
    book!.copy(destination_path: destination_path)
  }
  
  func getAllBooks() -> [Book] {
    print("Getting all books...")
    var books: [Book] = []
    books.append(contentsOf: appleBooks?.listBooks() ?? [])
    return books
  }
  
  func removeBook() {
    print("Removing book...")
  }
}