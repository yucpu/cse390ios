//
//  SignupViewController.swift
//  Solar
//
//  Created by mac on 2020/7/3.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var Account: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var UserType: UITextField!
    @IBOutlet weak var selection: UISegmentedControl!
    var allUser:[User] = []
    var userTypeArr:[String] = ["Student","Instructor"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SignupViewController",selection.selectedSegmentIndex)
        UserType.text = userTypeArr[selection.selectedSegmentIndex]
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(disKeyboard))
        view.addGestureRecognizer(tap)
        loadDataFromDatabase()
        
        // Do any additional setup after loading the view.
    }
    @objc func disKeyboard() {
        view.endEditing(true)
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
                let temp = User(objectId: objectid1, account: account1, password: password1, userType: userType1, courseList: courseList1)
                self.allUser.append(temp)
                index += 1
            }
        }
    }
    
    @IBAction func segmentDidChange(_ sender: Any) {
        print("SignupViewController",userTypeArr[selection.selectedSegmentIndex])
        UserType.text = userTypeArr[selection.selectedSegmentIndex]
    }
    
    @IBAction func confirm(_ sender: Any) {
        let username:String = Account.text!
        let password:String = Password.text!
        let usertype:String = UserType.text!
        print(usertype)
        if(checkDuplicate(username: username)){
            alertWindow(message: "The user name has been used")
            return
        }
        if(password.count == 0){
            alertWindow(message: "Password can't be empty !")
            return
        }
        // save
        
        let database:BmobObject = BmobObject(className: "User")
        database.setObject(username, forKey: "username")
        database.setObject(password, forKey: "password")
        database.setObject(usertype, forKey: "userType")
        database.setObject([], forKey: "courseList")
        database.saveInBackground { (result, errol) in
            if(result){
                print("account creadted successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
        
    }
    @IBAction func cancle(_ sender: Any) {
        //alertWindow(message: "dd")
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkDuplicate(username:String) -> Bool{
        for user in allUser{
            if(user.account == username){
                return true
            }
        }
        return false
        
    }
    func alertWindow(message:String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: {self.Account.text! = ""})
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
