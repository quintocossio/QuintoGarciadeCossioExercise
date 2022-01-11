//
//  AlbumListVC.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import UIKit

class AlbumListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var albums = [Album]()
    var filteredAlbums = [Album]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar Album..."
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = false

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        loadAlbums()

    }
    
    
    func loadAlbums(){
        
        NetworkManager.sharedManager.fetchAlbums { result in
            switch result{
            case .success(let albums):
                self.albums = albums
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case .invalidData:
                    print("The data received from the server was invalid")
                    
                case .invalidURL:
                    print("There is an error trying to reach the server")
                    
                case .invalidResponse:
                    print("Invalid response from the server. Try again later")
                    
                case .unableToComplete:
                    print("Unable to complete your request at this time. Try again later.")
                }
                }
            }
        }
    
    //MARK: - SEARCH METHODS
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredAlbums = albums.filter({ (album: Album) -> Bool in
            return album.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
        
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
        
}
    


extension AlbumListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albums.isEmpty{
            return 0
        }
        
        if isFiltering(){
            return filteredAlbums.count
        }
        
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        let album:Album
        
        if isFiltering(){
            album = filteredAlbums[indexPath.row]
        }else{
            album = albums[indexPath.row]
        }
        
        cell.titleLbl.text = album.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension AlbumListVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
