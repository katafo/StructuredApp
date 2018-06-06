//
//  Storyboard + Reusable.swift
//
//  Copyright © 2018. All rights reserved.
//

import UIKit

enum SBManager: String {
    
    // Define your storyboard name in here.
    // Example: For Main.storyboard, you need to define "case main".
    // Usage: SBManager.main.load(ViewController.self)

    case main
    
    var filename: String {
        return rawValue.capitalized
    }
    
}

extension SBManager {
    
    func load<T: UIViewController>(_ vc: T.Type, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: filename, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not load: \"\(T.reuseIdentifier)\" from \"\(rawValue).storyboard\"")
        }
        return vc
    }
    
}

