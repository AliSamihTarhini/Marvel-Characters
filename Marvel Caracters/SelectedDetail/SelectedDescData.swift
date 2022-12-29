//
//  SelectedDescData.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import Foundation


struct SelectedDescData: Codable {
    let data: Data2
}
struct Data2: Codable{
    let results: [Results2]
}
struct Results2: Codable{
    let id: Int
    let title: String
    let thumbnail: Thumbnail
}
