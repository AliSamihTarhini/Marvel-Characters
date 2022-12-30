//
//  md5Formation.swift
//  Marvel Caracters
//
//  Created by Ali Tarhini on 29/12/2022.
//

import Foundation
import CommonCrypto

struct md5Formation{
    let ts = "ali"
    let priKey = "15285456da938814aee4878ad7db5647706244b7"
    let pubKey = "f9b05d4f16c29186b37f36e297edb0d3"
     
    func generateMD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                    let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}
