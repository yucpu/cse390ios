//
//  InstructorSettingViewController.swift
//  Solar
//
//  Created by mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InstructorSettingViewController: UIViewController {
    @IBOutlet weak var sortBy: UISegmentedControl!
    @IBOutlet weak var orderBy: UISegmentedControl!
    
    var keyArray:[String] = ["courseName","courseCredit","category","code"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func sortfield(_ sender: Any) {
        print(sortBy.titleForSegment(at: sortBy.selectedSegmentIndex)!)
        sortfieldCon = keyArray[sortBy.selectedSegmentIndex]
        
        
    }
    @IBAction func sortOrder(_ sender: Any) {
        print(orderBy.titleForSegment(at: orderBy.selectedSegmentIndex)!)
        sortOrderCon = orderBy.titleForSegment(at: orderBy.selectedSegmentIndex)!
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
