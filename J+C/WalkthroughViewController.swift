//
//  WalkthroughController.swift
//  hitBit
//
//  Created by Joshua Song on 7/5/18.
//  Copyright © 2018 Joshua Song. All rights reserved.
//

import Foundation
import UIKit

open class Walkthrough: BWWalkthroughViewControllerDelegate {
    
    var walkthrough: BWWalkthroughViewController = BWWalkthroughViewController()
    var VC: UIViewController
    
    init(ViewController: UIViewController, VCDelegate: BWWalkthroughViewControllerDelegate) {
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        VC = ViewController

        let width = VC.view.frame.height
        let height = VC.view.frame.width
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Main", bundle: nil)
        walkthrough = stb.instantiateViewController(withIdentifier: "container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "page_1")
        //let page_two = stb.instantiateViewController(withIdentifier: "page_2")
        //let page_three = stb.instantiateViewController(withIdentifier: "page_3")
        //let page_four = stb.instantiateViewController(withIdentifier: "page_4")
        //let page_five = stb.instantiateViewController(withIdentifier: "page_5")
        
        //add background image
        //if added programatically, image does not fade in/out
        UIGraphicsBeginImageContext(CGSize.init(width: width, height: height))
        UIImage(named: "walkthrough_bg")?.draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        let bgImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        page_one.view.backgroundColor = UIColor(patternImage: bgImage)
        //page_two.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "walkthrough_bg"))
        //page_three.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "walkthrough_bg"))
        //page_four.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "walkthrough_bg"))
        //page_five.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "walkthrough_bg"))
        
        
        // Attach the pages to the master
        walkthrough.delegate = VCDelegate
        walkthrough.add(viewController:page_one)
        //walkthrough.add(viewController:page_two)
        //walkthrough.add(viewController:page_three)
        //walkthrough.add(viewController:page_four)
        //walkthrough.add(viewController:page_five)
        
        VC.present(walkthrough, animated: true, completion: nil)
    }
    //walkthrough delegate functions not working so i changed functions in library BWWalkthroughViewController
    /*open func walkthroughCloseButtonPressed() {
     VC.dismiss(animated: true, completion: nil)
     }
     
     public func walkthroughPageDidChange(_ pageNumber: Int) {
     if(walkthrough.numberOfPages - 1) == pageNumber{
     walkthrough.closeButton?.isHidden = false
     }
     else{
     walkthrough.closeButton?.isHidden = true
     }
     }*/
}
