//
//  MovieSearchTableViewController.swift
//  MyMovies
//
//  Created by Spencer Curtis on 8/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    @IBAction func addMovieTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? MovieTableViewCell else { return }
        
        if let indexPath = tableView.indexPath(for: cell) {
            MovieController.sharedInstance.createSavedMovie(title: MovieController.sharedInstance.searchedMovies[indexPath.row].title)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        MovieController.sharedInstance.searchForMovie(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.sharedInstance.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.movieRepresentation = MovieController.sharedInstance.searchedMovies[indexPath.row]
        
        return cell
    }
    
    //var movieController = MovieController()
    
    @IBOutlet weak var searchBar: UISearchBar!
}
