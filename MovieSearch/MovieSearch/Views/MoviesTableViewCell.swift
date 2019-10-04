//
//  MoviesTableViewCell.swift
//  MovieSearch
//
//  Created by Jordan Lamb on 10/4/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    
    var movieItem: Movies? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let item = movieItem else { return }
        titleLabel.text = item.title
        ratingLabel.text = "Rating: \(item.voteAverage)"
        overviewTextLabel.text = item.overview
        overviewTextLabel.adjustsFontForContentSizeCategory = true
        overviewTextLabel.sizeToFit()
        moviePosterImageView.image = nil
        
        guard let getImage = item.image else { return }
        MovieController.getImagefor(imageURL: getImage) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = image
                }
            } else {
                print("Movie Poster was nil")
            }
        }
    }
}
