//
//  ERCModel.swift
//  ExchangeRateCalculation
//
//  Created by KimWooJin on 2022/01/13.
//

import Foundation
import SwiftUI

struct ERCModel{
	var success : Bool
	var terms : String
	var privacy : String
	var timestamp : Int
	var source : String
	var quotes : [String:Double]
}

