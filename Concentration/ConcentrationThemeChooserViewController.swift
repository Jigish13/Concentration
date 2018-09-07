//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Sneh on 28/08/18.
//  Copyright © 2018 The Gateway Corp. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: VCLLoggingViewController, UISplitViewControllerDelegate {
    
    override var vclLoggingName: String{
        return "ThemeChooser"
    }
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    
    //I want to set myself as splitViewController's delegate...
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        //Secondary MVC is detail one nd primary is master one
        //So in order to prevent collapsing of 2ndry on primary from happening, return true
        //Here in this ex. we dont want to collapse when the theme is nil
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController{
            if let themeName = (sender as? UIButton)?.currentTitle,let theme = themes[themeName]{
                cvc.theme = theme
            }
        }
        else if let cvc = lastSeguedToConcentrationViewController
        {
            if let themeName = (sender as? UIButton)?.currentTitle,let theme = themes[themeName]{
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else{
            performSegue(withIdentifier: "Choose Theme", sender: sender) //aana pachi prepare method call thse
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    
    //Strong var that will keep ref of last CVC (ref. iphone X) in heap m/m so that re-segueing will not create new instance of CVC
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    
    //MARK : Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //        if segue.identifier == "Choose Theme"{
        //            // NOTE: Any type hoi to mostly as thi typecasting krvanu
        //            if let button = sender as? UIButton{
        //                if let themeName = button.currentTitle{
        //                    if let theme = themes[themeName]{}
        //                }
        //            }
        //        }
        
        // OR
        
                if segue.identifier == "Choose Theme"{
                    // NOTE: Any type hoi to mostly as thi typecasting krvanu
                    if let themeName = (sender as? UIButton)?.currentTitle,let theme = themes[themeName]{
                        if let cvc = segue.destination as? ConcentrationViewController{
                            cvc.theme = theme
                            lastSeguedToConcentrationViewController = cvc
                        }
                    }
                }
        
    }
}
