//
//  CalorieIntake+CoreDataProperties.swift
//  
//
//  Created by Waseem Idelbi on 8/14/20.
//
//

import Foundation
import CoreData


extension CalorieIntake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalorieIntake> {
        return NSFetchRequest<CalorieIntake>(entityName: "CalorieIntake")
    }

    @NSManaged public var calories: Int64
    @NSManaged public var date: Date

}
