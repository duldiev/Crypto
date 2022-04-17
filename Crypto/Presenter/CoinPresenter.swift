//
//  Presenter.swift
//  Crypto
//
//  Created by Raiymbek Duldyiev on 17.04.2022.
//

import Foundation
import UIKit

typealias PresenterDelegate = CoinPresenterDelegate & UIViewController

protocol CoinPresenterDelegate: AnyObject {
    func presentCoins(coins: [Data])
    
    func didFailWithError(error: Error)
}

class CoinPresenter {
    
    weak var delegate: PresenterDelegate?
    
    private let urlString = "https://api.coincap.io/v2/assets"
    
    func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    func performRequest() {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    self?.delegate?.didFailWithError(error: error!)
                    return
                }
                do {
                    let safeData = try JSONDecoder().decode(Coin.self, from: data)
                    let coins = safeData.data
                    self?.delegate?.presentCoins(coins: coins)
                } catch {
                    self?.delegate?.didFailWithError(error: error)
                }
            }
            task.resume()
        }
    }
    
}
