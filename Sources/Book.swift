//
//  Book.swift
//  Apple Books Packager
//
//  Created by Colton Herrod on 9/29/24.
//

import Foundation
import EPUBKit

class Book {
    var title: String
    var author: String
    var path: String

    init(title: String, author: String, path: String) {
        self.title = title
        self.author = author
        self.path = path
    }
}