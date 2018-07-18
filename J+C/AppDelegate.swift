//
//  AppDelegate.swift
//  J+C
//
//  Created by Joshua Song on 7/9/18.
//  Copyright © 2018 Joshua Song. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "GOTHAM-LIGHT", size: 17)!], for: UIControlState.normal)
        self.window?.tintColor = UIColor(red:0.84, green:0.51, blue:1.00, alpha:1.0)

        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if(!launchedBefore){
            UserDefaults.standard.set(Date(), forKey: "q1")
            UserDefaults.standard.set("", forKey: "q2")
            UserDefaults.standard.set("", forKey: "q3")
            UserDefaults.standard.set(0.0, forKey: "q4")
            let emptySet = Set<String>()
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: emptySet)
            UserDefaults.standard.set(encodedData, forKey: "q5")
            UserDefaults.standard.set("", forKey: "q6")
            UserDefaults.standard.set(Date(), forKey: "q7")
            UserDefaults.standard.set("", forKey: "q8")
            let currentLocation = CLLocation(latitude: CLLocationDegrees(42.2755), longitude: CLLocationDegrees(-83.7459))
            let encodedLoc = NSKeyedArchiver.archivedData(withRootObject: currentLocation)
            UserDefaults.standard.set(encodedLoc, forKey: "q9")
            UserDefaults.standard.set("", forKey: "q10")
            UserDefaults.standard.set("", forKey: "q11")
            UserDefaults.standard.set("", forKey: "q12")
            UserDefaults.standard.set("", forKey: "q13")
            UserDefaults.standard.set("", forKey: "q14")
            UserDefaults.standard.set("", forKey: "q15")
            UserDefaults.standard.set("", forKey: "q16")
            UserDefaults.standard.set("", forKey: "q17")
            UserDefaults.standard.set(false, forKey: "hints")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.synchronize()
        }
        return true
    }
    
    //allows for locking orientation to landscape or portrait
    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "J_C")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

