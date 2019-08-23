//
//  MovieSearchTableViewCell.swift
//  MyMovies
//
//  Created by Marlon Raskin on 8/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

	var movieController: MovieController?
	var movieRepresentation: MovieRepresentation?

	@IBOutlet weak var titleLabel: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	@IBAction func addMovieTapped(_ sender: UIButton) {
		guard let movieController = movieController,
			let movieRep = movieRepresentation else { return }

		movieController.addMovie(movieRepresentation: movieRep)

	}
}
