//
//  Album.swift
//  AlbumExerciseApp
//
//  Created by Quinto Cossio on 10/01/2022.
//

import Foundation

struct Album: Identifiable, Decodable{
    
    var userId:Int
    var id:Int
    var title:String

}

struct AlbumResponse: Decodable {
    let request: [Album]
}
