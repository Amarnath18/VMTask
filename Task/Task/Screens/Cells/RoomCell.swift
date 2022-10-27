//
//  RoomCell.swift
//  Task
//
//  Created by Amarnath B on 27/10/22.
//

import UIKit

class RoomCell: UITableViewCell {
    
    @IBOutlet var roomNo: UILabel!
    @IBOutlet var availabilityStatus: UILabel!
    @IBOutlet var maxOccupancy: UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: RoomCellViewModel? {
        didSet {
            roomNo.text = "Room No - \(cellViewModel?.roomNo ?? "0")"
            availabilityStatus.text = "Availability \(cellViewModel?.availabilityStatus == true ? "Yes" : "No")"
            maxOccupancy.text = "Occupancy - \(cellViewModel?.maxOccupancy ?? 0)"
            availabilityStatus.textColor = cellViewModel?.availabilityStatus == true ? UIColor.green : UIColor.red
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
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        roomNo.text = nil
        availabilityStatus.text = nil
        maxOccupancy.text = nil

    }
}
