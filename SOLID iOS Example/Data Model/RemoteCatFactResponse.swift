//
//  RemoteMovie.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 13/11/22.
//

import Foundation

struct RemoteCatFactResponse: Decodable {
    let current_page: Int
    let data: [RemoteCatFact]
    let first_page_url: URL
    let from, last_page: Int
    let last_page_url: URL
    let links: [RemoteLink]
    let next_page_url, path: URL
    let per_page: Int
    let prev_page_url: URL?
    let to, total: Int
}

struct RemoteCatFact: Decodable {
    let fact: String
    let length: Int
}

struct RemoteLink: Decodable {
    let url: String?
    let label: String
    let active: Bool
}
