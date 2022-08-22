//
//  JsonParsing.swift
//  ExchangeRateCalculation
//
//  Created by KimWooJin on 2022/01/12.
//

import Foundation
import UIKit
import SwiftUI

//	환율 JSON 키
struct e_RateJsonFrame : Codable {
	var success : Bool
	var terms : String
	var privacy : String
	var timestamp : Int
	var source : String
	var quotes : [String:Double]
}

class Json : ObservableObject {
	
	// Json 데이터가 들어오지 않으면 초기값이 반환된다.
	@Published var e_RateJson : e_RateJsonFrame = e_RateJsonFrame(success: false, terms: "", privacy: "", timestamp: 0, source: "", quotes: ["" : 0])
	
	//	Json클래스가 생성될 때 토큰을 입력받고 loadJson함수를 실행한다.
	init(token:String){
		loadJson(token)
	}
	
	//	Json로드 하기 위한 함수
	func loadJson(_ token: String){
		let apiUrl = "http://api.currencylayer.com/live?access_key=\(token)&format=1"
		
		//	URLSession이 비동기 함수이기 때문에 대입을 하기위한 동기식 진행을 위해 DispatchSemaphore 사용
		let semaphore = DispatchSemaphore(value: 0)
		
			if let url = URL(string: apiUrl) {
				
			//	URL세션을 통해서 주소지에 있는 데이터 값을 가져온다. (비동기)
				URLSession.shared.dataTask(with: url) { data, response, error in
					if let data = data {

					//	JSONDecoder를 따로 안빼줘도 되지만 이해를 돕기위해 빼줬다.
					let jsonDecoder = JSONDecoder()
						do {
						let jsonData = try jsonDecoder.decode(e_RateJsonFrame.self, from: data)

							self.e_RateJson = jsonData
							
							//	e_RateJson에 대입을 하고 난 다음에 signal을 주어 진행시킨다.
							semaphore.signal()
							
						}
						catch let error {
							print("에러가 발생했습니다. 다음 에러는 이와 같습니다.\n\(error)")
						}
					}
				}.resume()
				
				//	resume()이 실행되고 비동기 진행이지만 wait를 통해 기다려준다.
				semaphore.wait()
			}
	}
}
