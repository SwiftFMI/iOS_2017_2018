//
//  ViewController.swift
//  LocationDemo
//
//  Created by Emil Atanasov on 5.01.18.
//  Copyright © 2018 SwiftFMI. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    //добре е да е е член променлива, за да се пази в паметта
    let manager = CLLocationManager()
    
    //UIRequiredDeviceCapabilities в Info.plist се използва за да се определи дали дадено устройство има съответния хардуер и дали приложението ще работи location-services или gps
    
    //Ако приложението може да работи и без тези изисквания, тогава не е нужно да добавяте
    //тези изсквания, понеже броя на поддържаните устройства ще е по-малък.
    
    //Когато искаме да изпозлваме различни функций на устройството iOS
    //запитва потребителя за неговото разрешение. Добре е да прилагаме
    //следните правила:
    // * Винаги да питаме в последния възможен момент. Т.е. когато приложението трябва да използва лоацията на потребителя да го пита за разрешение не при първото стартиране на приложението, преди потребителя да знае какво прави приложението, а при първия необходим момент, при възможност след действие от страна на потребителя.
    // * Да подготвим потребителя с правилнито съобщение. В случая с локацията - ключът NSLocationWhenInUseUsageDescription трябва да бъде добавен в Info.plist
    // * Ако нямаме контрол върху текстовете (текста за достъп до notifications/нотификациите не може да се променя) е правилно да покажем предварителен текст и чак тогава да пристъпим към следващата стъпка.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkLocationService()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    print("неопределено")
                    manager.delegate = self
                    manager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse:
                    manager.delegate = self
                    manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                    manager.distanceFilter = 100
                    manager.startUpdatingLocation()
                break
                
                default:
                    //
                    print("Нямаме достъп. Може ли да работи приложението?")
                    break
            }
            
            //изпозлва се, ако ще трябва да ползваме Location през
            //по време на използване на приложението, но дори и в
            //background - пример Maps, Google Maps
    //        manager.requestAlwaysAuthorization()
        
        } else {
            //Възможни са различни причини за да няма достъп до location услугата
            //Примерно: малко батерия
            //потребителя е забранил достъпа и др.
            print("Няма достъп до location услугата.")
        }
    }
    
    //MARK : CLLocationManagerDelegate
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("New locations were sent!")
        print("Locations: \(locations)")
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            manager.distanceFilter = 100
            manager.startUpdatingLocation()
        case .notDetermined:
            print("неопределено")
        default:
            //
            print("Нямаме достъп. Може ли да работи приложението?")
            break
        }
    }
}

