//
//  MarvelCharactersData.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 27/12/2022.
//

import Foundation

struct MarvelCharctersData: Codable{
    let data: Data11
}
struct Data11: Codable{
    let results: [Results]
}
struct Results: Codable{
    let id: Int
    let name: String
    let thumbnail: Thumbnail
}
struct Thumbnail:Codable{
    let path: String
    let `extension`: String
}
