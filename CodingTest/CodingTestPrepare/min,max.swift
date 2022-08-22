//
//  min,max.swift
//  CodingTestPrepare
//
//  Created by KimWooJin on 2022/01/02.
//

import Foundation
struct maxmin {
	func solution(_ n:Int, _ m:Int) -> [Int] {
		var nArr : [Int] = []
		var mArr : [Int] = []
		var maxNum = 0
		var minNum = 0
		// 최대공약수 구하기
		for i in 1...n {
			// 약수 구하기
			if n % i == 0 {
				nArr.append(i)
			}
		}
		for i in 1...m {
			// 약수 구하기
			if m % i == 0 {
				mArr.append(i)
			}
		}
		
		for i in 0 ..< nArr.count{
			if mArr.contains(nArr[nArr.count - 1 - i]) {
				maxNum = nArr[nArr.count - 1 - i]
				break
			}
			else {
			}
		}

		minNum = maxNum
		while (true) {
			if minNum % n == 0 && minNum % m == 0 {
				break
			}
			else{
				minNum += maxNum
			}
		}
		return [maxNum,minNum]
	}
}

//	정답
//	func gcd(_ a: Int, _ b: Int) -> Int {
//		let mod: Int = a % b
//		return 0 == mod ? min(a, b) : gcd(b, mod)
//	}
//
//	func lcm(_ a: Int, _ b: Int) -> Int {
//		return a * b / gcd(a, b)
//	}
//
//	func solution(_ n:Int, _ m:Int) -> [Int] {
//		return [gcd(n, m), lcm(n, m)]
//	}
