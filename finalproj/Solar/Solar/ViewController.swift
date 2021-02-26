//
//  ViewController.swift
//  Solar
//
//  Created by mac on 2020/7/2.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSign: UIButton!
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var allUser:[User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromDatabase()
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(disKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func disKeyboard(){
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        loadDataFromDatabase()
        print("Main Page reload")
    }
    @IBAction func loginAction(_ sender: Any) {
        let target = studentOrInstrutor()
        if(target == "void"){
            alertWindow(message: "Wrong Username or Password ")
            return
        }
        
        instructor = accountText.text!
        print(tempList)
        performSegue(withIdentifier: target, sender: nil)
        
    }
    func loadDataFromDatabase(){
        allUser = []
        let _User:BmobQuery = BmobQuery(className: "User")
        _User.findObjectsInBackground { (array, error) in
            var index = 0
            while(index < (array?.count)!){
                let obj = array?[index] as! BmobObject
                let objectid1 = obj.objectId as String
                let account1 = obj.object(forKey: "username") as! String
                let password1 = obj.object(forKey: "password") as! String
                let userType1 = obj.object(forKey: "userType") as! String
                let courseList1 = obj.object(forKey: "courseList") as! [String]
                print("load",index,courseList1,account1,password1)
                let temp = User(objectId: objectid1, account: account1, password: password1, userType: userType1, courseList: courseList1)
                self.allUser.append(temp)
                index += 1
            }
            
        }
    }
    func studentOrInstrutor() -> String{
        for user in allUser{
            if user.account == accountText.text! {
                print("ViewController","Aoccunt Exist")
                if(user.userType == "Student" && user.password == passwordText.text!){
                    loginId = user.objectId
                    tempList = user.courseList
                    return "showStudent"
                }else if(user.userType == "Instructor" && user.password == passwordText.text!){
                    loginId = user.objectId
                    tempList = user.courseList
                    print(user.courseList)
                    return "showInstructor"
                }
            }
        }
        return "void"
    }
 
    func alertWindow(message:String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }


}

