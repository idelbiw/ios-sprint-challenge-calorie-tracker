//
//  CalorieIntake+Convenience.swift
//  CalorieTracker
//
//  Created by Waseem Idelbi on 8/14/20.
//  Copyright © 2020 Waseem Idelbi. All rights reserved.
//

import Foundation
import CoreData

extension CalorieIntake {
    convenience init(calories: Int64, context: NSManagedObjectContext) {
        self.init(context: context)
        self.calories = calories
        self.date = Date()
    }
}
