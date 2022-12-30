//
//  APIUrl.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 29/12/2022.
//

import Foundation

class UrlBase {
    let hashing = md5Formation()
    
    let urlCharacters = "https://gateway.marvel.com:443/v1/public/characters?apikey=\(md5Formation().pubKey)&hash=\(md5Formation().generateMD5(string: "\(md5Formation().ts)\(md5Formation().priKey)\(md5Formation().pubKey)"))&ts=\(md5Formation().ts)"
    
    func getUrlComics(id: Int) -> String{
        return "https://gateway.marvel.com/v1/public/characters/\(id)/comics?apikey=\(md5Formation().pubKey)&hash=\(md5Formation().generateMD5(string: "\(md5Formation().ts)\(md5Formation().priKey)\(md5Formation().pubKey)"))&ts=\(md5Formation().ts)"
    }
    func getUrlEvents(id: Int) -> String{
        return "https://gateway.marvel.com/v1/public/characters/\(id)/events?apikey=\(md5Formation().pubKey)&hash=\(md5Formation().generateMD5(string: "\(md5Formation().ts)\(md5Formation().priKey)\(md5Formation().pubKey)"))&ts=\(md5Formation().ts)"
    }
    func getUrlSeries(id: Int) -> String{
        return "https://gateway.marvel.com/v1/public/characters/\(id)/series?apikey=\(md5Formation().pubKey)&hash=\(md5Formation().generateMD5(string: "\(md5Formation().ts)\(md5Formation().priKey)\(md5Formation().pubKey)"))&ts=\(md5Formation().ts)"
    }
    func getUrlStories(id: Int) -> String{
        return "https://gateway.marvel.com/v1/public/characters/\(id)/stories?apikey=\(md5Formation().pubKey)&hash=\(md5Formation().generateMD5(string: "\(md5Formation().ts)\(md5Formation().priKey)\(md5Formation().pubKey)"))&ts=\(md5Formation().ts)"
    }
}
