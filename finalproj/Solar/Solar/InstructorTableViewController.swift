//
//  InstructorTableViewController.swift
//  Solar
//
//  Created by mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InstructorTableViewController: UITableViewController {
    
    var myCourse:[InstructorCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        loadDataFromDatabase { (res) in
            if res {
                
                self.tableView.reloadData()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        sortfieldCon = "courseName"
        sortOrderCon = "Asc"
    }
    func loadDataFromDatabase(completion: @escaping (_: Bool)->()){
        myCourse = []
        let query:BmobQuery = BmobQuery(className: "Course")
        if(sortOrderCon == "Asc"){
            query.order(byAscending: sortfieldCon)
        }else{
            query.order(byDescending: sortfieldCon)
        }
        
        query.findObjectsInBackground { (array, error) in
            var i = 0
            while (i < (array?.count)!){
                print(1)
                let obj  = array?[i] as! BmobObject
                let name1 = obj.object(forKey: "courseName") as? String
                let instructor1 = obj.object(forKey: "instructor") as? String
                let description1 = obj.object(forKey: "description") as? String
                let courseCredit = obj.object(forKey: "courseCredit") as? String
                let courseCode = obj.object(forKey: "code") as? String
                let courseCategory = obj.object(forKey: "category") as? String
                let objectid = obj.objectId
                if(isContain(target: name1!, array: tempList)){
                    let temp = InstructorCourse(name: name1!, credit: Int(courseCredit!, radix: 10)!, category: courseCategory!, code: Int(courseCode!,radix: 10)!, info: description1!, instructor: instructor1!)
                    temp.obejctID = objectid!
                    self.myCourse.append(temp)
                }
                i += 1
            }
            completion(true)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myCourse.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Instructorcourse", for: indexPath) as! InstructorTableViewCell

        // Configure the cell...
        let obj = myCourse[indexPath.row]
        cell.code.text = String(obj.courseCode)
        cell.category.text = obj.category
        cell.credit.text = String(obj.courseCredit)
        cell.instructor.text = obj.instructor
        cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Signal")
        if segue.identifier == "showCourse" {
            let CourseInfoController = segue.destination as? CourseInfoViewController
            let selectedRow = self.tableView.indexPath(for: sender as! UITableViewCell)?.row
            let selectedCourse = myCourse[selectedRow!]
            CourseInfoController?.course = selectedCourse
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
