//
//  AppearanceConfigurator.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

class AppearanceConfigurator {
    
    class func configureNavigationBar() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.barTintColor = ColorPalette.white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = ColorPalette.black
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont.exampleAvenirMedium(ofSize: 17),
            NSForegroundColorAttributeName: ColorPalette.black
        ]
    }
    
}
