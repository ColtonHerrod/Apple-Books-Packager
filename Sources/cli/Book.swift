//
//  Book.swift
//  Apple Books Packager
//
//  Created by Colton Herrod on 9/29/24.
//

import Foundation
import EPUBKit

class Book: Decodable {
    var title: String
    var author: String
    var path: String
    var service_name: String

    init(title: String, author: String, path: String, service_name: String) {
        self.title = title
        self.author = author
        self.path = path
        self.service_name = service_name
    }

    func copy(destination_path: String) {
        print("Copying \(title) to \(destination_path)...")
        if destination_path == "" {
            print("Please provide a destination.")
            return
        }

        let fileManager = FileManager.default
        let bookURL = URL(fileURLWithPath: "\(path)/\(title).epub")
        let destinationURL = URL(fileURLWithPath: "\(destination_path)/\(title).epub")

        do {
            try fileManager.copyItem(at: bookURL, to: destinationURL)
            print("Copied \(title) to \(destination_path).")
        } catch {
            print("Failed to copy \(title) to \(destination_path): \(error)")
        }
    }
}