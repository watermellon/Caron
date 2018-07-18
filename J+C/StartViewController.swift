//
//  StartViewController.swift
//  J+C
//
//  Created by Joshua Song on 7/17/18.
//  Copyright © 2018 Joshua Song. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hintSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.bool(forKey: "hints")){
            hintSwitch.setOn(true, animated: false)
            hintLabel.text = "Hints: On"
        }
        else{
            hintSwitch.setOn(false, animated: false)
            hintLabel.text = "Hints: Off"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    override func viewWillLayoutSubviews() {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hintSwitchAction(_ sender: UISwitch) {
        if(sender.isOn){
            UserDefaults.standard.set(true, forKey: "hints")
            hintLabel.text = "Hints: On"
        }
        else{
            UserDefaults.standard.set(false, forKey: "hints")
            hintLabel.text = "Hints: Off"
        }
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
