//
//  ViewModel.swift
//  Healthify
//
//  Created by Blessy Elizabeth Saini on 26/03/2022.
//

import UIKit

enum State {
    case noValues
    case ten
    case fifteen
    case twenty
    case twentyFive
    case thirty
    case thirtyFive
    case fourty
    
    var imageString: String {
        switch self {
        case .noValues:
            return ""
        case .ten:
            return "ten"
        case .fifteen:
            return "fifteen"
        case .twenty:
            return "twenty"
        case .twentyFive:
            return "twentyFive"
        case .thirty:
            return "thirty"
        case .thirtyFive:
            return "thirtyFive"
        case .fourty:
            return "fourty"
        }
    }
    var valueString: String {
        switch self {
        case .noValues:
            return ""
        case .ten:
            return "10K"
        case .fifteen:
            return "15K"
        case .twenty:
            return "20K"
        case .twentyFive:
            return "25K"
        case .thirty:
            return "30K"
        case .thirtyFive:
            return "35K"
        case .fourty:
            return "40K"
        }
    }
    
}
class UsersStepsCountViewModel: NSObject {

    func getViewData(xValues:[Date]?, yValues: [Double]?) -> [Any] {
        var data = [Any]()
        data.append(getProFileData())
        data.append(getStepsData())
        data.append(getChartData(xValues: xValues, yValues: yValues))
        data.append(getAchievementData())
        return data
    }
    
    func save(stepCount: Int32?, date: Date?) {
        let step = Step(context: CoreDataManager.shared.viewContext)
        if let stepCount = stepCount {
            
            step.count = stepCount
            step.date = date
            step.month = Int32(date?.get(.month) ?? Date().get(.month))
        } 
        CoreDataManager.shared.save()
        
    }
    func delete() {
        CoreDataManager.shared.delete()
    }
    func getTotalStepsCount() -> Int{
        let steps = CoreDataManager.shared.getAllDataForCurrentMonth().map(StepsModel.init)
        
        let result =  steps.reduce(0) { $0 + $1.count }
        return result
    }
    func getAllStepsForCurrentMonth() -> [StepsModel]{
        let steps = CoreDataManager.shared.getAllDataForCurrentMonth().map(StepsModel.init)
        return steps
    }
    
    func getProFileData() -> ProfileTableViewCellModel {
        return ProfileTableViewCellModel(profile: "profile")
    }
    
    func getStepsData(_ stepCount: String? = nil)  -> StepsTableViewCellModel {
        let date = Date()
        let step = String(getTotalStepsCount())
        return StepsTableViewCellModel(title: AppStrings.steps.localized, stepValue: step, dateValue: date.getCurrentMonthAndYear())
    }
    func getChartData(xValues:[Date]?, yValues: [Double]?) -> ChartTableViewCellModel  {
        return ChartTableViewCellModel(xValues: xValues, yValues: yValues)
    }
    func getAchievementData() -> AchievementsTableViewCellModel{
        let step = getTotalStepsCount()
        let state = getUserAchievedState(step)
        var userAchievedSteps = [AchievementCollectionViewCellModel]()
        userAchievedSteps = [AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.ten.valueString, imageValue: State.ten.imageString)
            ,AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.fifteen.valueString, imageValue: State.fifteen.imageString),AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.twenty.valueString, imageValue: State.twenty.imageString)
    ,AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.twentyFive.valueString, imageValue: State.twentyFive.imageString),AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.thirty.valueString, imageValue: State.thirty.imageString)
       ,AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.thirtyFive.valueString, imageValue: State.thirtyFive.imageString)
    ,AchievementCollectionViewCellModel(goalAchievedTitle: AppStrings.goalAchievement.localized, goalAchievedValue: State.fourty.valueString, imageValue: State.fourty.imageString)]
       
        switch state {
        case .noValues:
            return AchievementsTableViewCellModel(state: .noValues, title: AppStrings.noAchievementsYet.localized, subTitle: AppStrings.keepWalking.localized)
       
        case .ten:
            return AchievementsTableViewCellModel(state: .ten,  collectionData:  Array(userAchievedSteps.prefix(1)))
        case .fifteen:
            return AchievementsTableViewCellModel(state: state,  collectionData: Array(userAchievedSteps.prefix(2)))
        
        case .twenty:
            return AchievementsTableViewCellModel(state: state,  collectionData: Array(userAchievedSteps.prefix(3)))
        case .twentyFive:
            return AchievementsTableViewCellModel(state: .twentyFive,  collectionData: Array(userAchievedSteps.prefix(4)))
        
        case .thirty:
            return AchievementsTableViewCellModel(state: .thirty,  collectionData: Array(userAchievedSteps.prefix(5)))
       
        case .thirtyFive:
            return AchievementsTableViewCellModel(state: .thirtyFive,  collectionData: Array(userAchievedSteps.prefix(6)))
       
        case .fourty:
            return AchievementsTableViewCellModel(state: .fourty,  collectionData: userAchievedSteps)
        }
    
    }
    
    func getUserAchievedState(_ stepCount: Int) -> State{
        var state: State
        let stepsAchieved = stepCount

        switch stepsAchieved {
        case 0...9999:
            state = .noValues

        case 10000...14999:
            state = .ten

        case 15000...19999:
            state = .fifteen
        
        case 20000...24999:
            state = .twenty
            
        case 25000...29999:
            state = .twentyFive
       
        case 30000...34999:
            state = .thirty
            
        case 35000...39999:
            state = .thirtyFive
      
        default:
            state = .fourty
        }
        return state
    }
    

}
