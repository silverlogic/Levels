//
//  UIStoryboard+Extension.swift
//  Levels
//
//  Created by Shaun Bevan on 4/21/18.
//  Copyright © 2018 The SilverLogic. All rights reserved.
//

import UIKit

// MARK: - Public Class Methods
extension UIStoryboard {

    // MARK: - UIViewController Loaders
    static func loadInitialViewController() -> UITabBarController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? UITabBarController else {
            fatalError("BaseTabBarController does not exist in Main.storyboard!")
        }
        return controller
    }

    static func loadCaluculatorController() -> SandbagCalculatorViewController {
        return loadControllerFromMain(type: SandbagCalculatorViewController.self)
    }
}


// MARK: - Private Class Methods
fileprivate extension UIStoryboard {

    /**
     Loads a view controller from the main
     storyboard.

     - Parameter type: A `UIViewController.Type` indicating what type to load.

     - Returns: A `T` representing the view controller
     to load.
     */
    fileprivate static func loadControllerFromMain<T: UIViewController>(type: T.Type) -> T {
        return loadControllerFrom(.main, type: type)
    }

    /**
     Loads a view controller from a storyboard.

     - Parameters:
     - storyboard: A `Storyboard` represeting the storyboard
     to load the view controller from.
     - type: A `UIViewController.Type` representing the type to load.

     - Returns: A `T` representing the view controller to load.
     */
    private static func loadControllerFrom<T: UIViewController>(_ storyboard: Storyboard, type: T.Type) -> T {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        // swiftlint:disable line_length
        guard let controller = uiStoryboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("View Controller in storyboard does not have identifier set!")
        }
        // swiftlint:enable line_length
        return controller
    }
}


/**
 An enum that specifies which
 storyboard to load.
 */
fileprivate enum Storyboard: String {
    case main = "Main"
}
