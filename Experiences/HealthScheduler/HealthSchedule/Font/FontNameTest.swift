//
//  FontNameTest.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/30.
//

import Foundation
import SwiftUI
struct FontTest {
    func fonttest(){
        for family: String in UIFont.familyNames {
                        print(family)
                        for names : String in UIFont.fontNames(forFamilyName: family){
                            print("=== \(names)")
                        }
                    }
    }
}
