

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

//func solution(_ n:Int) -> Int
//{
//	var answer:Int = 0
//
//	// [실행] 버튼을 누르면 출력 값을 볼 수 있습니다.
//	answer = Array(String(n)).map({return Int(String($0))!}).reduce(0,{return $0+$1})
//	return answer
//}
//

//func solution(_ s:String) -> String {
//	let arr1 = s.components(separatedBy: " ")
//	var arr2 : [String] = []
//	var sString = ""
//	for i in 0..<arr1.count{
//		var temp = ""
//		for j in 0..<Array(arr1[i]).count {
//			if j == 0 || j % 2 == 0 {
//				temp += Array(arr1[i])[j].uppercased()
//			}
//			else {
//				temp += Array(arr1[i])[j].lowercased()
//			}
//		}
//		arr2.append(temp)
//		sString = arr2.joined(separator: " ")
//	}
//	print(sString)
//	return sString
//}
// 정답
//func solution(_ s:String) -> String {
//	let a = s.components(separatedBy: " ").map { $0.enumerated().map { $0.offset % 2 == 0 ? $0.element.uppercased() : $0.element.lowercased() } }
//	return a.map{ $0.map { $0 }.joined() }.joined(separator: " ")
//}
//solution("try hello world")

//func solution(_ s:String, _ n:Int) -> String {
//	var arr0 : [Character] = Array(s)
//	var arr1 : [Int] = []
//	var arr2 : [String] = []
//	for i in 0..<arr0.count{
//		// 대문자
//		if String(arr0[i]) == String(arr0[i]).uppercased(){
//			if Int(UnicodeScalar(String(arr0[i]))!.value) + n >= 65 && Int(UnicodeScalar(String(arr0[i]))!.value) + n <= 90 {
//				arr1.append(Int(UnicodeScalar(String(arr0[i]))!.value) + n)
//			}
//			else if arr0[i] == " " {
//				arr1.append(Int(UnicodeScalar(" ").value))
//			}
//			else {
//				arr1.append(Int(UnicodeScalar(String(arr0[i]))!.value) + n - 90 + 64)
//			}
//		}
//		else{
//			if Int(UnicodeScalar(String(arr0[i]))!.value) + n >= 97 && Int(UnicodeScalar(String(arr0[i]))!.value) + n <= 122 {
//				arr1.append(Int(UnicodeScalar(String(arr0[i]))!.value) + n)
//			}
//			else if arr0[i] == " " {
//				arr1.append(Int(UnicodeScalar(" ").value))
//			}
//			else {
//				arr1.append(Int(UnicodeScalar(String(arr0[i]))!.value) + n - 122 + 96)
//			}
//		}
//	}
//	for i in 0 ..< arr1.count {
//		arr2.append(String(UnicodeScalar(arr1[i])!))
//	}
//	return arr2.joined(separator: "")
//}
//solution("A B y", 1)
//
//// 정답
//func solution(_ s:String, _ n:Int) -> String {
//	let alphabets = "abcdefghijklmnopqrstuvwxyz".map { $0 }
//	return String(s.map {
//		guard let index = alphabets.firstIndex(of: Character($0.lowercased())) else { return $0 }
//		let letter = alphabets[(index + n) % alphabets.count]
//		return $0.isUppercase ? Character(letter.uppercased()) : letter
//	})
//}
//solution("a b g", 4)


//struct Person : Codable {
//	var name : String
//	var age : Int
//}
//let encoder = JSONEncoder()
//encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
//let zedd = Person(name: "Zedd", age: 100)
//let jsonData = try? encoder.encode(zedd)
//if let jsonData = jsonData,let jsonString = String(data: jsonData, encoding: .utf8){
//	print(jsonString)
//}
//let jsonString = """
//{
//
//"name" : "Zedd",
//
//"age" : 100
//
//}
//"""
//let decoder = JSONDecoder()
//var data = jsonString.data(using: .utf8)
//if let data = data, let myPerson  = try? decoder.decode(Person.self, from: data){
//	print(myPerson.name)
//	print(myPerson.age)
//}

struct Song:Codable{
	var singer : String
	var album : String
	var title : String
	var duration : Int
	var image : String
	var file : String
	var lyrics : String
}
let decoder = JSONDecoder()
var data = try String(contentsOf: URL(string: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json")!).data(using: .utf8)
if let data = data, let mySong = try? decoder.decode(Song.self, from: data){
	print(mySong.singer)
	print(type(of: mySong))
	print(mySong.title)
}
