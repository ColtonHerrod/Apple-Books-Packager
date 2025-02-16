//
//  TestTests.swift
//  cliTests
//
//  Created by Colton Herrod on 2/16/25.
//

import Testing
@testable import PackagerCli

@Test func testExample() {
    let result = 1 + 1
    #expect(result == 2)
}

@Test func testAppleBooks() {
    let appleBooks = try? AppleBooks()
    let book = Book(title: "Metamorphoses", author: "Ovid", path: "Test", serviceName: "Apple Books")
    #expect(appleBooks != nil)
    let bookList = appleBooks?.listBooks()
    #expect(bookList != nil)
    #expect(bookList?.count == 1)
    #expect(bookList?.first?.title == book.title)
    #expect(bookList?.first?.author == book.author)
    #expect(bookList?.first?.serviceName == book.serviceName)
}