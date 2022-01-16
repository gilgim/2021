//
//  ERCViewModel.swift
//  ExchangeRateCalculation
//
//  Created by KimWooJin on 2022/01/13.
//

import Foundation
import SwiftUI

class ERCViewModel : ObservableObject {
	
	//==================================================================
	//	<Json 변수>
	@ObservedObject var ercJson = Json(token: "9e5a3941f322dd08761175aa0482d222")
	@Published var ercModel = ERCModel(success: false, terms: "", privacy: "", timestamp: 0, source: "", quotes: ["" : 0])
	
	//==================================================================
	
	//==================================================================
	//	<KeyBoard 변수>
	@Published var receiptString = "한국(KRW)"
	@Published var showBool = false
	
	//	수취국가를 Picker로 선택할 수 있는데 Pick의 파라미터
	var receiptCountry = ["한국(KRW)","일본(JPY)","필리핀(PHP)"]
	//==================================================================
	
	//	Model의 데이터에 JSon을 넣어준다. Json을 직접 쓸 수 있지만, 단어의 편의, 생각회로의 편의상 Model 데이터를 사용한다.
	init(){
		ercModel.success = ercJson.e_RateJson.success
		ercModel.terms = ercJson.e_RateJson.terms
		ercModel.privacy = ercJson.e_RateJson.privacy
		ercModel.timestamp = ercJson.e_RateJson.timestamp
		ercModel.source = ercJson.e_RateJson.source
		ercModel.quotes = ercJson.e_RateJson.quotes
	}
	
	
	//==================================================================
	//	<Model <-> View>
	
	//	텍스트 필드에서 입력 받은 값을 넣는 변수
	@Published var ercCostDouble : Double = 0
	
	//	환율과 입력값을 계산하여 넣어주는 변수
	@Published var ercCostSum : Double = 0
		
	
	//	텍스트 필드에 들어오는 바인딩 값
	var ercCostBinding : Binding<String>{
		return Binding<String>(
			get: {
				// 초기값이 0 이라서 0일 때는 "" 을 리턴하여 holder가 나오게한다.
				if self.ercCostDouble != 0{
					return String(format: "%.0f",self.ercCostDouble)
				}
				else{
					return ""
				}
			}
			,set: {
				// 들어오는 값이 숫자임을 판단하고 숫자일 경우 수취금액 계산함수를 실행한다.
				if let value = NumberFormatter().number(from:$0){
					self.ercCostDouble = value.doubleValue
					self.Calc()
				}
			}
		)
	}
	
	//	<계산함수> : 사용자가 선택한 환율과 텍스트 필드에서 받아온 값을 연산하여 수취금액 변수에 넣는 함수
	func Calc(){
		self.ercCostSum = Double(String(format:"%.2f",self.ERCDouble(country: self.receiptString)))! * self.ercCostDouble
	}
	
	//	<단어변경 함수> : 나라 이름은 한글로 표현되어 있는데 나라 영어 표기로 바꿔주는 함수
	func ERCChangeWord() -> String{
		switch (self.receiptString){
		case "한국(KRW)" :
			return "KRW"
		case "일본(JPY)" :
			return "JPY"
		case "필리핀(PHP)" :
			return "PHP"
		default :
			return ""
		}
	}
	
	//	<환율 함수> : Picker에서 선택된 나라마다 환율값을 반환해주는 변수
	func ERCDouble (country:String)->Double{
		var temp : Double = 0
		switch (self.receiptString){
		case "한국(KRW)" :
			temp = Double(ercModel.quotes["USDKRW"]!)
		case "일본(JPY)" :
			temp = Double(ercModel.quotes["USDJPY"]!)
		case "필리핀(PHP)" :
			temp = Double(ercModel.quotes["USDPHP"]!)
		default :
			return 0
		}
		return temp
	}
		
		
	//	<타임스태프 변환 함수> : 들어온 타임스탬프를 해당 리턴 형식으로 반환하는 함수
	func ERCTimeStamp(timestamp : Int)->String{
		let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
		let year = Calendar.current.component(.year, from: date)
		let month = Calendar.current.component(.month, from: date)
		let day = Calendar.current.component(.day, from: date)
		let hour = Calendar.current.component(.hour, from: date)
		let minute = Calendar.current.component(.minute, from: date)
		return "\(year)-\(month)-\(day) \(hour):\(minute)"
	}
	//==================================================================
}

//	키보드 Hide를 위해 함수 추가
extension UIApplication {
   func endEditing() {
	   sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
