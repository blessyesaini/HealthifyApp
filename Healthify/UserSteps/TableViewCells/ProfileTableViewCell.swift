//
//  ProfileTableViewCell.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit

struct ProfileTableViewCellModel {
    var profile: String?
}

class ProfileTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    //MARK: - Properties
    static let reuseIdentifier = "ProfileTableViewCell"
    var data: ProfileTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    //MARK: - Custom Methods
    func loadData() {
        self.profileImageView.image = UIImage(named: data?.profile ?? "profile")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
