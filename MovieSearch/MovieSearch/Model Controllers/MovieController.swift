//
//  MovieController.swift
//  MovieSearch
//
//  Created by Jordan Lamb on 10/4/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

struct StringConstants {
    fileprivate static let baseURL = URL(string: "https://api.themoviedb.org/3/")
    fileprivate static let apiStarter = "api_key"
    fileprivate static let apiKey = "4caf00100d52dff3f9bdf164ef53f88a"
    fileprivate static let searchTerm = "search/"
    fileprivate static let movieTerm = "movie"
    fileprivate static let queryTerm = "query"
}

class MovieController {
    
    static func getMoviesWith(searchText: String, completion: @escaping ([Movies]) -> Void) {
        // Goal URL: https://api.themoviedb.org/3/search/movie?api_key=4caf00100d52dff3f9bdf164ef53f88a&query=Jack+Reacher
        guard var unwrappedURL = StringConstants.baseURL else {
            completion([]); return }
        unwrappedURL.appendPathComponent(StringConstants.searchTerm)
        unwrappedURL.appendPathComponent(StringConstants.movieTerm)
        guard var components = URLComponents(url: unwrappedURL, resolvingAgainstBaseURL: true) else {
            completion([]); return }
        let apiQuery = URLQueryItem(name: StringConstants.apiStarter, value: StringConstants.apiKey)
        let searchQuery = URLQueryItem(name: StringConstants.queryTerm, value: searchText)
        components.queryItems = [apiQuery, searchQuery]
        guard let finalURL = components.url else { return }
        print(finalURL)
    }
    
    static func getImagefor(movie: Movies, completion: @escaping (UIImage?) -> Void) {
        // Goal URL: http://image.tmdb.org/t/p/w200/adw6Lq9FiC9zjYEpOqfq03ituwp.jpg
    }
}
