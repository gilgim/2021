//
//  SelectSequanceModel.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/27.
//

import Foundation
import SwiftUI
import CoreData

struct DefaultUserData {
    let userdevicewidth = UIScreen.main.bounds.width
    let userdeviceheight = UIScreen.main.bounds.height
}

struct PersnalDataModel {
    var name : String
    var age  : Int
    var weight : Double
    var heigth : Double
}
struct ExerRoutineModel {
    // * 루틴은 사람마다 다르고 자기가 정할 수 있기때문에 분할수로 정해야함
    var routine : Int
}

