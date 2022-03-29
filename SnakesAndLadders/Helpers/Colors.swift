//
//  Colors.swift
//  SnakesAndLadders
//
//  Created by Kartik Narayanan on 29/03/22.
//

import Foundation

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
