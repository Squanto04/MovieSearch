//
//  MovieController.swift
//  MovieSearch
//
//  Created by Jordan Lamb on 10/4/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

struct StringConstants {
    fileprivate static let moviesBaseURL = URL(string: "https://api.themoviedb.org/3/")
    fileprivate static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w200")
    fileprivate static let apiStarter = "api_key"
    fileprivate static let apiKey = "4caf00100d52dff3f9bdf164ef53f88a"
    fileprivate static let searchTerm = "search/"
    fileprivate static let movieTerm = "movie"
    fileprivate static let queryTerm = "query"
}

class MovieController {
    
    static func getMoviesWith(searchText: String, completion: @escaping ([Movies]) -> Void) {
        // Goal URL: https://api.themoviedb.org/3/search/movie?api_key=4caf00100d52dff3f9bdf164ef53f88a&query=Jack+Reacher
        guard var unwrappedURL = StringConstants.moviesBaseURL else {
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
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("There was an error decoding: \(error.localizedDescription)")
            }
            guard let data = data else {
                print("No movies were retreived.")
                completion([])
                return }
            do {
                let movies = try JSONDecoder().decode(MoviesTLD.self, from: data)
                completion(movies.results)
            } catch {
                print("There was an error decoding to movieDictionary object: \(error.localizedDescription)")
            }
        }
        dataTask.resume()
    }
    
    static func getImagefor(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        // Goal URL: http://image.tmdb.org/t/p/w200/adw6Lq9FiC9zjYEpOqfq03ituwp.jpg
        guard var newImageURL = StringConstants.imageBaseURL else { return }
        newImageURL.appendPathComponent(imageURL)
        print(newImageURL)
        
        let dataTask = URLSession.shared.dataTask(with: newImageURL) { (data, _, error) in
            if let error = error {
                print("There was an error decoding image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("There was no image data")
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
    
}
