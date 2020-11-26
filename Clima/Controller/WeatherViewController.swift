//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{
    
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var gpsButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var city: String = ""
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        cityText.delegate = self
    }
    
    @IBAction func gpsButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        cityText.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /*  Asks the delegate whether to process the
         pressing of the Return button for the text field. */
        
        cityText.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        /* Asks the delegate whether to stop editing in the specified text field. */
        
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Enter City"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        /* Tells the delegate when editing stops for the specified text field,
         and the reason it stopped. */
        
        city = cityText.text ?? "City not entered"
        
        while city.last?.isWhitespace == true {
            city = String(city.dropLast() )
        }
        textField.text = ""
        weatherManager.fetchWeather(city)
        
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weatherModel: WeatherModel) {
//        conditionImageView.image = UIImage(systemName: weatherModel.symbol)
//        temperatureLabel.text = String(weatherModel.temp)
//        cityLabel.text = String(weatherModel.name)
        
        print(weatherModel)
    }
    
    
}

