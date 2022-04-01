//
//  AppStrings.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import Foundation

enum AppStrings: String{
    
    /* Steps Title */
    case steps
    
    /*Achievements*/
    case achievements
    
    /*No achievements yet*/
    case noAchievementsYet
    
    /*Keep walking!*/
    case keepWalking
    
    /*Goal achievement*/
    case goalAchievement
    
    var localized: String{
        return NSLocalizedString(self.rawValue, comment: "")
    }

}
