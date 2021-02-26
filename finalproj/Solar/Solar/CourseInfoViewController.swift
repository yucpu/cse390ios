//
//  CourseInfoViewController.swift
//  Solar
//
//  Created by mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CourseInfoViewController: UIViewController {
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var Credit: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var courseCode: UITextField!
    @IBOutlet weak var courseDescription: UITextView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var waitView: UIActivityIndicatorView!
    @IBOutlet weak var deletebtn: UIButton!
    
    var course:InstructorCourse? = nil
    var courselist:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        waitView.isHidden = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(disKeyboard))
        view.addGestureRecognizer(tap)
        loadDataFromDatabase()
        if(course != nil){
            // fill data
            self.courseName.text = course?.courseName
            self.category.text = course?.category
            self.courseDescription.text = course?.description
            self.courseCode.text = String(describing: (course?.courseCode)!)
            self.Credit.text = String(describing: (course?.courseCredit)!)
            confirmBtn.isEnabled = false
        }else{
            deletebtn.isEnabled = false
        }
        // Do any additional setup after loading the view.
    }
    @objc func disKeyboard(){
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        loadDataFromDatabase()
    }

    func loadDataFromDatabase(){
        let query:BmobQuery = BmobQuery(className: "User")
        query.getObjectInBackground(withId: loginId) { (obj, error) in
            if(error != nil){
                
            }else{
                if obj != nil{
                    self.courselist = obj?.object(forKey: "courseList") as! [String]
                }
            }
        }
    }
    
    
    
    @IBAction func confirmAction(_ sender: Any) {
        if(course == nil){
            // add new course
            waitView.isHidden = false
            let target:BmobObject = BmobObject(className: "Course")
            target.setObject(courseName.text!, forKey: "courseName")
            target.setObject(Credit.text!, forKey: "courseCredit")
            target.setObject(category.text!, forKey: "category")
            target.setObject(courseCode.text!, forKey: "code")
            target.setObject(courseDescription.text!, forKey: "description")
            target.setObject(instructor, forKey: "instructor")
            target.saveInBackground { (res, error) in
                if(res){
                    print("Cources created successfully")
                    self.courselist.append(self.courseName.text!)
                    self.updateList(value: self.courselist, finished: {(ding) in
                        if ding{
                            tempList.append(self.courseName.text!)
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                }
            }

            
        }else{
            // update course
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        waitView.isHidden = false
        let target:BmobObject = BmobObject(outDataWithClassName: "Course", objectId: course?.obejctID)
        let count = tempList.count - 1
        target.deleteInBackground { (res,error) in
            if res{
                for index in 0 ... count {
                    if tempList[index] == self.course?.courseName{
                        tempList.remove(at: index)
                        print("after remove", tempList)
                    }
                }
                if(res){
                    print("delete Successfully")
                    self.updateList(value: tempList,finished:{(ding) in
                        if ding{
                            self.navigationController?.popViewController(animated: true)
                        }

                    })
                    
                }
            }
        }
    }
    func updateList(value:[String], finished: @escaping (_ :Bool)->()){
        let target:BmobObject = BmobObject(outDataWithClassName: "User", objectId: loginId)
        target.setObject(value, forKey: "courseList")
        target.updateInBackground { (res, d) in
            if res{
                finished(true)
            }else{
                finished(false)
                // do nothing
            }
        }
    }
    

}
