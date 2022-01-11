//
//  PhotoAlbumVC.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 11/01/2022.
//

import UIKit

class PhotoAlbumVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var album:Album?
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = album?.title
        
        loadAlbumPhotos()
        
        
    }
    
    func loadAlbumPhotos(){
        guard let albumId = album?.id else { return }
        NetworkManager.sharedManager.fetchPhotos(forAlbumId: albumId) { result in
            
            switch result{
            case .success(let photos):
                self.photos = photos
                
                print(photos)
                
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

extension PhotoAlbumVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if photos.isEmpty{
            return 0
        }
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension PhotoAlbumVC: UICollectionViewDelegateFlowLayout{
    
}
