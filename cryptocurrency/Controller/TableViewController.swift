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
//        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinManager.coins.count
    }

    // MARK: - cell and tableview config.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cryptocurrency",for: indexPath)
        let coin = coinManager.coins[indexPath.row]
        
        cell.textLabel?.text = coin
        cell.textLabel?.font.withSize(36)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.init(name: "System", size: 18)
        
        cell.detailTextLabel?.text = coinManager.getDetailCell(coin)
        cell.detailTextLabel?.font.withSize(18)
        cell.detailTextLabel?.textAlignment = .justified
        cell.detailTextLabel?.font = UIFont.init(name: "System", size: 14)
        
        cell.imageView?.image = UIImage(named: coin)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    //MARK: - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as!  ViewController
            detailVC.coinName = coinManager.coins[indexPath.row]
        }
    }
    

}
