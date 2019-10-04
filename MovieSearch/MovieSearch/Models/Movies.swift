//
//  Movies.swift
//  MovieSearch
//
//  Created by Jordan Lamb on 10/4/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import Foundation

struct MoviesTLD: Decodable {
    let results: [Movies]
}


struct Movies: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case title
        case voteAverage = "vote_average"
        case overview
        case image = "poster_path"
    }
    
    let title: String
    let voteAverage: Double
    let overview: String
    let image: String?
}
