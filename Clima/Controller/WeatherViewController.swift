//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var gpsButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var city: String = ""
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        weatherManager.delegate = self
        cityText.delegate = self
        locationManager.requestLocation()
    }
}


// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    
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
        print(city)
        weatherManager.fetchWeather(for: city)
        
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weatherModel: WeatherModel) {
            DispatchQueue.main.async {
                self.conditionImageView.image = UIImage(systemName: weatherModel.symbol)
                self.temperatureLabel.text = weatherModel.temperatureString
                self.cityLabel.text = weatherModel.city
            }
        print(weatherModel)
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

// MARK: - LocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
    
    @IBAction func gpsButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            print(location.coordinate)
            weatherManager.fetchWeather(with: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
