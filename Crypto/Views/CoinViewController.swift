//
//  CryptoViewController.swift
//  Crypto
//
//  Created by Raiymbek Duldyiev on 17.04.2022.
//

import UIKit

class CoinViewController: UIViewController {

    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var marketCapValue: UILabel!
    @IBOutlet weak var vwapValue: UILabel!
    @IBOutlet weak var supplyValue: UILabel!
    @IBOutlet weak var volumeValue: UILabel!
    @IBOutlet weak var changeValue: UILabel!
    
    var coin = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = coin.name
        
        priceValue.text = coin.priceUsd
        marketCapValue.text = coin.marketCapUsd
    }
    
    @IBAction func exploreButtonPressed(_ sender: UIButton) {
        
    }

}
