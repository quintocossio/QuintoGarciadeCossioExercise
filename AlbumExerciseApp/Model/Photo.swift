//
//  Photo.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import Foundation

struct Photo:Decodable{
    
    var albumId: Int
    var id: Int
    var title:String
    var url:String
    var thumbnailUrl:String
}
