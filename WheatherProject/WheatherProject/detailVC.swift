//
//  detailVC.swift
//  WheatherProject
//
//  Created by user on 12.10.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {

    var cityName = ""
    
  
  
    @IBOutlet weak var addCityNameL: UILabel!
    @IBOutlet weak var addTempL: UILabel!
    @IBOutlet weak var addContryL: UILabel!
    @IBOutlet weak var addImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let colorTop = UIColor(red: 89/256, green: 156/255, blue: 169/255, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        self.view.layer.addSublayer(gradientLayer)
        
        currentWeather(city: cityName)
    }
    
    func currentWeather(city: String) {
        let url = "https://api.weatherapi.com/v1/current.json?key=a05901a43486421889a90648210510&q=London&aqi=no\(city)"
        
        AF.request(url, method: .get).validate().responseJSON { response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            let name = json["location"]["name"].stringValue
            let temp = json["current"]["temp_c"].doubleValue
            let country = json["location"]["contry"].stringValue
            let weatherURLString = "http:\(json["location"][0]["icon"].stringValue)"
            
            self.addCityNameL.text = name
            self.addTempL.text = String(temp)
            self.addContryL.text = country
            
            let weatherURL = URL(string: weatherURLString)
            if let data = try? Data(contentsOf: weatherURL!){
                self.addImage.image = UIImage(data: data)
            }
            
        case .failure(let error):
            print(error)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
