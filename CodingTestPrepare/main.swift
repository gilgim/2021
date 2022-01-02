

import Foundation

//StringtoInt()
//Harshad()

//func solution(_ arr:[Int]) -> [Int] {
//	let min = arr.sorted(by: <)[0]
//	 return arr.count == 1 ? [-1] : arr.compactMap({ return $0 != min ? $0 : nil })
//}
////	정답
////func solution(_ arr:[Int]) -> [Int] {
////	let min = arr.sorted(by: <)[0]
////	 return arr.count == 1 ? [-1] : arr.compactMap({ return $0 != min ? $0 : nil })
////}
//solution([41,23,15,1,245,4,123,515])

//func solution(_ n:Int64) -> [Int] {
//	var arr1 = Array(String(n))
//	arr1.reversed()
//	let arr2 = arr1.reversed().map({(value:Character) -> Int in return Int(String(value))!})
//	print(arr2)
//	return arr2
//}
////	정답
////	"\(n)".compactMap { $0.hexDigitValue }.reversed()
//
//solution(123123)

func solution(_ n:Int) -> Int
{
	var answer:Int = 0

	// [실행] 버튼을 누르면 출력 값을 볼 수 있습니다.
	answer = Array(String(n)).map({return Int(String($0))!}).reduce(0,{return $0+$1})
	return answer
}

