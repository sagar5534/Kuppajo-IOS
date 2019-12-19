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
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LocationCell = self.locationTable.dequeueReusableCell(withIdentifier: "LocationCell") as! LocationCell
        cell.LocationName.text = "Downtown Sudbury"
        
        let weekday = Date().dayNumberOfWeek()!
        var timeDetail = ""
        
        switch weekday {
        case 1:
            timeDetail = "Open until 5:00 PM"
        default:
            timeDetail = "Open until 9:00 PM"
        }
        
        cell.LocationTimeDetail.text = timeDetail

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ToLocationDetail", sender: self)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    
    
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}
