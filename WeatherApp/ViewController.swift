//
//  ViewController.swift
//  WeatherApp
//
//  Created by Anna Abdeeva on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }


}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let urlString = "http://api.weatherstack.com/current?access_key =f80a02ccec392599639be314d56e5596&query=\(searchBar.text!)"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                }
                    
                if let current = json["current"] {
                    temperature = current["temperature"] as? Double
                }
                
                DispatchQueue.main.async {
                    self?.cityLabel.text = locationName
                    self?.temperatureLabel.text = "\(temperature)"
                }
                
            }
            
            catch let jsonError {
                print(jsonError)
            }
        }
        
        task.resume()
    }
}
