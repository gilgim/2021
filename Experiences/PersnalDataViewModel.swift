//
//  PersnalDataViewModel.swift
//  HealthCalendar
//
//  Created by KimWooJin on 2021/11/18.
//

import Foundation
import SwiftUI
/**
 ///=================================================================
 /// PersnalData의 ViewModel
 /// Observable 상속 Class
 /// View에서 발생되는 이벤트에 의해서 Model에 데이터를 변경시키고
 /// Model에 데이터를 가공해서 View에 전달한다.
 ///=================================================================
 */
class PersnalDataViewModel : ObservableObject {
    //=================================================================
    // View에 즉각적으로 스트리밍되는 데이터
    // Number type의 프로퍼티들은 TextField에서 값을 모두 지우게되면 1이 되므로 1로 설정한다.
    @Published var persnalData = PersnalDataModel(name: "", age: 1, height: 1, weight: 1)
    //=================================================================
    // MARK: 바인딩 변수 시작점
    //=================================================================
    // 사용자 이름
    // MARK: 이름
    //=================================================================
    var namePush : Bool = false                         // TextField 클릭 시 변하는 값
    var nameBinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.namePush {                      // TextField 클릭 시 ""값을 반환
                    return ""
                }
                else {                                // TextField의 기본 값은 pernalData.name 값
                    return self.persnalData.name
                }
            },
            set:{
                if $0 != "" {                          // TextField의 들어오는 값이 "" 이 아닐 경우에 pernalData.name에 넣어준다.
                    self.persnalData.name = $0
                }
            }
        )
    }

    //=================================================================
    // 사용자 나이
    // MARK: 나이
    //=================================================================
    var agePush : Bool = false                         // TextField 클릭 시 변하는 값
    var ageBinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.agePush {                      // TextField 클릭 시 ""값을 반환
                    return ""
                }
                else if self.persnalData.age == 1 || self.persnalData.age == 0{     //해당 값이 0이거나 1이면 빈칸반환
                    return ""
                }
                else {                                // TextField의 기본 값은 pernalData.name 값
                    return String(format: "%d살", self.persnalData.age)
                }
            },
            set:{                          // TextField의 들어오는 값이 숫자일 경우 pernalData.age 에 넣어준다.
                if let value = NumberFormatter().number(from:$0){
                    self.persnalData.age = value.int16Value
                }
            
            }
        )
    }
    
    //=================================================================
    // 사용자 키
    // MARK: 키
    //=================================================================
    var heightPush : Bool = false                         // TextField 클릭 시 변하는 값
    var heightBinding : Binding<String> {
        return Binding<String>(
            get:{
                if self.heightPush {                      // TextField 클릭 시 ""값을 반환
                    return ""
                }
                else if self.persnalData.height == 1 || self.persnalData.height == 0{     //해당 값이 0이거나 1이면 빈칸반환
                    return ""
                }
                else {                                // TextField의 기본 값은 pernalData.height 값
                    return String(format: "%.1f cm", self.persnalData.height)
                }
            },
            set:{                          // TextField의 들어오는 값이 숫자일 경우 pernalData.height 에 넣어준다.
                if let value = NumberFormatter().number(from:$0){
                    self.persnalData.height = value.doubleValue
                }
            }
        )
    }
    //=================================================================
    // 사용자 몸무게
    // MARK: 몸무게
    //=================================================================
    var weightPush : Bool = false                           // TextField 클릭 시 변하는 값
    var weightBinding : Binding<String> {
        return Binding<String>(                              // TextField 클릭 시 ""값을 반환
            get:{
                if self.weightPush {
                    return ""
                }
                else if self.persnalData.weight == 1.0 || self.persnalData.weight == 0.0 {      //해당 값이 0이거나 1이면 빈칸반환
                    return ""
                }
                else {                                  // TextField의 기본 값은 pernalData.weight 값
                    return String(format: "%.1f kg", self.persnalData.weight)
                }
            },
            set:{                                       // TextField의 들어오는 값이 숫자일 경우 pernalData.weight 에 넣어준다.
                if let value = NumberFormatter().number(from:$0){
                        self.persnalData.weight = value.doubleValue
                }
            }
        )
    }
    // MARK: 바인딩 변수 끝
    
    //=================================================================
    // 버튼 비활성화 함수
    // MARK: 버튼 비활성화 함수
    //=================================================================
    func ButtonDisable() -> Bool{
        if  self.persnalData.name == ""
        || self.persnalData.age == 0 || self.persnalData.age == 1
        || self.persnalData.weight == 0 || self.persnalData.weight == 1
        || self.persnalData.height == 0 || self.persnalData.height == 1{            //버튼 비활성화를 위해 각 값이 의미가 없을경우 비활성화인 true 반환
            return true
        }
        else{
            return false
        }
    }
    
}

