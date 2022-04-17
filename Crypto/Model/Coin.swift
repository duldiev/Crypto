//
//  Crypto.swift
//  Crypto
//
//  Created by Raiymbek Duldyiev on 17.04.2022.
//

import Foundation

struct Coin: Codable {
    let data: [Data]
}

struct Data: Codable {
    let rank: String
    let symbol: String
    let name: String
    let supply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?
    
    init() {
        rank = ""
        symbol = ""
        name = ""
        supply = ""
        marketCapUsd = ""
        volumeUsd24Hr = ""
        priceUsd = ""
        changePercent24Hr = ""
        vwap24Hr = ""
        explorer = ""
    }
}
