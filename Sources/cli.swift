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

  public func run() throws {
    // let kobo = Kobo()
    print("starting")
    let appleBooks = AppleBooks()

    if action == "copy" {
      copyBook()
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
      let appleBooksList = appleBooks.listBooks()
      for book in appleBooksList {
        print(book)
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

  func copyBook() {
    print("Copying book...")
  }
  func removeBook() {
    print("Removing book...")
  }
}