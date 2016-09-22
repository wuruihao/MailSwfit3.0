//
//  Contacts+CoreDataProperties.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/22.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts");
    }

    @NSManaged public var departmenNumber: String?
    @NSManaged public var departmentId: String?
    @NSManaged public var departmentName: String?
    @NSManaged public var departmentjson: String?

}
