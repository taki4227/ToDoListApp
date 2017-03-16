//
//  ToDoEntity+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by 滝本直樹 on 2017/03/02.
//  Copyright © 2017年 takimoto. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ToDoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity");
    }

    @NSManaged public var time_limit: NSDate?
    @NSManaged public var content: NSObject?
    @NSManaged public var tag_color: Int16

}
