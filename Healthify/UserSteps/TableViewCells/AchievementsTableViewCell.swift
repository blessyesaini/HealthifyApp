//
//  AchievementsTableViewCell.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit

///ViewModel created to display required achievement details the view
struct AchievementsTableViewCellModel {
    var state: State?
    var title: String? = nil
    var subTitle: String? = nil
    var collectionData: [AchievementCollectionViewCellModel]? = nil
}
class AchievementsTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var noAchievementSubTitleLabel: BaseLabel!
    @IBOutlet weak var heightConstraintConstant: NSLayoutConstraint!
    @IBOutlet weak var countLabel: BaseLabel!
    @IBOutlet weak var noAchievementView: UIView!
    @IBOutlet weak var noAchievementTitleLabel: BaseLabel!
    @IBOutlet weak var collectionView: UICollectionView!
   
    //MARK: - Properties
    static let reuseIdentifier = "AchievementsTableViewCell"
    var data: AchievementsTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    var arrIndexPath = [IndexPath]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
        prepareCollectionView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Custom Methods
    fileprivate func animateCell(_ indexPath: IndexPath, _ cell: UICollectionViewCell) {
        if arrIndexPath.contains(indexPath) == false {
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 200, 0)
            cell.layer.transform = transform
            
            UIView.animate(withDuration:1.2, delay: 0.1 * Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            })
            
            arrIndexPath.append(indexPath)
        }
    }
    func prepareUI() {
        self.titleLabel.text = AppStrings.achievements.localized
    }
    func loadData() {
        self.countLabel.text = String(data?.collectionData?.count ?? 0)
        if let state = data?.state {
            collectionView.isHidden = (state == .noValues) ? true:false
            countLabel.isHidden = (state == .noValues) ? true:false
            noAchievementView.isHidden = (state == .noValues) ? false:true
            noAchievementTitleLabel.text = data?.title
            noAchievementSubTitleLabel.text = data?.subTitle
        }
        collectionView.reloadData()
        heightConstraintConstant.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        self.contentView.layoutIfNeeded()
    }
    func prepareCollectionView() {
    
    collectionView.register(UINib(nibName: "AchievementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AchievementCollectionViewCell.reuseIdentifier)
    }
    // MARK: - UICollectionViewDataSource
   
   func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
       return data?.collectionData?.count ?? 0
   }
    
   func numberOfSections(in _: UICollectionView) -> Int {
       return 1
   }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementCollectionViewCell.reuseIdentifier, for: indexPath) as! AchievementCollectionViewCell
       cell.data = self.data?.collectionData?[indexPath.row]
       return cell
   }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        animateCell(indexPath, cell)
    }
   // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 116, height: 180)
       }
   
}
