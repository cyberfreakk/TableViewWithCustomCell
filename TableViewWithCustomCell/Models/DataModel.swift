//
//  DataModel.swift
//  TableViewAssignment
//
//  Created by Arunesh Gupta on 08/10/23.
//

import Foundation

struct SearchData: Decodable {
    let query: Query
}

struct Query: Decodable {
    let pages: [String: Page]
}

struct Page: Decodable {
    let title: String
    let thumbnail: Thumbnail?
    let extract: String
}

struct Thumbnail: Decodable {
    let source: String
    let width, height: Int
}
