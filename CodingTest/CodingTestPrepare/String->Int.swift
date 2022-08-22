//==============================================================
//	문자열 s를 숫자로 변환한 결과를 반환하는 함수, solution을 완성하세요.
//	* s의 길이는 1 이상 5이하입니다.
//	* s의 맨앞에는 부호(+, -)가 올 수 있습니다.
//	* s는 부호와 숫자로만 이루어져있습니다.
//	* s는 "0"으로 시작하지 않습니다.
//==============================================================

import Foundation

struct StringtoInt {
	let userInput = readLine() ?? ""
	init(){
		solution(s: userInput)
	}
	func solution(s:String) -> Int {
		let strArray = Array(s)
		var tempString = ""
		var resultInt = 0
		if strArray.count <= 5{
			for i in 0 ... strArray.count-1 {
				
				if strArray[i] != "0" {
					//	연산자가 아니면
					if NumberFormatter().number(from: s) != nil{
						tempString += String(strArray[i])
					}
					//연산자면
					else if strArray[0] == "+" || strArray[0] == "-"{
						tempString += String(strArray[i])
					}
					// 문자면
					else {
						print("조건에 맞지 않습니다. (조건) 문자열에 문자가 포함되어있습니다.")
						return 0
					}
				}
				// 0 이거나 문자면
				else {
					print("조건에 맞지 않습니다. (조건) 첫 문자는 0 이외의 +,-,숫자가 와야합니다.")
				}
			}
			resultInt = Int(tempString) ?? 0
			print("변환된 숫자 : \(resultInt)")
			return resultInt
		}
		else{
			print("조건에 맞지 않습니다. (조건) 숫자의 길이는 1이상 5이하여야 합니다.")
			return 0
		}
	}
}


//	정답로직
//	알고보니 제한이라는게 들어오는 값들이 한정적이라는 뜻이였다! 이제라도 알았으니 됐다. 30일은 병원가고 31일은 일가니까 틈틈이 올려보자
func answer_solution(_ s:String) -> Int {
	// 함수의 반환값이 Int 형으로 Non-Optional 타입이므로 함수 끝에 !을 붙입니다.
	return Int(s)!
}
