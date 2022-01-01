//
//  Harshad number.swift
//  CodingTestPrepare
//
//  Created by KimWooJin on 2022/01/01.
//

import Foundation

func solution(_ x:Int) -> Bool {
	var strInt = Array(String(x))
	var tempInt = 0
	for i in 0 ..< strInt.count{
		print("\(strInt[i]) : \(type(of: strInt[i]))")
		
		tempInt += Int(String(strInt[i]))!
	}
	if x % tempInt == 0 {
	return true
	}
	else {
	return false
	}

//	아래는 간결한 식이다. 보고 배우자
//	return x % String(x).reduce(0, {$0+Int(String($1))!}) == 0
}
