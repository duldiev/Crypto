//
//  CryptoViewController.swift
//  Crypto
//
//  Created by Raiymbek Duldyiev on 17.04.2022.
//

import UIKit

var t = 1000000000000.00
var b = 1000000000.00
var m = 1000000.00
var k = 1000.00

class CoinViewController: UIViewController {

    @IBOutlet weak var priceValue: UILabel!
    @IBOutlet weak var marketCapValue: UILabel!
    @IBOutlet weak var vwapValue: UILabel!
    @IBOutlet weak var supplyValue: UILabel!
    @IBOutlet weak var volumeValue: UILabel!
    @IBOutlet weak var changeValue: UILabel!
    
    @IBOutlet weak var copiedDisplay: UIView!
    
    var coin = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(coin.name) (\(coin.symbol))"
        
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        priceValue.text = getPrecised(number: coin.priceUsd!, label: "price")
        marketCapValue.text = getPrecised(number: coin.marketCapUsd!, label: "market")
        vwapValue.text = getPrecised(number: coin.vwap24Hr!, label: "vwap")
        supplyValue.text = getPrecised(number: coin.supply!, label: "supply")
        volumeValue.text = getPrecised(number: coin.volumeUsd24Hr!, label: "vol")
        changeValue.text = getPrecised(number: coin.changePercent24Hr!, label: "change")
    }
    
    private func getPrecised(number: String, label: String) -> String {
        if number == "" { return number }
        let converted = Double(number)!
        
        switch label {
        case "change":
            if converted < 0.0 {
                changeValue.textColor = UIColor.red
                return "\(String(format: "%.2f", converted))%"
            } else {
                changeValue.textColor = UIColor.green
                return "+\(String(format: "%.2f", converted))%"
            }
        case "supply":
            return reduce(number: converted)
        default:
             return "$\(reduce(number: converted))"
        }
    }
    
    private func reduce(number: Double) -> String {
        var temp = number
        var sign = ""
        if temp / t < 1000 && temp / t > 1 {
            temp = temp / t
            sign = "t"
        } else if temp / b < 1000 && temp / b > 1 {
            temp = temp / b
            sign = "b"
        } else if temp / m < 1000 && temp / m > 1 {
            temp = temp / m
            sign = "m"
        } else if temp / k < 1000 && temp / k > 1 {
            temp = temp / k
            sign = "k"
        } else if temp < 1 {
            return String(format: "%.6f", temp)
        }
        
        return "\(String(format: "%.2f", temp))\(sign)"
    }
    
    @IBAction func exploreButtonPressed(_ sender: UIButton) {
        UIPasteboard.general.string = coin.explorer
        copiedDisplay.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.copiedDisplay.isHidden = true
        }
    }

}
