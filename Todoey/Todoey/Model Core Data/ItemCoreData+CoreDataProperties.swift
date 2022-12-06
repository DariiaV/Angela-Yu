//
//  ItemCoreData+CoreDataProperties.swift
//  Todoey
//
//  Created by Дария Григорьева on 06.12.2022.
//
//

import Foundation
import CoreData


extension ItemCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemCoreData> {
        return NSFetchRequest<ItemCoreData>(entityName: "ItemCoreData")
    }

    @NSManaged public var title: String?
    @NSManaged public var done: Bool

}

extension ItemCoreData : Identifiable {

}
