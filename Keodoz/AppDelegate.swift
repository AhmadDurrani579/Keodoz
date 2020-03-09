//
//  AppDelegate.swift
//  Keodoz
//
//  Created by Ahmed Durrani on 22/11/2019.
//  Copyright © 2019 Ahmed Durrani. All rights reserved.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift
import GoogleMaps

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
            IQKeyboardManager.shared.enable = true

           if #available(iOS 12.0, *) {
               UIApplication.shared.statusBarStyle = .lightContent
            
           } else {
                
           }
        _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { location in
            DEVICE_LAT = location.coordinate.latitude
            DEVICE_LONG = location.coordinate.longitude
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                addressDict.forEach { print($0) }
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    DEVICE_ADDRESS = formattedAddress.joined(separator: ", ")
                }
            })
            
        }, onError: { (last, error) in
            print("Something bad has occurred \(error)")
        })
        
        GMSServices.provideAPIKey("AIzaSyB6PBoGzZSH9IQEnm1gNKpWwlR72Yz9nw4")


        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

        func loadSideMenu() {

    //        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: homeVC), leftMenuViewController: BLSideMenuVC())
    //        sideMenu.delegate = self
    ////
    //
    //        window?.rootViewController = sideMenu
            
            
    //        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: false))
    //        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 1.0, scale: 0.7))
    //        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black,offset: CGSize(width: -15.0, height: 20.0), opacity: 0.5, radius: 20.0))
    //         sideMenu.backgroundImage = UIImage(named: "background")
    //        self.navigationController?.pushViewController(sideMenu, animated: false);
        
        }
        
        func sideMenuWillShowMenuViewController(_ sideMenu: SSASideMenu, menuViewController: UIViewController) {
    //        print("Will Show \(menuViewController)")
        }
        
        func sideMenuDidShowMenuViewController(_ sideMenu: SSASideMenu, menuViewController: UIViewController) {
    //        print("Did Show \(menuViewController)")
        }
        
        func sideMenuDidHideMenuViewController(_ sideMenu: SSASideMenu, menuViewController: UIViewController) {
    //        print("Did Hide \(menuViewController)")
        }
        
        func sideMenuWillHideMenuViewController(_ sideMenu: SSASideMenu, menuViewController: UIViewController) {
    //        print("Will Hide \(menuViewController)")
        }
        func sideMenuDidRecognizePanGesture(_ sideMenu: SSASideMenu, recongnizer: UIPanGestureRecognizer) {
    //        print("Did Recognize PanGesture \(recongnizer)")
        }



}

