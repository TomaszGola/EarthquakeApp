//
//  ViewController.swift
//  earthquakeApp
//
//  Created by Tomasz Gola on 04.07.2018.
//  Copyright © 2018 Tomasz Gola. All rights reserved.
//

import UIKit

struct GeoJson: Decodable {
    let type: String
    let metadata: Metadata?
    let features: [Features]?
    let bbox: [Double]?
}
struct Metadata: Decodable {
    let generated: Int?
    let url: String?
    let title: String?
    let status: Int?
    let api: String?
    let count: Int?
}
struct Features: Decodable {
    let type: String?
    let properties: Properties?
    let geometry: Geometry?
    let id: String?
}
struct Properties: Decodable {
    let mag: Double?
    let place: String?
    let time: Int?
    let updated: Int?
    let tz: Int?
    let url: String?
    let detail: String?
    let felt: Int?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String?
    let tsunami: Int?
    let sig: Int?
    let net: String?
    let code: String?
    let ids: String?
    let sources: String?
    let types: String?
    let nst: Int?
    let dmin: Double?
    let rms: Double?
    let gap: Double?
    let magType: String?
    let type: String?
    let title: String?
}
struct Geometry: Decodable {
    let type: String?
    let coordinates: [Double]?
}

class ViewController: UIViewController
//, UITableViewDataSource
{

    //MARK: Properties
    
    @IBOutlet weak var amountOfMagnitude: UISlider!
    @IBOutlet weak var dateFromWhichFetchingData: UIDatePicker!
    @IBOutlet weak var valueOfAmountOfMagnitude: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var amountOfRows: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayDate: Date = Date()
        dateFromWhichFetchingData.maximumDate = todayDate
    }
    
    //MARK: Actions
    
    @IBAction func changeValueOfAmountOfMagnitude(_ sender: UISlider) {
        let currentValueOfSlider = Float(round(sender.value*10)/10)
        valueOfAmountOfMagnitude.text = "\(currentValueOfSlider)"
    }
    
    @IBAction func startFetchingData(_ sender: UIButton) {
        
        let dateFromUIDatePicker = dateFromWhichFetchingData.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFromUiDatePickerAfterChangeFormat = dateFormatter.string(from: dateFromUIDatePicker)
        let startTime = dateFromUiDatePickerAfterChangeFormat
        
        let currentValueOfSlider = String(round(amountOfMagnitude.value*10)/10)
        let minMagnitude = currentValueOfSlider
       
        let jsonUrlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=" + startTime + "&minmagnitude=" + minMagnitude
        guard let url = URL(string: jsonUrlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode as Any)
        
            if httpResponse?.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let geoJson = try JSONDecoder().decode(GeoJson.self, from: data)
//                    DispatchQueue.main.async{
//                        self.tableView.reloadData()
//                    }
                    if geoJson.metadata?.count == 0 {
                        print("nie ma wyników dla tej daty i tej wartości magnitude")
                    } else {
                        print(geoJson.metadata?.count)
                        print(geoJson.features?[0].properties?.title)
//                        self.amountOfRows = geoJson.metadata?.count
                        print(geoJson.features)
                    }
                } catch let jsonErr {
                    print("Error while json: ", jsonErr)
                }
            } else {
                print("Problem po stronie serwera")
            }
        }.resume()
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return amountOfRows!
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeCell") as? EarthquakeTableViewCell else { return UITableViewCell ()}
//
//        cell.dateLabel.text = "yyyy-mm-dd"
//        cell.locationLabel.text = "place"
//        cell.magnitudeLabel.text = "2.4"
//
//        return cell
//    }
}
