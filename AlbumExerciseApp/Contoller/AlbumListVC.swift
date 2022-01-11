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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
    


extension AlbumListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albums.isEmpty{
            return 0
        }
        
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.row]
        
        cell.titleLbl.text = album.title
        
        return cell
    }
    
    
    
}
