//
//  InstrutorInfoViewController.swift
//  Solar
//
//  Created by mac on 2020/7/4.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class InstrutorInfoViewController: UIViewController {
    @IBOutlet weak var myAccount: UILabel!
    @IBOutlet weak var myPassword: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var lastUpdat: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("InstructorInfo Load")
        //fillForm(completion: <#T##(Bool) -> ()#>)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("InstructorInfo Appear")
        fillForm { (res) in
            if res {
                self.loading.isHidden = true
            }
        }
    }
    func fillForm(completion: @escaping (_ :Bool)->()){
        let user:BmobQuery = BmobQuery(className: "User")
        user.getObjectInBackground(withId: loginId) { (obj, error) in
            if error != nil{
                // do nothing
            }else{
                if obj != nil{
                    self.myAccount.text = obj?.object(forKey: "username") as? String
                    self.myPassword.text = obj?.object(forKey: "password") as? String
                    print(obj?.object(forKey: "createdAt") as! String)
                    self.createdAt.text = obj?.object(forKey: "createdAt") as! String
                    self.lastUpdat.text = obj?.object(forKey: "updatedAt") as! String
                    self.job.text = obj?.object(forKey: "userType") as? String
                    completion(true)
                    
                }
            }
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
