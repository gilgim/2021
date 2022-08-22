//
//  map, filter, reduce.swift
//  CodingTestPrepare
//
//  Created by KimWooJin on 2022/01/02.
//

import Foundation

/*	고차함수란?
	다른 함수를 전달 인자로 받거나 함수실행의 결과를 함수로 반환하는 함수
 */
//	===================================================
//	map : 데이터 변형
//	===================================================

struct Ex_map {
	func exFor () {
		let arr1 = [1,3,5,7,9]
		var mulArr = [Int]()
		
		for num in arr1 {
			mulArr.append(num * 2)
		}
	}
	func exMap() {
		let arr1 = [1,3,5,7,9]
		let mulArr = arr1.map({(number:Int) -> Int in number * 2 })
	}
}

//	filter : 데이터 추출
struct Ex_filter {
	func exFor () {
		let stringAttay = ["가수", "대통령", "개발자", "선생님", "의사", "검사", "건물주"]
		var threeCountArray = [String]()
		for st in stringAttay {
			if st.count == 3 {
				threeCountArray.append(st)
			}
		}
	}
	func exFilter() {
		let stringAttay = ["가수", "대통령", "개발자", "선생님", "의사", "검사", "건물주"]
		let threeCountArray = stringAttay.filter { $0.count == 3 }
	}
}

//	reduce : 데이터를 합치기위함

struct Ex_reduce {
	func exFor () {
		let numberArray = [1,2,3,4,5,6,7,8,9,10]
		var sum = 0
		for number in numberArray {
			sum += number
		}
	}
	func exReduce() {
		let numberArray = [1,2,3,4,5,6,7,8,9,10]
		let sum = numberArray.reduce(0) { $0 + $1 }
		print(sum)
	}
}

