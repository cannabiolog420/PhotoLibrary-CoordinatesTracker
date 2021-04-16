//
//  LocationViewController.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import UIKit

class LocationViewController: UIViewController {

    // Properties
    lazy var locationManager:LocationManager = {
        let locationManager = LocationManager()
        locationManager.locationManagerDelegate = self
        return locationManager
    }()
    
    @IBOutlet weak var coordinatesTextField: UITextField!
    @IBOutlet weak var trackLocationButton: UIButton!
    
    // Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


    @IBAction func trackLocationTapped(_ sender: Any) {
        
        locationManager.checkLocationServices()

        
    }
    
    

}


extension LocationViewController:LocationManagerDelegate{
    
    
    func buttonAndTextFieldForState(isTracking: Bool) {
        
        if isTracking{
            trackLocationButton.setTitle("Остановить отслеживание", for: .normal)
            trackLocationButton.backgroundColor = .red
            
        }else{
            trackLocationButton.setTitle("Отслеживать геолокацию", for: .normal)
            trackLocationButton.backgroundColor = .green
            coordinatesTextField.text = ""
        }
    }
    

    func trackingLocation(coordinatesString:String) {
        
        coordinatesTextField.text = coordinatesString
    }
}
