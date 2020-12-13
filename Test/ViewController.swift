//
//  ViewController.swift
//  Test
//
//  Created by Antony Michale Remila on 14/03/17.
//  Copyright © 2017 Antony Michale Remila. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillAppear")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor   =   UIColor.blue
        print("ViewDidLoad")
        
        let myFirstButton   =   UIButton()
        myFirstButton.setTitle("Tap Here", for: .normal)
        myFirstButton.setTitleColor(UIColor.green, for: .normal)

        myFirstButton.backgroundColor   =   UIColor.red
        myFirstButton.frame = CGRect(x: 50, y: 50, width: 200, height: 40)
        myFirstButton.addTarget(self, action:#selector(pressed(_:)), for: .touchUpInside)
        self.view.addSubview(myFirstButton)

        
    }
    
    @objc func pressed(_ button: UIButton)
    {
        print("Test")
//        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        let viewController  =   SecondViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        //self.present(viewController, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

