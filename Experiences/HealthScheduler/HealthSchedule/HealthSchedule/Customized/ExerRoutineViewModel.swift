//
//  ExerRoutineViewModel.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/11/10.
//

import Foundation
import SwiftUI
class ExerRoutineViewModel : ObservableObject {
    var defaultuserdata = DefaultUserData()
    @Published var exerroutine = ExerRoutineModel(routine: 1)
}
