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
    #expect(appleBooks != nil)
    #expect(appleBooks?.listBooks() != nil)
}