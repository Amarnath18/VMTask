//
//  EmployeeDetailViewController.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var favColor: UILabel!
    
    var employeeDetails : EmployeeCellViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        fullName.text = "\(employeeDetails?.FName ?? "") \(employeeDetails?.LName ?? "")"
        email.text = employeeDetails?.email
        jobTitle.text = employeeDetails?.jobTitle
        favColor.text = employeeDetails?.favColor

        getData(from: URL(string: employeeDetails?.image ?? "")!) { data, response, error in
                guard let data = data, error == nil else { return }
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() { [weak self] in
                    self?.ProfileImage.image = UIImage(data: data)
                }
            }
 
        ProfileImage.makeRounded()
    }
 
 
}


func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
//func getImageData(imageURL: String) -> da{
//    
//    getData(from: URL(string: imageURL ?? "")!) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print("Download Finished")
//            DispatchQueue.main.async() {
//               return data
//            }
//        }
//}
