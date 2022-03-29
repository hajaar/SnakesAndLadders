//
//  Colors.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 29/03/22.
//

import Foundation
import UIKit

struct Colors {
    private static let mattPurple = UIColor(red: 0.55, green: 0.48, blue: 0.90, alpha: 1.00)
    private static let skirretGreen = UIColor(red: 0.27, green: 0.74, blue: 0.20, alpha: 1.00)
    private static let nanohanachaGold = UIColor(red: 0.88, green: 0.69, blue: 0.17, alpha: 1.00)
    private static let darkBlue = UIColor(red: 0.08, green: 0.45, blue: 0.63, alpha: 1.00)
    private static let lightBlue = UIColor(red: 0.60, green: 0.82, blue: 0.93, alpha: 1.00)
    static let boardTextColor = UIColor.black
    static let boardColor = skirretGreen
    static let highlightTileColor = nanohanachaGold
    static let tileColor = (lightBlue, darkBlue)
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
