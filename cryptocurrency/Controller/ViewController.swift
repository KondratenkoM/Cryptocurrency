//
//  ViewController.swift
//  cryptocurrency
//
//  Created by apple on 31.08.2021.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate{
    
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var amountTF: UITextField!
    
    
    var coinManager = CoinManager()
    let explanation = Explanation()
    
    var currencyName: String?
    var coinName: String?
    
    var coinValue: Double?
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        calcButton.setBackgroundImage(UIImage(named: coinName ?? "BTC"), for: .normal)
        topLabel.text = "\(coinName ?? "BTC") / \(currencyName ?? "USD")"
        
    }
    
    //MARK: - calculate button
    @IBAction func calButtonPressed(_ sender: UIButton) {
        
        amountTF.endEditing(true)
        
        guard let coinValue = coinValue else { return }
        let currencyAmount = amountTF.text?.toDouble() ?? 1.0
        let calculatedValue = coinManager.returnCalculatedValue(coinValue, currencyAmount)
        
        resultLabel.text = "\(calculatedValue) \(currencyName!)"
        
    }
    //MARK: - alert buttons
    @IBAction func abbreviationsAlert(_ sender: UIButton) {
        alert("Currency abbreviations", explanation.currencyExplanation)
    }
    
    @IBAction func needHelpAlert(_ sender: UIButton) {
        alert("Help", explanation.help)
    }
    
    
    //MARK: - picker config.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currency[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let name = coinManager.currency[row]
        currencyName = name
        topLabel.text = "\(coinName ?? "BTC") / \(currencyName ?? "USD")"

        guard let coinName = coinName else { return }
        coinManager.getCoinPrice(name, coinName)
        
    }
    
    
}

    //MARK: - string extension. to Double method

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
    //MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCoin(coin: String, price: Double) {
        DispatchQueue.main.async {
            self.coinValue = price
            
        }
    }
}
    //MARK: - hide keyboard, alert methods
extension ViewController{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func alert(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
    }
}


