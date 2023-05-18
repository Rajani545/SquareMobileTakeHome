//
//  EmployeeCell.swift
//  SquareupChallengeProject
//
//  Created by admin on 5/16/23.
//

import UIKit
import SDWebImage

class EmployeeCell: UICollectionViewCell {
    
    static let identifier = "employeeCell"
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var teamLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var employeeTypeLbl: UILabel!
 
    func configureCell(with employee: Employee?) {
        self.layer.cornerRadius = 8
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        if let fullName = employee?.fullName {
            nameLbl.text = fullName
        }
        if let team = employee?.team {
            teamLbl.text = team
        }
        if let phoneNumber = employee?.phoneNumber {
            phoneLbl.text = "+1 " + phoneNumber
        }
        if let image = employee?.photoURLSmall, let imageURL = URL(string: image) {
            DispatchQueue.main.async {
                self.profileImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "profilePlaceholder"))
            }
        }
        if let employeeType = employee?.employeeType.description {
            employeeTypeLbl.text = employeeType
        }
    }
}
