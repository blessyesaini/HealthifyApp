//
//  AchievementCollectionViewCell.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit

/// ViewModel to show the required values in the view
struct AchievementCollectionViewCellModel {
    var goalAchievedTitle: String?
    var goalAchievedValue: String?
    var imageValue: String?
}

class AchievementCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: BaseLabel!
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var subTitleLabel: BaseLabel!
    @IBOutlet weak var achievementImageView: UIImageView!
    static let reuseIdentifier = "AchievementCollectionViewCell"
    var data: AchievementCollectionViewCellModel? {
        didSet {
            loadData()
        }
    }
//MARK: - Custom Methods
    func loadData() {
        self.achievementImageView.image = UIImage(named: data?.imageValue ?? "ten")
        self.titleLabel.text = data?.goalAchievedTitle
        self.subTitleLabel.text = data?.goalAchievedValue
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
