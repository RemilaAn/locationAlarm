//
//  EditAlarm.swift
//  Test
//
//  Created by Antony Michale Remila on 14/03/17.
//  Copyright © 2017 Antony Michale Remila. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications
import EventKit
import AVFoundation


class EditAlarm: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    let inputDestination   =   UITextView()
    let inputRadius = UITextView()
    let outputLabel = UILabel()
    var a: CLLocation = CLLocation()
    var target: String = "Chengalpattu"
    var radius: Int = 10
    var eventStore: EKEventStore!
    var reminders: [EKReminder]!
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor   =   UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let center = UNUserNotificationCenter.current()
        

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        
        
        // save button
        let button   =   UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0), for: .normal)
                    
        button.backgroundColor   =   UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        button.frame = CGRect(x: 10, y: 65, width: 380, height: 40)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        self.view.addSubview(button)

        
        let labelDestination = UILabel(frame: CGRect(x: 10, y: 120, width: 400, height: 50))
        labelDestination.text = "Location"
         labelDestination.textColor   =   .black
        labelDestination.font = UIFont(name: "Helvetica", size: 20.0)
        self.view.addSubview(labelDestination)
        
        inputDestination.textColor   =   .gray
        inputDestination.text = self.target
        inputDestination.textAlignment = .right
        inputDestination.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.0)
        inputDestination.font = UIFont(name: "Helvetica", size: 20.0)
        inputDestination.frame = CGRect(x: 110, y: 120, width: 280, height: 50)
        self.view.addSubview(inputDestination)
        
        
       let labelDistance = UILabel(frame: CGRect(x: 10, y: 180, width: 400, height: 50))
        labelDistance.text = "Distance"
        labelDistance.textColor   =   .black
         labelDistance.font = UIFont(name: "Helvetica", size: 20.0)
        self.view.addSubview(labelDistance)
        
        inputRadius.textColor   =   .gray
        inputRadius.text = String(self.radius)
        inputRadius.textAlignment = .right
        inputRadius.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.0)
        inputRadius.font = UIFont(name: "Helvetica", size: 20.0)
        inputRadius.frame = CGRect(x: 110, y: 180, width: 280, height: 50)
        self.view.addSubview(inputRadius)

    }


    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        //If you don't want to show notification when app is open, do something here else and make a return here.
        //Even you you don't implement this delegate method, you will not see the notification on the specified controller. So, you have to implement this delegate and make sure the below line execute. i.e. completionHandler.

        completionHandler([.alert, .badge, .sound])
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            let userLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            let targetAddress = self.target
            a = userLocation
            
    //        fetchCityAndCountry(from: userLocation) { city, country, error in
    //            guard let city = city, let country = country, error == nil else { return }
    //            print(city + ", " + country)
    //        }
            
            geoCoder.geocodeAddressString(targetAddress) { (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let targetLocation = placemarks.first?.location
                    else {
                        // handle no location found
                        return
                }
                
                
                let distance = userLocation.distance(from: targetLocation) / 1000
                
                var content = "User: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)\nTarget: \(targetLocation.coordinate.latitude), \(targetLocation.coordinate.longitude)\nDistance: \(distance)"
                let outputLabel   =   getLabel(text: content)
                self.view.addSubview(outputLabel)
                
                let radius = self.radius
                
                if distance <= Double(radius) {
                    outputLabel.text = "Reached"
                    self.scheduleNotification()
                    manager.stopUpdatingLocation()
                    
                    self.playAudio();
                }
                
    //            manager.stopUpdatingLocation()
            }
            
            func getLabel(text: String) -> UILabel  {
        
                outputLabel.textColor   =   .black
                outputLabel.text = text
                outputLabel.frame = CGRect(x: 10, y: 200, width: 400, height: 200)
                outputLabel.numberOfLines = 3
                
                return outputLabel
            }
        }
    
    
    @objc func buttonClicked(_ button: UIButton)
    {
        
        let destinationAddress = getDestination()
        self.target = destinationAddress
        self.radius = Int(getRadius())
        locationManager.startUpdatingLocation()
    }
    
        @objc func editAlarm(_ button: UIButton)
        {
            print("edit clicked")
        }
    
    //Address to Coordinate
        func addressToLoaction(from address: String, completion: @escaping (_ loc: CLLocation?, _ error: Error?) -> ()) {
            geoCoder.geocodeAddressString(address) { placemarks, error in
                completion(placemarks?.first?.location,
                           error)
            }
        }
    
    func getDestination() -> String{
        return trim(str: inputDestination.text)
    }
    
    func getRadius() -> Double {
        let r = trim(str: inputRadius.text)
        return Double(r) ?? 0.0
    }
    
    func trim(str: String) -> String {
        return str.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
        func scheduleNotification() {
            let center = UNUserNotificationCenter.current()

            let content = UNMutableNotificationContent()
    //        content.badge = 1
            content.title = "Reached"
            content.body = "Get ready......"
            content.categoryIdentifier = "alarm"
            content.userInfo = ["customData": "fizzbuzz"]
            content.sound = UNNotificationSound.default()
    //        content.sound = UNNotificationSound.init(named: "alarm.mp3")

    //        var dateComponents = DateComponents()
    //        dateComponents.hour = 23
    //        dateComponents.minute = 20
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
            
            
            
        }
    
    
    func playAudio()  {
        do {
            let sound =  Bundle.main.path(forResource: "bell", ofType: "mp3")
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                audioPlayer.numberOfLoops = 2
                audioPlayer.play()
            } catch {
                 NSLog("Audio Session error: \(error)")
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
