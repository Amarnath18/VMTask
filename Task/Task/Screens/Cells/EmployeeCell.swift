//
//  EmployeeCell.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//


import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: EmployeeCellViewModel? {
        didSet {
            profileImage.image = UIImage(named: "")
            fullName.text = "\(cellViewModel?.FName ?? "") \(cellViewModel?.FName ?? "")"
            jobTitle.text = cellViewModel?.jobTitle
            getData(from: URL(string: cellViewModel?.image ?? "")!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print("Download Finished")
                    DispatchQueue.main.async() { [weak self] in
                        self?.profileImage.image = UIImage(data: data)
                    }
                }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        // Cell view customization
        backgroundColor = .clear
        selectionStyle = .none
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        profileImage.makeRounded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        fullName.text = nil
        jobTitle.text = nil
        profileImage.image = nil
    }
    
 
}
