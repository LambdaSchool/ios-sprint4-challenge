
import UIKit

class MovieSearchTableViewController: UITableViewController, UISearchBarDelegate, MovieSearchTableViewCellDelegate {
    
    func addMovie(cell: MovieSearchTableViewCell, movie: MovieRepresentation) {
        
        // Deal with saving it to Core Data with the MovieDataController, with the createMovie function
        // Give a movie back to the table view controller
        
        movieDataController?.createMovie(title: movie.title, hasWatched: false)

    
    }
    
    
    var movieController = MovieController()
    
    var movieDataController: MovieDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        
        movieController.searchForMovie(with: searchTerm) { (error) in
            
            guard error == nil else { return }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieController.searchedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.reuseIdentifier, for: indexPath) as? MovieSearchTableViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        cell.delegate = self
        
        // Let the cell know which movie was tapped by passing the movie to it
        // Now the cell itself knows which movie it is
        let tappedMovie = movieController.searchedMovies[indexPath.row]
        
        cell.movieRepresentation = tappedMovie
        
        //cell.movie = movieController.searchedMovies[indexPath.row]
        
        //cell.movieTitleLabel.text = movieController.searchedMovies[indexPath.row].title
        
        return cell
    }
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movie: Movie?
    
}
