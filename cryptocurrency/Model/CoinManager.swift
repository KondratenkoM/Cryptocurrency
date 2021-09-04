//
//  CoinManager.swift
//  cryptocurrency
//
//  Created by apple on 31.08.2021.
//

import Foundation

protocol CoinManagerDelegate{
    func didFailWithError(error: Error)
    func didUpdateCoin(coin: String,price: Double)


}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "apikey=F8A7B421-B550-4230-BAF5-82C203601518"
    
    let coins = ["BTC","ETH","LTC","BCH","ZEC","XMR","DOGE"]
    let currency = ["USD","EUR","GBP","CAD","CNY","KRW","UAH"]
    
    var delegate: CoinManagerDelegate?
    
    
    
    //MARK: - JSON
    func getCoinPrice(_ currency: String, _ coin: String) {
        
        let urlString = "\(baseURL)/\(coin)/\(currency)?\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            guard let safeData = data else { return }
            if let coinPrice = self.parseJSON(safeData) {
                let priceString = String(format: "%.3f", coinPrice)
                self.delegate?.didUpdateCoin(coin: currency, price: coinPrice)
                print(priceString)
            }
        }
        task.resume()
    }
    
    func parseJSON( _ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    func getDetailCell(_ cellTitle: String) -> String{
        switch cellTitle {
        case "BTC":
            return "Bitecoin"
        case "ETH":
            return "Etherium"
        case "LTC":
            return "Litecoin"
        case "BCH":
            return "Bitecoin cash"
        case "ZEC":
            return "Zecash"
        case "XMR":
            return "Monero"
        default:
            return "Dogecoin"
        }
    }
    
    //MARK: - calculate cryptocurrency
    func returnCalculatedValue(_ price: Double, _ amount: Double) -> String{
        let calculatedValue = price * amount
        return String(format: "%.2f", calculatedValue)
    }
    
}
