//
//  TableViewController.swift
//  cryptocurrency
//
//  Created by apple on 31.08.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    let coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinManager.coins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptocurrency",
                                                 for: indexPath)
        
        let coin = coinManager.coins[indexPath.row]
        
        cell.textLabel?.text = coin
        cell.textLabel?.font.withSize(36)
        cell.textLabel?.numberOfLines = 0
        
        cell.detailTextLabel?.text = coinManager.getDetailCell(coin)
        cell.detailTextLabel?.font.withSize(18)
        
        
        cell.imageView?.image = UIImage(named: coin)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    

}
