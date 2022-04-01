//
//  StepsTableViewCell.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit

struct StepsModel {
    var step: Step
    var count: Int {
        return Int(step.count)
    }
    var stepMonth: Int {
        return Int(step.month)
    }
    var stepDate: Date {
        return step.date ?? Date()
    }
}

/// ViewModel created to display required steps detail in the screen
struct StepsTableViewCellModel {
    var title: String?
    var stepValue: String?
    var dateValue: String? 
}

class StepsTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var dateLabel: BaseLabel!
    @IBOutlet weak var stepsValueLabel: BaseLabel!
    @IBOutlet weak var stepsLabel: BaseLabel!
    
    //MARK: - Properties
    var data: StepsTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    
    static let reuseIdentifier = "StepsTableViewCell"
    
    //MARK: - Custom Methods
    func loadData() {
        self.stepsLabel.text = data?.title
        self.dateLabel.text = data?.dateValue
        self.stepsValueLabel.text = data?.stepValue
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
