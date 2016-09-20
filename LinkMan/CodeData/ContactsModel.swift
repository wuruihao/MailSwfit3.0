//
//  ContactsModel.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/18.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import CoreData

class ContactsModel: NSObject {

    /*
    //添加数据
    func saveCoreDate(){
        //加载AppDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        //获取管理的上下文
        let context = appDel.managedObjectContext
        //创建一个实例并给属性赋值
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: context)as! ContactsEntity
        
        entity.id = "2"
        entity.departmentId = "小红"
        entity.memberId = "12"
        entity.memberName = "12"
        entity.memberPosition = "12"
        entity.memberSanp = "12"
        //下面这种赋值方式也可以的
        //        let entity = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        //        let people = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
        //        people.setValue(1, forKey: "id")
        //        people.setValue("小明", forKey: "name")
        //        people.setValue(10, forKey: "age")
        //保存数据
        do {
            try context.save()
            print("保存成功")
        }catch let error{
            print("context can't save!, Error:\(error)")
        }
    }
    
    func fetchCoreData (){
        //加载AppDelegate
        let appDel = UIApplication.shared.delegate as! AppDelegate
        //获取管理的上下文
        let context = appDel.managedObjectContext
        // 声明数据请求实体
        let fetchRequest = NSFetchRequest(entityName: "Contacts")
        
        let predicate = NSPredicate(format:"id=1")  //设置查询条件按照id查找不设置查询条件，则默认全部查找
        fetchRequest.predicate = predicate
        //执行查询操作
        do {
            let peopleList =
                try context.fetch(fetchRequest)as! [NSManagedObject]
            print("打印查询结果")
            for contacts in peopleList as! [ContactsEntity] {
                print("查询到的人是\(contacts.memberName)")
                //修改操作:将查询到的结果修改后，再调用context.save()保存即可
                if (contacts.memberName == "小红"){
                    contacts.memberName = "小花"
                }
                //删除操作:将查询到的额结果删除后，再调用context.save()保存即可
                if (contacts.memberName == "小明"){
                    context.delete(contacts)
                }
            }
        }catch let error{
            print("context can't fetch!, Error:\(error)")
        }
        do {
            try context.save()
            print("保存成功")
        }catch let error{
            print("context can't save!, Error:\(error)")
        }
        
    }
*/
}



