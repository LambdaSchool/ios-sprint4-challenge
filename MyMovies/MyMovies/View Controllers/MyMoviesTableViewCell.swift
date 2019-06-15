//
//  MyMoviesTableViewCell.swift
//  MyMovies
//
//  Created by John Pitts on 6/14/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import CoreData

class MyMoviesTableViewCell: UITableViewCell, NSFetchedResultsControllerDelegate {

    @IBAction func watchedButtonTapped(_ sender: Any) {
        
        movie?.hasWatched.toggle()
        updateViews()
        
//        delegate?.toggleFeature(for: self)
    }
    
    
    private func updateViews() {
        
        guard let movie = movie else { return }
        myMovieLabel.text = movie.title
        
        if movie.hasWatched {
            watchedButton.setTitle("WATCHED!", for: .normal)
        } else {
            watchedButton.setTitle("not watched", for: .normal)
        }
        print("about to put the movie again")
        movieController?.put(movie: movie)
        
//        movieController?.deleteMovieFromServer(movie) { (error) in
//            if let error = error {
//                NSLog("Error deleting task from server: \(error)")
//                return
//            }
 //       }
        
        do {
            let moc = CoreDataStack.shared.mainContext
            try moc.save()
        } catch {
            NSLog("Error saving movie to CoreData mainContext: \(error)")
        }
        
//        let moc = CoreDataStack.shared.mainContext
//        movieController?.movie(forUUID: movie.identifier!, in: moc)
        
        
    }
    
    var movieController: MovieController?
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    var delegate: MyMoviesTableViewCellDelegate?
    
    
    @IBOutlet var myMovieLabel: UILabel!
    @IBOutlet var watchedButton: UIButton!
    

}
