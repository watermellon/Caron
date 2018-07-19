//
//  ViewController.swift
//  J+C
//
//  Created by Joshua Song on 7/9/18.
//  Copyright © 2018 Joshua Song. All rights reserved.
//

import UIKit
import CoreLocation
import Eureka

class ViewController: FormViewController, CLLocationManagerDelegate, BWWalkthroughViewControllerDelegate {
    
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.view.tintColor = UIColor(red:0.84, green:0.51, blue:1.00, alpha:1.0)

        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.height))
        imageView.image = UIImage(named: "background")
        self.tableView?.backgroundView = imageView
        //self.tableView?.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        form +++ Section("Let's start off easy")
            <<< DateRow(){
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "What day did we start dating?"
                $0.value = UserDefaults.standard.value(forKey: "q1") as? Date
                $0.tag = "t1"
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "What is my favorite fruit?"
                $0.selectorTitle = "Pick a fruit"
                $0.options = ["Orange","Banana","Watermelon","Apple", "Honeydew","Peaches"]
                $0.value = UserDefaults.standard.string(forKey: "q2")
                $0.tag = "t2"
            }
            <<< SegmentedRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "Which is your side of the bed?"
                $0.options = ["Left","Right"]
                $0.value = UserDefaults.standard.string(forKey: "q3")
                $0.tag = "t3"
            }
            <<< SliderRow() {
                $0.title = "I am 5 feet  ___ inches?"
                $0.minimumValue = 0.0
                $0.maximumValue = 11.5
                $0.value = UserDefaults.standard.float(forKey: "q4")
                $0.tag = "t4"
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
            }
        +++ Section("Medium difficulty questions")
            <<< MultipleSelectorRow<String>(){
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "Which of the following are WACK?"
                $0.selectorTitle = "Check all that apply"
                $0.options = ["His hair", "His gear", "His cat", "His jewlery", "The way that he talks", "The way that he walks", "The way that he dances in the moonlight", "The way that he doesn't even like to smile"]
                let encodedData = UserDefaults.standard.object(forKey: "q5") as! Data
                $0.value = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as? Set<String>
                $0.tag = "t5"
                }.onPresent { from, to in
                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(ViewController.multipleSelectorDone(_:)))
            }
            <<< ActionSheetRow<String>{
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "How many times have we been in Chicago?"
                $0.options = ["0", "1", "2", "3", "4"]
                $0.value = UserDefaults.standard.string(forKey: "q10")
                $0.tag = "t10"
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "Whats my favorite Nam Da Mun popsicle?"
                $0.options = ["Vanilla", "Strawberry", "Chocolate", "Mixed Berry"]
                $0.value = UserDefaults.standard.string(forKey: "q11")
                $0.tag = "t11"
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "Who don't you know?"
                $0.options = ["Me","You","Him","Her", "Them"]
                $0.value = UserDefaults.standard.string(forKey: "q6")
                $0.tag = "t6"
            }
        +++ Section("Tough questions")
            <<< DateRow(){
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "When is the first time I saw you poop?"
                $0.value = UserDefaults.standard.value(forKey: "q7") as? Date
                $0.tag = "t7"
            }
            <<< LocationRow(){
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "Where did we sit during our first fight?"
                let encodedData = UserDefaults.standard.object(forKey: "q9") as! Data
                let locValue = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as? CLLocation
                $0.value = locValue
                print(locValue)
                $0.tag = "t9"
            }
            <<< TextRow() { row in
                row.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                row.title = "Whats the best type of Peanut Butter?"
                row.tag = "t14"
                row.value = UserDefaults.standard.string(forKey: "q14")
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "What was the last song at the Kendrick concert?"
                $0.options = ["LOYALTY", "HUMBLE", "DNA", "LOVE", "i"]
                $0.tag = "t15"
                $0.value = UserDefaults.standard.string(forKey: "q15")
            }
        +++ Section("Extremely hard questions!")
            <<< TextRow(){ row in
                row.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                row.title = "What's the best bakery to buy buns from?"
                row.tag = "t12"
                row.value = UserDefaults.standard.string(forKey: "q12")
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "What model car did we race in at NAIAS?"
                $0.options = ["Mustang", "Corvette", "Camaro", "Charger"]
                $0.value = UserDefaults.standard.string(forKey: "q13")
                $0.tag = "t13"
            }
            <<< ActionSheetRow<String>() {
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "How many different ice cream shops in Ann Arbor did we visit?"
                $0.options = ["1", "2", "3", "4", "5", "6", "7", "8"]
                $0.value = UserDefaults.standard.string(forKey: "q16")
                $0.tag = "t16"
            }
            <<< TextRow() { row in
                row.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                row.title = "A Eurasian country also known as Sakartvelo"
                row.tag = "t17"
                row.value = UserDefaults.standard.string(forKey: "q17")
            }
        +++ Section("The hardest question of them all!!!")
            <<< PhoneRow(){
                $0.baseCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
                $0.title = "What's my phone number?"
                $0.value = UserDefaults.standard.string(forKey: "q8")
                $0.tag = "t8"
            }
        AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeLeft)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AppUtility.lockOrientation(.all)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("called loc manager")
        var currentLocation: CLLocation!
        let encodedStart = UserDefaults.standard.object(forKey: "q9") as! Data
        let startValue = NSKeyedUnarchiver.unarchiveObject(with: encodedStart) as? CLLocation
        let startLat: Double = (startValue?.coordinate.latitude)!
        let startLong: Double = (startValue?.coordinate.longitude)!
        print("startLat \(startLat) startLong \(startLong)")
        if(startLat == 42.2755 && startLong == -83.7459){
            if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                currentLocation = locationManager.location
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: currentLocation)
                UserDefaults.standard.set(encodedData, forKey: "q9")
                UserDefaults.standard.synchronize()
                let newRow: LocationRow = form.rowBy(tag: "t9")!
                newRow.value = currentLocation
                newRow.reload()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func multipleSelectorDone(_ item:UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitAction(_ sender: UIBarButtonItem) {
        let formValues = self.form.values()
        print(formValues)
        
        let v1 = formValues["t1"] as? Date
        let v2 = formValues["t2"] as? String
        let v3 = formValues["t3"] as? String
        let v4 = formValues["t4"] as? Float
        let v5 = formValues["t5"] as? Set<String>
        let v5encoded = NSKeyedArchiver.archivedData(withRootObject: v5)
        let v6 = formValues["t6"] as? String
        let v7 = formValues["t7"] as? Date
        let v8 = formValues["t8"] as? String
        let v9 = formValues["t9"] as? CLLocation
        let v9encoded = NSKeyedArchiver.archivedData(withRootObject: v9)
        let v10 = formValues["t10"] as? String
        let v11 = formValues["t11"] as? String
        let v12 = formValues["t12"] as? String
        let v13 = formValues["t13"] as? String
        let v14 = formValues["t14"] as? String
        let v15 = formValues["t15"] as? String
        let v16 = formValues["t16"] as? String
        let v17 = formValues["t17"] as? String

        UserDefaults.standard.set(v1, forKey: "q1")
        UserDefaults.standard.set(v2, forKey: "q2")
        UserDefaults.standard.set(v3, forKey: "q3")
        UserDefaults.standard.set(v4, forKey: "q4")
        UserDefaults.standard.set(v5encoded, forKey: "q5")
        UserDefaults.standard.set(v6, forKey: "q6")
        UserDefaults.standard.set(v7, forKey: "q7")
        UserDefaults.standard.set(v8, forKey: "q8")
        UserDefaults.standard.set(v9encoded, forKey: "q9")
        UserDefaults.standard.set(v10, forKey: "q10")
        UserDefaults.standard.set(v11, forKey: "q11")
        UserDefaults.standard.set(v12, forKey: "q12")
        UserDefaults.standard.set(v13, forKey: "q13")
        UserDefaults.standard.set(v14, forKey: "q14")
        UserDefaults.standard.set(v15, forKey: "q15")
        UserDefaults.standard.set(v16, forKey: "q16")
        UserDefaults.standard.set(v17, forKey: "q17")

        UserDefaults.standard.synchronize()

        var boolDict = [1:false, 2:false, 3:false, 4:false, 5:false, 6:false, 7:false, 8:false, 9:false, 10:false, 11:false, 12:false, 13:false, 14:false, 15:false, 16:false, 17:false]
        let hintDict: [Int:String] = [8:"YOU DON'T KNOW ___!", 9:"You might have to scroll way back into our fb messages for this one", 10:"Across the street from Fred's if I remember correctly", 11:"Halloween", 13:"It's located in Chicago Chinatown", 14:"Look at the pictures to find which brand of car it is", 15:"Don't forget the shop we used a gift card at, and the one we went to during the car show"]
        
        if(v1! >= Date(timeIntervalSince1970: TimeInterval(1492646400)) && v1! <= Date(timeIntervalSince1970: TimeInterval(1492732799))){
            boolDict[1] = true
        }
        if(v2 == "Watermelon"){
            boolDict[2] = true
        }
        if(v3 == "Left"){
            boolDict[3] = true
        }
        if(v4 == 9.5 || v4 == 10.0){
            boolDict[4] = true
        }
        if(v5 == ["His hair", "His gear", "His jewlery", "The way that he talks", "The way that he doesn't even like to smile"]){
            boolDict[5] = true
        }
        if(v6 == "Me"){
            boolDict[8] = true
        }
        if(v7! >= Date(timeIntervalSince1970: TimeInterval(1515196800)) && v7! <= Date(timeIntervalSince1970: TimeInterval(1515283199))){
            boolDict[9] = true
        }
        if(v8 == "7852182716"){
            boolDict[17] = true
        }
        let lat: Double = (v9?.coordinate.latitude)!
        let long: Double = (v9?.coordinate.longitude)!
        print("lat \(lat) long \(long)")
        if(long <= -83.7408 && long >= -83.7445 && lat >= 42.2797 && lat <= 42.2804){
            boolDict[10] = true
        }
        if(v10 == "2"){
            boolDict[6] = true
        }
        if(v11 == "Strawberry"){
            boolDict[7] = true
        }
        if(v12 == "Feida" || v12 == "Feida Bakery" || v12 == "Feida bakery" || v12 == "feida" || v12 == "feida bakery"){
            boolDict[13] = true
        }
        if(v13 == "Charger"){
            boolDict[14] = true
        }
        if(v14 == "Cruncy" || v14 == "CRUNCY"){
            boolDict[11] = true
        }
        if(v15 == "HUMBLE"){
            boolDict[12] = true
        }
        if(v16 == "6"){
            boolDict[15] = true
        }
        if(v17 == "Georgia" || v17 == "georgia"){
            boolDict[16] = true
        }
        
        var errorMsg = ""
        var errorNum = "Question #s answered wrong: "
        var hintMSG = "\nHints:\n"
        if(boolDict[1]! && boolDict[2]! && boolDict[3]! && boolDict[4]! && boolDict[5]! && boolDict[6]! && boolDict[7]! && boolDict[8]! && boolDict[9]! && boolDict[10]! && boolDict[11]! && boolDict[12]! && boolDict[13]! && boolDict[14]! && boolDict[15]! && boolDict[16]! && boolDict[17]!){
            print("hooray")
            let alert = UIAlertController(title: "Ayyyy LMAO!", message: "Good job Caron! You got them all right!\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok 😄", style: .default, handler: { (action) -> Void in
                AppUtility.lockOrientation(.all)
                AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
                Walkthrough(ViewController: self, VCDelegate: self as! BWWalkthroughViewControllerDelegate)

            }))
            
            var height:NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 332)
            alert.view.addConstraint(height);
            
            var imageView = UIImageView(frame: CGRect(x: 78, y: 70, width: 112, height: 200))
            imageView.image = UIImage(named: "ayyLmao")
            alert.view.addSubview(imageView)
            
            self.present(alert, animated: true)

        }
        else{
            var counter: Int = 0
            for key in 1...17{
                if(!boolDict[key]!){
                    errorNum = errorNum + String(key) + ", "
                    counter = counter + 1
                    if let hint = hintDict[key] {
                        hintMSG = hintMSG + String(key) + ": " + hint + "\n"
                    }
                }
            }
            errorNum = String(errorNum.dropLast(2))
            if(counter >= 17){
                errorMsg = "Ouch Caron.. you didn't get a single question correct.. are we even dating? LOL"
            }
            else if(counter > 12){
                errorMsg = "Getting a few right is better than none I guess.. But keep working on it!"
            }
            else if(counter > 8){
                errorMsg = "Not bad, you got almost half of them right! Keep trying!"
            }
            else if(counter > 4){
                errorMsg = "Nice, Caron! You got over half of them right! Almost there!"
            }
            else if(counter >= 1){
                errorMsg = "WOW! You're almost there, only a few more to go, Caron!"
            }
            
            //hints
            if(UserDefaults.standard.bool(forKey: "hints")){
                errorNum = errorNum + hintMSG
            }
            
            let alert = UIAlertController(title: errorMsg, message: errorNum, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok 😄", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

