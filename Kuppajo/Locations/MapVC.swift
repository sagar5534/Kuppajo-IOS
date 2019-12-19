//
//  MapVC.swift
//  Kuppajo
//
//  Created by Sagar Patel on 2019-10-12.
//  Copyright © 2019 Sagar. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationTable: UITableView!
    
    var locationData = [Locations]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTable.delegate = self
        locationTable.dataSource = self
        
        let cord = CLLocationCoordinate2D(latitude: 46.491192, longitude: -80.992836)
        let firstLocation = MKPointAnnotation()
        firstLocation.title = "Kuppajo Espresso Bar"
        firstLocation.coordinate = cord
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: firstLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.addAnnotation(firstLocation)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        locationData = appDelegate.locations
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LocationCell = self.locationTable.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        
        cell.LocationName.text = locationData[indexPath.row].name
        let weekday = Date().dayNumberOfWeek()!
        cell.LocationTimeDetail.text = locationData[indexPath.row].hours.days[weekday]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "showDetail":
            guard let mealDetailViewController = segue.destination as? LocationInfoTVC else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? LocationCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = locationTable.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = locationData[indexPath.row]
            mealDetailViewController.locationData = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
        
    }
    
    
    
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
