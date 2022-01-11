//
//  PhotoDetailVC.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 11/01/2022.
//

import UIKit

class PhotoDetailVC: UIViewController {

    @IBOutlet weak var photoImgView: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let zoomGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.zoomImage))
        photoImgView.isUserInteractionEnabled = true
        photoImgView.addGestureRecognizer(zoomGesture)
        
        self.title = photo?.title
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        if let photoStr = photo?.url{
            let photoURL = URL(string: photoStr)
            photoImgView.sd_setImage(with: photoURL)
            

        }else{
            photoImgView.image = UIImage(named: "placeholder")

        }
        

    }
    

    @objc func zoomImage(sender: UIPinchGestureRecognizer){
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
        
    }

}
