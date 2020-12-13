//
//  SecondViewController.swift
//  Test
//
//  Created by Antony Michale Remila on 14/03/17.
//  Copyright © 2017 Antony Michale Remila. All rights reserved.
//

import UIKit
import UserNotifications
import AVFoundation

class SecondViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor   =   UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        
        let locationAlarmButton   =   UIButton()
        locationAlarmButton.setTitle("Location Alarm", for: .normal)
        locationAlarmButton.setTitleColor(UIColor.white, for: .normal)
        
        locationAlarmButton.backgroundColor   =   UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
        locationAlarmButton.frame = CGRect(x: 10, y: 100, width: 200, height: 40)
        locationAlarmButton.addTarget(self, action:#selector(pressed(_:)), for: .touchUpInside)
        self.view.addSubview(locationAlarmButton)
        
        
        
        let testButton   =   UIButton()
               testButton.setTitle("Play", for: .normal)
               testButton.setTitleColor(UIColor.white, for: .normal)
               
               testButton.backgroundColor   =   UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
               testButton.frame = CGRect(x: 10, y: 200, width: 200, height: 40)
               testButton.addTarget(self, action:#selector(test(_:)), for: .touchUpInside)
               self.view.addSubview(testButton)
        
        
        let stopButton   =   UIButton()
        stopButton.setTitle("Stop", for: .normal)
        stopButton.setTitleColor(UIColor.white, for: .normal)
        
        stopButton.backgroundColor   =   UIColor.init(red: 33/255, green: 150/255, blue: 243/255, alpha: 1.0)
        stopButton.frame = CGRect(x: 10, y: 300, width: 200, height: 40)
        stopButton.addTarget(self, action:#selector(stopAudio), for: .touchUpInside)
        self.view.addSubview(stopButton)
        
        /*
        
        
//        let a = [locationManager.location?.coordinate.latitude, locationManager.location?.coordinate.longitude]
        let address = "Chengalpattu Railway Station, J C K Nagar, Chengalpattu, Tamil Nadu 603001, India"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            print("........");
            print(locationManager.location?.coordinate)
            let a = locationManager.location?.coordinate
            print(a)
//            let alert = UIAlertController(title: "remi", message: String(a), preferredStyle: .alert)
            print(location)
             print("........");
        }
        
        let c1 = [12.831325, 80.049426]
        let c2 = [12.694114, 79.980697]
        
        let myLocation = CLLocation(latitude: c1[0], longitude: c1[1])
        let myBuddysLocation = CLLocation(latitude: c2[0], longitude: c2[1])
        let distance = myLocation.distance(from: myBuddysLocation) / 1000
        print(String(format: "The distance to my buddy is %.01fkm", distance))
        
//        func distance(lat1, lon1, lat2, lon2, unit) { //https://www.geodatasource.com/developers/javascript
//            let radlat1 = Math.PI * lat1/180
//            let radlat2 = Math.PI * lat2/180
//            let theta = lon1-lon2
//            let radtheta = Math.PI * theta/180
//            let dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
//            if (dist > 1) {
//                dist = 1;
//            }
//            dist = Math.acos(dist)
//            dist = dist * 180/Math.PI
//            dist = dist * 60 * 1.1515
//            if (unit=="K") { dist = dist * 1.609344 }
//            if (unit=="N") { dist = dist * 0.8684 }
//            return dist
//        }
        */
    }
    
    @objc func pressed(_ button: UIButton)
    {
//        //print("Test")
//        //        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
//        //        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        //        self.present(alert, animated: true, completion: nil)
//
        let viewController  =   ThirdViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        //self.present(viewController, animated: true, completion: nil)
        
        
        
        
//        let viewController  =   GeoReminder()
//        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func test(_ button: UIButton)
        {
 do {
    
//    //1--
    let sound =  Bundle.main.path(forResource: "bell", ofType: "mp3")
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer.play()
//    //--1
    
    //2--
//        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.duckOthers, .defaultToSpeaker])
//        try AVAudioSession.sharedInstance().setActive(true)
//        UIApplication.shared.beginReceivingRemoteControlEvents()
    
    
//    let AlarmNotification = UNUserNotificationCenter.current()
//
////    let AlarmNotification = UNMutableNotificationContent()
//    AlarmNotification.alertBody = "Wake Up!"
//    AlarmNotification.alertAction = "Open App"
//    AlarmNotification.category = "myAlarmCategory"
//    //AlarmNotification.applicationIconBadgeNumber = 0
//    //AlarmNotification.repeatCalendar = calendar
//    //TODO, not working
//    //AlarmNotification.repeatInterval = NSCalendarUnit.CalendarUnitWeekOfYear
//    AlarmNotification.soundName = soundName + ".mp3"
//    AlarmNotification.timeZone = TimeZone.current
//    AlarmNotification.userInfo = ["snooze" : snooze, "index": index, "soundName": soundName]
//    
//    let datesForNotification = correctDate(date, onWeekdaysForNotify:weekdays)
//    
//    for d in datesForNotification
//    {
//        AlarmNotification.fireDate = d
//        UIApplication.shared.scheduleLocalNotification(AlarmNotification)
//    }
    //--2
    } catch {
         NSLog("Audio Session error: \(error)")
    }
            
        }
    
    
     @objc func stopAudio(_ button: UIButton)
            {
            audioPlayer.stop()
                
            }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
