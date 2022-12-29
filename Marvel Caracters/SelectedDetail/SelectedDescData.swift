//
//  SelectedDescData.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 28/12/2022.
//

import Foundation


struct SelectedDescData: Codable {
    let data: DescData
}
struct DescData: Codable{
    let results: [DescResult]
}
struct DescResult: Codable{
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
}
