//
//  MovieListTableViewController.swift
//  MovieSearch
//
//  Created by Jordan Lamb on 10/4/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {
    
    var movies: [Movies] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 205
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
            !searchText.isEmpty
            else { return }
        MovieController.getMoviesWith(searchText: searchText) { (results) in
            if !results.isEmpty {
                self.movies = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchBar.text = ""
                    self.searchBar.resignFirstResponder()
                }
            } else {
                DispatchQueue.main.async {
                    self.noMoviesFound()
                }
            }
        }
    }
    
    func noMoviesFound() {
        let alert = UIAlertController(title: "No Movies Found", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as? MoviesTableViewCell
        let searchResultItem = self.movies[indexPath.row]
        cell?.movieItem = searchResultItem
        
        return cell ?? UITableViewCell()
    }
}
