//
//  Constants.swift
//  Solar
//
//  Created by mac on 2020/7/3.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

var instructor:String = ""
var loginId:String = ""
var tempList:[String] = []
var sortfieldCon:String = "courseName"
var sortOrderCon:String = "Asc"

class GameScore{
    var objectId:String
    var PlaygName:String
    var score:Int
    init() {
        self.objectId = ""
        self.PlaygName = ""
        self.score = -1
    }
    init(objectId:String,PlaygName:String,score:Int) {
        self.objectId = objectId
        self.PlaygName = PlaygName
        self.score = score
    }
}

class User{
    var objectId:String
    var account:String
    var password:String
    var userType:String = "Student"
    var courseList:[String] = []
    init() {
        self.objectId = ""
        self.account = ""
        self.password = ""
        //self.userType = ""
    }
    init(objectId:String,account:String,password:String,userType:String,courseList:[String]) {
        self.objectId = objectId
        self.account = account
        self.password = password
        self.userType = userType
        self.courseList = courseList
    }
}

class InstructorCourse{
    var obejctID:String = ""
    var courseName:String = ""
    var courseCredit:Int = -1
    var category:String = ""
    var courseCode:Int = -1
    var description:String = ""
    var instructor:String = ""
    init() {
        
    }
    init(name:String,credit:Int,category:String,code:Int,info:String,instructor:String) {
        self.courseName = name
        self.courseCredit = credit
        self.category = category
        self.courseCode = code
        self.description = info
        self.instructor = instructor
    }
}

func isContain(target:String, array:[String]) -> Bool{
    for item in array{
        if(target == item){
            return true
        }
        print("Contain", array.count)
    }
    
    return false
}
