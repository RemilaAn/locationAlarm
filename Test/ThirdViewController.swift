//
//  ThirdViewController.swift
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


class ThirdViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
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
    var on = true

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
//        scheduleNotification()
        
        
        // Edit button
        let button   =   UIButton()
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
                    
        button.backgroundColor   =   UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        button.frame = CGRect(x: 10, y: 65, width: 100, height: 40)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.addTarget(self, action: #selector(editAlarm), for: .touchUpInside)
        self.view.addSubview(button)
        
        let labelDestination = UILabel(frame: CGRect(x: 10, y: 125, width: 360, height: 50))
        labelDestination.text = self.target
        labelDestination.font = UIFont(name: "Helvetica", size: 30.0)
        self.view.addSubview(labelDestination)
        
        
        let labelDistance = UILabel(frame: CGRect(x: 10, y: 150, width: 360, height: 50))
        labelDistance.text = String(self.radius) + " km"
        self.view.addSubview(labelDistance)
        
        

        
//        inputDestination.textColor   =   .black
//        inputDestination.text = self.target
//        inputDestination.frame = CGRect(x: 10, y: 400, width: 400, height: 50)
//        self.view.addSubview(inputDestination)
        
        
//        inputRadius.textColor   =   .black
//        inputRadius.text = String(self.radius)
//        inputRadius.frame = CGRect(x: 10, y: 450, width: 400, height: 50)
//        self.view.addSubview(inputRadius)
        
        
        let hiddenbutton   =   UIButton()
               hiddenbutton.setTitleColor(UIColor.black, for: .normal)
                           
               hiddenbutton.backgroundColor   =   UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.0)
               hiddenbutton.frame = CGRect(x: 10, y: 125, width: 400, height: 75)
               hiddenbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
               hiddenbutton.addTarget(self, action: #selector(showOnMap), for: .touchUpInside)
               self.view.addSubview(hiddenbutton)
        
        
        // toggle button
             let toggleButton   =   UIButton()
             toggleButton.setTitle("ON", for: .normal)
             toggleButton.setTitleColor(UIColor.white, for: .normal)
                         
             toggleButton.backgroundColor   =   UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
             toggleButton.frame = CGRect(x: 360, y: 135, width: 40, height: 40)
             toggleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
             toggleButton.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
             self.view.addSubview(toggleButton)
                    
        
        
        
//        let eventStore = EKEventStore()
//
//        eventStore.requestAccess(to: EKEntityType.reminder, completion:
//                       {(granted, error) in
//                    if !granted {
//                        print("Access to store not granted")
//                    }
//            })
//        
//        
//        let e = EKEvent(eventStore: eventStore)
//
//        e.startDate = Date() + 30
//        e.endDate = e.startDate
//        e.title = "Cookies are Done! 🍪"
//
//        e.addAlarm(EKAlarm(relativeOffset: -5.0))
//
//        
//        do{
//        try eventStore.save(e, span: .thisEvent)
//        } catch let error {
//            print("Error: \(error)")
//        }
    }

////    Coordinate to address
//    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
//        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
//            completion(placemarks?.first?.locality,
//                       placemarks?.first?.country,
//                       error)
//        }
//    }
    
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
//        let destinationAddress = getDestination()
//                addressToLoaction(from: destinationAddress) { loc, error in
//                    guard let targetLocation = loc, error == nil else { return }
//                    let userLocation = self.a
//                    let distance = userLocation.distance(from: targetLocation) / 1000
//
//                    var content = "User: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)\nTarget: \(targetLocation.coordinate.latitude), \(targetLocation.coordinate.longitude)\nDistance: \(distance)"
//                    self.outputLabel.text = content
//                    print(content)
//                }
//        let destinationAddress = getDestination()
//        self.target = destinationAddress
//        self.radius = Int(getRadius())
//        locationManager.startUpdatingLocation()
    }
    
    
        @objc func toggleAction(_ button: UIButton)
        {
            if(on) {
                on = false
                button.setTitle("OFF", for: .normal)
                
            } else {
                on = true;
                button.setTitle("ON", for: .normal)
            }
            
        }
    
        @objc func editAlarm(_ button: UIButton)
        {
            let viewController  =   EditAlarm()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    
        @objc func showOnMap(_ button: UIButton)
        {
            let viewController  =   ShowOnMap()
            self.navigationController?.pushViewController(viewController, animated: true)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
