//
//  RemoteMovie.swift
//  SOLID iOS Example
//
//  Created by Azam Mukhtar on 13/11/22.
//

import Foundation

struct RemoteMovie: Decodable {
    let id, title, original_title, original_title_romanised: String
    let image, movie_banner: URL
    let description, director, producer, release_date: String
    let running_time, rt_score: String
    let people, species, locations, vehicles: [String]
    let url: String
}
