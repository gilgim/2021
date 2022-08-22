//
//  SelectSequanceViewModel.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/27.
//

import Foundation
import SwiftUI
import CoreData
class  PersnalDataViewModel : ObservableObject {
    var defaultuserdata = DefaultUserData()
    @Published var persnaldata = PersnalDataModel(name: "", age: 1, weight: 1, heigth: 1)
    //* 바인딩 설정 View에 전달
    // * 이름 바인딩
    var namepushbool : Bool = false
    var namebinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.namepushbool {
                    return ""
                }
                else {
                    return self.persnaldata.name
                }
            },
            set:{
                if $0 != "" {
                    self.persnaldata.name = $0
                }
            }
        )
    }
    // * 나이 바인딩
    var agepushbool : Bool = false
    var agebinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.agepushbool {
                    return ""
                }
                else if self.persnaldata.age == 1 || self.persnaldata.age == 0{
                    return ""
                }
                else {
                    return String(format: "%d살", self.persnaldata.age)
                }
            },
            set:{
                if let value = NumberFormatter().number(from:$0){
                        self.persnaldata.age = value.intValue
                }
            
            }
        )
    }
    // * 키 바인딩
    
    var heightpushbool : Bool = false
    var heightbinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.heightpushbool {
                    return ""
                }
                else if self.persnaldata.heigth == 1 || self.persnaldata.heigth == 0{
                    return ""
                }
                else {
                    return String(format: "%.1f cm", self.persnaldata.heigth)
                }
            },
            set:{
                if let value = NumberFormatter().number(from:$0){
                    self.persnaldata.heigth = value.doubleValue
                }
            }
        )
    }
    // * 몸무게 바인딩
    var weightpushbool : Bool = false
    var weightbinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.weightpushbool {
                    return ""
                }
                else if self.persnaldata.weight == 1.0 || self.persnaldata.weight == 0.0 {
                    return ""
                }
                else {
                    return String(format: "%.1f kg", self.persnaldata.weight)
                }
            },
            set:{
                if let value = NumberFormatter().number(from:$0){
                        self.persnaldata.weight = value.doubleValue
                }
            }
        )
    }
    func buttonable() -> Bool{
        if self.persnaldata.name == ""  || self.persnaldata.age == 0 || self.persnaldata.heigth == 0 || self.persnaldata.weight == 0 || self.persnaldata.age == 1 || self.persnaldata.heigth == 1 || self.persnaldata.weight == 1 {
            return true
        }
        else {
            return false
        }
    }
}
