//
//  AlbumCell.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import UIKit

protocol AlbumCellDelegate {
    func goToPhotos(forAlbum:Album)
}

class AlbumCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    var album:Album?
    var delegate: AlbumCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLbl.text = ""
        
        let tapGestureForCell = UITapGestureRecognizer(target: self, action: #selector(self.cellPressed))
        addGestureRecognizer(tapGestureForCell)
        isUserInteractionEnabled = true
    }
    
    func set(album: Album){
        self.album = album
        
        titleLbl.text = album.title
        
    }
    

    @objc func cellPressed(){
        if let album = self.album{
            delegate?.goToPhotos(forAlbum: album)
        }
        
    }
    

}
