//
//  CoinManager.swift
//  cryptocurrency
//
//  Created by apple on 31.08.2021.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "apikey=F8A7B421-B550-4230-BAF5-82C203601518"
    
    let coins = ["BTC","ETH","LTC","BCH","ZEC","XMR","DOGE"]
    let currency = ["USD","EUR","GBP","CAD","CNY","KRW","UAH"]
    
    func getCoinPrice(_ currency: String, _ coin: String) -> String{
        
        return "\(baseURL)/\(coin)/\(currency)?\(apiKey)"
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
    
}
