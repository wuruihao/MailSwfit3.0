//
//  CoreDataTool.swift
//  LinkMan
//
//  Created by Enjoytouch on 16/9/22.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTool: NSObject {
    
    static let shared = CoreDataTool()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //CoreData操作
    let EntityName = "Contacts"
    
    //添加一个数组
    func addDepartmentsCoreData(data:[DepartmentData]){
        
        //删除
        self.deleteCoreData()
        //添加
        for department:DepartmentData in data {
            addCoreData(data: department)
        }
    }
    
    //添加一个对象
    func addCoreData(data:DepartmentData){
        
        let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: appDelegate.managedObjectContext) as! Contacts
        
        entity.departmentId = String(format: "%d", data.id)
        entity.departmentName = data.name
        entity.departmenNumber = String(format: "%d", data.number!)
        
        let dic = data.mj_keyValues()
        entity.departmentjson = dic?.mj_JSONString()
        
        do{
            try appDelegate.managedObjectContext.save()
            print("添加成功 ~ ~ ")
        }catch{
            print("添加失败！！")
        }
    }
    
    //按照条件添加一个对象
    func addPredicateCoreData(data:DepartmentData){
        
        //查找数据库是否存在
        let array = self.selectDataFromCoreData(departmentId: data.id)
        if array.count <= 0 {
            let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: appDelegate.managedObjectContext) as! Contacts
            
            entity.departmentId = String(format: "%d", data.id)
            entity.departmentName = data.name
            entity.departmenNumber = String(format: "%d", data.number!)
            
            let dic = data.mj_keyValues()
            entity.departmentjson = dic?.mj_JSONString()
            
            do{
                try appDelegate.managedObjectContext.save()
                print("添加成功 ~ ~ ")
            }catch{
                print("添加失败！！")
            }
        }
    }
    
    //删除全部数据
    func deleteCoreData(){
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
        do{
            //查询满足条件的联系人
            let resultsList = try appDelegate.managedObjectContext.fetch(request) as! [Contacts] as NSArray
            
            if resultsList.count != 0 {
                for results in resultsList {
                    let user = results as! Contacts
                    appDelegate.managedObjectContext.delete(user as NSManagedObject)
                    try appDelegate.managedObjectContext.save()
                    print("删除成功 ~ ~ ")
                }
            }else{
                print("删除失败！ 没有符合条件的联系人！")
            }
            
        }catch{
            print("delete fail !")
        }
    }
    
    //根据条件删除数据
    func deleteCoreData(ConditionDic conditionDic:NSMutableDictionary){
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
        let condition = "name='周杰伦'"
        let predicate = NSPredicate(format: condition, "")
        request.predicate = predicate
        do{
            //查询满足条件的联系人
            let resultsList = try appDelegate.managedObjectContext.fetch(request) as! [Contacts] as NSArray
            if resultsList.count != 0 {//若结果为多条，则只删除第一条，可根据你的需要做改动
                appDelegate.managedObjectContext.delete(resultsList[0] as! NSManagedObject)
                try appDelegate.managedObjectContext.save()
                print("delete success ~ ~")
            }else{
                print("删除失败！ 没有符合条件的联系人！")
            }
        }catch{
            print("delete fail !")
        }
    }
    
    //查询全部数据
    func selectDataFromCoreData() -> NSArray{
        
        var dataSource = NSArray()
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
        request.entity = entity
        do{
            //查询满足条件的联系人
            dataSource = try appDelegate.managedObjectContext.fetch(request) as! [Contacts] as NSArray
            print("数据读取成功 ~ ~")
        }catch{
            print("get_coredata_fail!")
        }
        
        return dataSource
    }
    
    //根据条件查找数据
    func selectDataFromCoreData(departmentId:Int) -> NSArray{
        
        var dataSource = NSArray()
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
        request.entity = entity
        let condition = String(format: "departmentId='%d'", departmentId)
        let predicate = NSPredicate(format: condition, "")
        request.predicate = predicate
        do{
            //查询满足条件的联系人
            dataSource = try appDelegate.managedObjectContext.fetch(request) as! [Contacts] as NSArray
            print("数据读取成功 ~ ~")
        }catch{
            print("get_coredata_fail!")
        }
        
        return dataSource
        
    }
    
    /*
     //改
     func updateDataWithCoreData(Model userModel:UserModel, Where condiArray:NSArray){
     
     let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
     let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)!
     let condition = "name='周杰伦'"
     let predicate = NSPredicate(format: condition,"")
     request.entity = entity
     request.predicate = predicate
     do{
     let userList = try appDelegate.managedObjectContext.fetch(request) as! [Contacts] as NSArray
     if userList.count != 0 {
     let user = userList[0] as! User
     user.name = "小公举"
     try appDelegate.managedObjectContext.save()
     print("修改成功 ~ ~")
     }else{
     print("修改失败，没有符合条件的联系人！")
     }
     }catch{
     print("修改失败 ~ ~")
     }
     
     }
     */
    
    //查询所有数据并输出
    func printAllDataWithCoreData() ->NSMutableArray{
        
        let data = NSMutableArray()
        let array = selectDataFromCoreData()
        for item in array {
            let user = item as! Contacts
            let des = DepartmentData.mj_object(withKeyValues: user.departmentjson) as DepartmentData
            
            let memberData = MemberData.mj_objectArray(withKeyValuesArray: des.members)
            des.members = memberData
            
            data.add(des)
            
        }
        return data
    }
    
    //注：appDelegate.managedObjectContext 为定义的全局变量，在Appdelegateclass范围外定义如下：
    //let application = UIApplication.shared
    //let appDelegate = application.delegate as! AppDelegate
}
