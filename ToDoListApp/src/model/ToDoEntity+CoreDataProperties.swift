//
//  ToDoEntity+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Naoki Takimoto on 2017/03/17.
//  Copyright © 2017年 takimoto. All rights reserved.
//

import Foundation
import CoreData


extension ToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity");
    }

    @NSManaged public var content: String?
    @NSManaged public var tagColor: Bool
    @NSManaged public var timeLimit: NSDate?

}
