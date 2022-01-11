//
//  PhotoCollectionViewCell.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 11/01/2022.
//

import UIKit

protocol PhotoCollectionViewCellDelegate{
    func goToPhotoDetail(withId: Int)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImgView: UIImageView!
    
    var photo:Photo?
    var delegate: PhotoCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureForCell = UITapGestureRecognizer(target: self, action: #selector(self.cellPressed))
        addGestureRecognizer(tapGestureForCell)
        isUserInteractionEnabled = true
    }
    
    func set(photo:Photo){
        self.photo = photo
        
        if let photoThumbnailStr = self.photo?.thumbnailUrl{
            let photoThumbnailUrl = URL(string: photoThumbnailStr)
            self.photoImgView.sd_setImage(with: photoThumbnailUrl)
        }else{
            
            self.photoImgView.image = UIImage(named: "placeholder")
            
        }
        
    }
    
    
    @objc func cellPressed(){
        if let photo = self.photo{
            delegate?.goToPhotoDetail(withId: photo.id)
        }
    }
}
