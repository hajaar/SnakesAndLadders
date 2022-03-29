//
//  Colors.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 29/03/22.
//

import Foundation
import UIKit

struct FlatColors {

     static let Turquoise = UIColor("#1ABC9C")
     static let GreenSea = UIColor("#16A085")
     static let Emerald = UIColor("#2ECC71")
     static let Nephritis = UIColor("#27AE60")
     static let PeterRiver = UIColor("#3498DB")
     static let BelizeHole = UIColor("#2980B9")
     static let Amethyst = UIColor("#9B59B6")
     static let Wisteria = UIColor("#8E44AD")
     static let SunFlower = UIColor("#F1C40F")
     static let Orange = UIColor("#F39C12")
     static let Carrot = UIColor("#E67E22")
     static let Pumpkin = UIColor("#D35400")
     static let Alizarin = UIColor("#E74C3C")
     static let Pomegranate = UIColor("#C0392B")
     static let Clouds = UIColor("#ECF0F1")
     static let Silver = UIColor("#BDC3C7")
     static let Concrete = UIColor("#95A5A6")
     static let Asbestos = UIColor("#7F8C8D")
     static let WetAsphalt = UIColor("#34495E")
     static let MidnightBlue = UIColor("#2C3E50")
    
}

extension UIColor {
    convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
