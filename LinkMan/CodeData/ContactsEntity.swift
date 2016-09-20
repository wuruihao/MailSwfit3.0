//
//  ContactsEntity.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import CoreData

@objc(User)

class ContactsEntity: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var departmentId: String
    @NSManaged var memberId: String
    @NSManaged var memberName: String
    @NSManaged var memberPosition: String
    @NSManaged var memberSanp: String

}
