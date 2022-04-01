//
//  ViewController.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit
import HealthKit


class UsersStepsCountViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var stepCount: String?
    var viewData = [Any]()
    var viewModel: UsersStepsCountViewModel?
    var healthStore: HealthStore?
    var state: State = .noValues
    
    //MARK: - View Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        viewModel = UsersStepsCountViewModel()
        healthStore = HealthStore()
        prepareTableView()
        requestForPermission()
        prepareUI()
     
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    //MARK: - Custom Methods
    func prepareUI() {
        let userName = UIDevice.current.name.components(separatedBy: " ")
        self.title = userName.first
        print(userName)
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    func requestForPermission() {
        
        healthStore?.requestForPermission { bool in
            if (bool) {
                var stepsArray = [Double]()
                var dateArray = [Date]()
                if self.viewModel?.getAllStepsForCurrentMonth().count != 0 {
                    self.viewModel?.delete()
                }
                self.healthStore?.importStepsHistory { statistics in
                    if let sum = statistics.sumQuantity() {
                        let steps = sum.doubleValue(for: HKUnit.count())
                        let date = statistics.startDate
                        self.viewModel?.save(stepCount: Int32(steps), date: date)
                        print("Amount of steps:\(steps) date:\(statistics.endDate)")
                        stepsArray.append(steps)
                        dateArray.append(date)
                    }
                    DispatchQueue.main.async {
                        self.viewData = self.viewModel?.getViewData(xValues: dateArray, yValues: stepsArray) ?? []
                        self.tableView.reloadData()
                    }
                }
            
                if self.stepCount == nil {
                    DispatchQueue.main.async {
                        self.viewData = self.viewModel?.getViewData(xValues: nil, yValues: nil) ?? []
                    self.tableView.reloadData()
                    }
                }
            }
           
        }
    
    }

    func prepareTableView() {
        tableView.register(UINib(nibName: ProfileTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: StepsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: StepsTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: ChartTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ChartTableViewCell.reuseIdentifier)
        tableView.register(UINib(nibName: AchievementsTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AchievementsTableViewCell.reuseIdentifier)
        
        tableView.estimatedRowHeight = 200.0
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.viewData[indexPath.row]
        switch data {
        
         case is ProfileTableViewCellModel:
            if let cellData = data as? ProfileTableViewCellModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as! ProfileTableViewCell
                cell.data = cellData
                return cell
            }
        case is StepsTableViewCellModel:
            if let cellData = data as? StepsTableViewCellModel {
              
                let cell = tableView.dequeueReusableCell(withIdentifier: StepsTableViewCell.reuseIdentifier, for: indexPath) as! StepsTableViewCell
                cell.data = cellData
                return cell
            }
        case is ChartTableViewCellModel:
            if let cellData = data as? ChartTableViewCellModel {
              
                let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.reuseIdentifier, for: indexPath) as! ChartTableViewCell
                cell.data = cellData
                return cell
            }
        case is AchievementsTableViewCellModel:
            if let cellData = data as? AchievementsTableViewCellModel {
              
                let cell = tableView.dequeueReusableCell(withIdentifier: AchievementsTableViewCell.reuseIdentifier, for: indexPath) as! AchievementsTableViewCell
                cell.data = cellData
                return cell
            }
      
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}


