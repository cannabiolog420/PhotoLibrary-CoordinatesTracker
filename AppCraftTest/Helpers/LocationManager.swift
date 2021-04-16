//
//  LocationManager.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import CoreLocation
import UIKit


protocol LocationManagerDelegate{
    func trackingLocation(coordinatesString:String)
    func buttonAndTextFieldForState(isTracking:Bool)
}



class LocationManager:NSObject,CLLocationManagerDelegate{
    
    
    let locationManager = CLLocationManager()
    var audioPlayer = AudioPlayer()
    
    var locationManagerDelegate:LocationManagerDelegate?
    
    // Переменная для начала / остановки остлеживания геолокации
    private var isLocationTracking:Bool = false
    
    // Переменная,чтобы не начинать отслеживать геолокацию пользователя при каждой смене статуса авторизации из настроек на .authorizedWhenInUse в didChangeAuthorization,но в то же время начинать отслеживать если смена статуса произошла после .notDetermined
    private var trackAfterAllowing:Bool = false
    
    
    override init() {
        super.init()
        
        // Сетапим локейшн менеджер
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        
        // Сетапим плеер
        audioPlayer.setupPlayer()
    }
    
    
    //MARK: - Methods
    
    
    // Проверка служб геолокации
    
    func checkLocationServices(){
        
        if CLLocationManager.locationServicesEnabled(){
            handleLocationAuthorizationStatus()
        }else{
            Alert.showLocationAlert(type: .locationServicesDisabled)
        }
    }
    
    // Обработчик статуса авторизации
    
    private func handleLocationAuthorizationStatus(){
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse,.authorizedAlways:
            startStopTracking()
            break
        case .denied:
            Alert.showLocationAlert(type: .locationAuthorizationDenied)
            break
        case .notDetermined:
            
            locationManager.requestWhenInUseAuthorization()
            trackAfterAllowing = true
            break
        case .restricted:
            break
        @unknown default:
            print("New case is available")
        }
    }
    
    // Начать / остановить отслеживание геолокации + проигрывание музыки.Кнопка меняет цвет при отслеживании геолокации
    
    private func startStopTracking(){
        
        if isLocationTracking{
            locationManager.stopUpdatingLocation()
        }else{
            locationManager.startUpdatingLocation()
        }
        isLocationTracking.toggle()
        audioPlayer.playPausePlayer()
        guard let locationManagerDelegate = self.locationManagerDelegate else {
            print("delegate was not set")
            return }
        locationManagerDelegate.buttonAndTextFieldForState(isTracking: isLocationTracking)
    }
    
    // Вызов алёрт контроллера при попытке начать отслеживать геолокацию с выключенной службой геолокации / выключенным определением местоположения
    
    private func showAlertController(title:String,message:String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Понятно", style: .default)
        if CLLocationManager.locationServicesEnabled(){
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsURL){
                    UIApplication.shared.open(settingsURL)
                }
            }
            alertController.addAction(settingsAction)
        }
        alertController.addAction(cancelAction)
        
        guard let topViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        topViewController.present(alertController, animated: true)
        
    }
    //MARK: - Location Manager Delegate
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        updateLocation(location: location)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .authorizedWhenInUse{
            if trackAfterAllowing{
                startStopTracking()
                trackAfterAllowing = false
            }
        }else{
            trackAfterAllowing = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        updateLocationDidFailWithError(error:error)
    }
    
    

    
    private func updateLocation(location:CLLocation){
        
        
        let latitude = String(format: "%.6f", location.coordinate.latitude)
        let longitude = String(format: "%.6f", location.coordinate.longitude)
        let coordinatesString = latitude + "," + longitude
        
        guard let locationManagerDelegate = self.locationManagerDelegate else {
            print("delegate was not set")
            return }
        // передача координатов в текстовое поле
        locationManagerDelegate.trackingLocation(coordinatesString: coordinatesString)
    }
    
    
    private func updateLocationDidFailWithError(error:Error) {
        
        print("LocationManager didFailWithError : \(error.localizedDescription)")
        locationManager.stopUpdatingLocation()
        isLocationTracking = false
        audioPlayer.stop()
        guard let locationManagerDelegate = self.locationManagerDelegate else {
            print("delegate was not set")
            return }
        // очистка текстового поля,смена тайтла кнопки
        locationManagerDelegate.buttonAndTextFieldForState(isTracking: isLocationTracking)
    
    
}

}
