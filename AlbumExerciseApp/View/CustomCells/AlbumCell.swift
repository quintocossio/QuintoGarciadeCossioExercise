//
//  AlbumCell.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLbl.text = ""
    }
    

    

}
