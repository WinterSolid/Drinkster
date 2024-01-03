//
//  Drink.swift
//  Drinkster
//
//  Created by Zakee Tanksley on 1/3/24.
//
import Foundation
import CoreData

public class Drink: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var ingredients: String?
    @NSManaged public var instructions: String?
}
