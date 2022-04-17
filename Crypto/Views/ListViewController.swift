//
//  ListViewController.swift
//  Crypto
//
//  Created by Raiymbek Duldyiev on 17.04.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var suggestionMessage: UILabel!
    
    let spinner = SpinnerViewController()
    
    private let presenter = CoinPresenter()
    private var coins = [Data]()
    private var selectedCoin = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        presenter.setViewDelegate(delegate: self)
        presenter.performRequest()
        
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        presenter.performRequest()
    }
    
    private func spinLoad() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.spinner.willMove(toParent: nil)
            self.spinner.view.removeFromSuperview()
            self.spinner.removeFromParent()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoreDetails" {
            let destinationVC = segue.destination as! CoinViewController
            destinationVC.coin = selectedCoin
        }
    }
    
}

// MARK: CoinPresenterDelegate

extension ListViewController: CoinPresenterDelegate {
    
    func presentCoins(coins: [Data]) {
        self.coins = coins
        
        DispatchQueue.main.async {
            self.suggestionMessage.isHidden = true
            self.spinLoad()
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        
        var message = error.localizedDescription.debugDescription
        message.removeLast()
        message = String(message.reversed())
        message.removeLast()
        message = String(message.reversed())
        
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
            self.suggestionMessage.isHidden = false
        }
    }
    
}

// MARK: TableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CoinCell
        cell.rankLabel.text = coins[indexPath.row].rank
        cell.coinLabel.text = "\(coins[indexPath.row].name) (\(coins[indexPath.row].symbol))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

// MARK: TableViewDelegate

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCoin = coins[indexPath.row]
        
        self.performSegue(withIdentifier: "MoreDetails", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

