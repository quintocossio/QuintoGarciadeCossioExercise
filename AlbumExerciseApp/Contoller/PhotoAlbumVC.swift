//
//  PhotoAlbumVC.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 11/01/2022.
//

import UIKit
import SDWebImage

class PhotoAlbumVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var album:Album?
    var photos = [Photo]()
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = album?.title
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        loadAlbumPhotos()
        
        
    }
    
    func loadAlbumPhotos(){
        photos.removeAll()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let albumId = album?.id else {
            
            AlertManager.showAlert(title: "Ups!", message: "Album doesn't exist", vc: self) {
                
                self.loadAlbumPhotos()
            }
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            return
            
        }
        NetworkManager.sharedManager.fetchPhotos(forAlbumId: albumId) { result in
            
            switch result{
            case .success(let photos):
                self.photos = photos
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
                
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    switch error {
                    case .invalidData:
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        AlertManager.showAlert(title: "Error", message: "The data received from the server was invalid", vc: self) {
                            
                            self.loadAlbumPhotos()
                        }
                        
                    case .invalidURL:
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        AlertManager.showAlert(title: "Error", message: "There is an error trying to reach the server", vc: self) {
                            
                            self.loadAlbumPhotos()
                        }
                        
                    case .invalidResponse:
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        AlertManager.showAlert(title: "Error", message: "Invalid response from the server. Try again later", vc: self) {
                            
                            self.loadAlbumPhotos()
                        }
                        
                    case .unableToComplete:
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        AlertManager.showAlert(title: "Ups!", message: "Unable to complete your request at this time. Check your internet connection", vc: self) {
                            
                            self.loadAlbumPhotos()
                        }
                    }
                }
                

            
            }
            
        }
        
        
    }
    
    //MARK: - SEGUE METHODS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoAlbumVC_PhotoDetailVCSegue"{
            let photoDetailVC = segue.destination as! PhotoDetailVC
            
            if let sender = sender as? Photo{
                photoDetailVC.photo = sender
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        
        cell.set(photo: photo)
        cell.delegate = self
        
        return cell
    }
    
    
}

extension PhotoAlbumVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension PhotoAlbumVC: PhotoCollectionViewCellDelegate{
    func goToPhotoDetail(photo: Photo) {
        self.performSegue(withIdentifier: "photoAlbumVC_PhotoDetailVCSegue", sender: photo)
    }
}
