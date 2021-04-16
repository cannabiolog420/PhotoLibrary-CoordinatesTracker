//
//  Alert.swift
//  AppCraftTest
//
//  Created by cannabiolog420 on 16.04.2021.
//

import UIKit


enum AlertType{
    
    case locationAuthorizationDenied
    case locationServicesDisabled
}


struct Alert{
    
    
    // Вызов алёрт контроллера при попытке начать отслеживать геолокацию с выключенной службой геолокации / выключенным определением местоположения
    
    static func showLocationAlert(type:AlertType){
        
        var defaultActionTitle = ""
        var titleMessage:(String,String) = ("","")
        var actions = [UIAlertAction]()
        
        switch type {
        case .locationServicesDisabled:
            
            defaultActionTitle = "Понятно"
            titleMessage = ("Включите геолокацию на iPhone","1. Откройте приложение \"Настройки\".\n2. Выберите \"Конфиденциальность\".\n3. Выберите \"Службы геолокации\".\n4. Включите геолокацию.")
        case .locationAuthorizationDenied:
            
            let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
                guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsURL){
                    UIApplication.shared.open(settingsURL)
                }
            }
            defaultActionTitle = "Нет, спасибо"
            titleMessage = ("Включите определение местоположения в AppCraftTest","1. Выберите \"Геопозиция\".\n2. Выберите \"Используя\".")
            actions.append(settingsAction)
        }
        
        showBasicAlert(title: titleMessage.0, message: titleMessage.1, defaultActionTitle: defaultActionTitle, actions: actions)
    }
    
    
    static func showBasicAlert(title:String,message:String,defaultActionTitle:String,actions:[UIAlertAction]){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: defaultActionTitle, style: .default)
        alertController.addAction(defaultAction)
        for action in actions{
            alertController.addAction(action)
        }
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            rootViewController.present(alertController, animated: true)
        }
    }
    
}
