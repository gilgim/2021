//
//  CalculViewModel.swift
//  Calculater
//
//  Created by KimWooJin on 2021/12/18.
//

import Foundation
//==================================================================
//	<MVVM 디자인 패턴의 ViewModel>
//	View의 이벤트에 따른 Model 데이터의 변화를 구성한다.
//	포함요소 : {Property Wrapper 변수, 후위식 변환함수, 후위식, 결과값}
//==================================================================
class CalculViewModel : ObservableObject {
	//--------------------------------------------------------------
	//	<Model과 View를 연결 시키는 Property Wrapper 변수>
		@Published var calcul = CalculModel(stack: [], mathExpression: [], postfixNotation: [],result: 0)
	//--------------------------------------------------------------
	
	// MARK: 입력식을 후위식으로 바꾸는 함수
	//--------------------------------------------------------------
	//	입력식을 함수로 변환하는 함수
	//--------------------------------------------------------------
	func CalculFunc()->Double{
		
		//	연산을 여러번 시도했을 때 후위식이 비어있지 않으면 겹쳐지기때문에 초기화한다.
		self.calcul.postfixNotation = []
		
		
		//	두자리 숫자일 때 String에 + 하기 위한 임시스트링
		var tempString = ""
		
		//	입력된 문자열 만큼 루프를 돈다.
		for i in calcul.mathExpression.indices {
			
			//	내부에 후위식 오류가 발생하면 루프를 여기로 빠지게한다.
			if self.calcul.postfixNotation == Array(arrayLiteral: "오류입니다."){
				
			}
			
			//	내부에 오류가 없을 시 여기 else문으로 들어와 아래 로직을 실행한다.
			else{
				
				//	정상적인 식은 마지막에 ")"와 숫자만 오기때문에 판별해준다.
				if i != calcul.mathExpression.count - 1 {
					
					//=================================================================================
					//	두자리 이상, 소수점 단위에 숫자 만들기.
					//=================================================================================
					
					//	하나 씩 읽을 때 숫자와 연산자는 구분을 해야하기 때문에 숫자 판별 if문
					if NumberFormatter().number(from:calcul.mathExpression[i]) != nil {
						
						//	두자리 이상 숫자 일 경우도 생각 -> 그 다음 인자가 숫자 . 인지 연산자인지 판별
						if	NumberFormatter().number(from:calcul.mathExpression[i+1]) != nil || calcul.mathExpression[i+1] == "."{
							
							//	숫자나 . 일 경우 임시스트링에 더해준다.
							tempString += calcul.mathExpression[i]
							
						}
						
						//	i + 1 이 연산자 일 경우
						else{
							
							//	현재 i까지 임시스트링에 더해준다.
							tempString += calcul.mathExpression[i]
							
							//	임시스트링(완전해진 숫자)를 후위식에 넣고, 임시스트링을 초기화 해준다.
							self.calcul.postfixNotation.append(tempString)
							tempString = ""
						}
					}
					
					//	.일 경우도 임시스트링에 더해야한다.
					else if calcul.mathExpression[i] == "."{
						tempString += calcul.mathExpression[i]
					}
					
					//=========================<두자리 이상, 소숫점 단위 숫자 만들기 끝>==========================
					
					//	입력식을 하나하나 읽을 때 i가 연산자일 경우
					else {
						//=================================================================================
						//	<오류 모음>
						//	*와 /는 연속적으로 올 수 없는 연산기호이다.
						//	따로 오류로 지정해서 판단해주었다.
						if calcul.mathExpression[i] == "*" && calcul.mathExpression[i+1] == "*" {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
						}
						else if calcul.mathExpression[i] == "*" && calcul.mathExpression[i+1] == "/" {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
						}
						else if calcul.mathExpression[i] == "/" && calcul.mathExpression[i+1] == "/" {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
						}
						else if calcul.mathExpression[i] == "/" && calcul.mathExpression[i+1] == "*" {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
						}
						//=================================================================================
						
						else{
							//	들어온 연산기호에 따라 pop되는 경우가 달라진다.
							switch(calcul.mathExpression[i]){
							case "+":
								
								//	스택에 아무것도 들어 있지 않다면 바로 자신을 넣어준다.
								if calcul.stack.count == 0 {
									calcul.stack.append("+")
								}
								
								//	스택에 무언가 들어있다면 무조건 poplast되어야하고 마지막에 자신을 스택에 넣어준다.
								else {
									
									//	poplast되면 stack의 크기가 변하기 때문에 임시카운트에 그 크기를 저장해주어야한다.
									let tempCount = calcul.stack.count
									
									//	스택의 크기만큼 돌아가는 for문
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "+")
										
										//	마지막까지 for문이 돌았을 경우에 스택에 해당 연산자를 넣어준다.
										if j == tempCount-1{
											calcul.stack.append("+")
										}
									}
									
									
									//	스택의 크기가 처음엔
//									if calcul.stack.count == 0{
//										calcul.stack.append("+")
//									}
								}
							case "-":
								if calcul.stack.count == 0 {
									calcul.stack.append("-")
								}
								else {
									let tempCount = calcul.stack.count
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "-")
										if j == tempCount-1 {
											calcul.stack.append("-")
										}
									}
								}
							case "*":
								if calcul.stack.count == 0 {
									calcul.stack.append("*")
								}
								else {
									let tempCount = calcul.stack.count
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "*")
										if j == tempCount-1 {
											calcul.stack.append("*")
										}
									}
								}
							case "/":
								if calcul.stack.count == 0 {
									calcul.stack.append("/")
								}
								else {
									let tempCount = calcul.stack.count
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "/")
										if j == tempCount-1 {
											calcul.stack.append("/")
										}
									}
								}
							case "(":
								print(calcul.mathExpression.count)
								if i-1 < calcul.mathExpression.count-1 && i-1 > 0 {
									if NumberFormatter().number(from:calcul.mathExpression[i-1]) != nil {
										calcul.stack.append("*")
									}
								}
								calcul.stack.append("(")
							case ")":
								if calcul.stack.contains("("){
									while calcul.stack[calcul.stack.count-1] != "(" {
										self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
									}
									if calcul.stack[calcul.stack.count-1] == "("{
										calcul.stack.remove(at: calcul.stack.count-1)
									}
								}
								else {
									self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
									break
								}
							default:
								print("")
							}
						}
					}
				}
				//	마지막이라면? 숫자거나 )이거겠지
				else {
					//	마지막인데 숫자야
					if NumberFormatter().number(from:calcul.mathExpression[i]) != nil {
						tempString += calcul.mathExpression[i]
						self.calcul.postfixNotation.append(tempString)
						while calcul.stack.count != 0 {
							self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
						}
					}
					else if calcul.mathExpression[i] == ")" {
						if calcul.stack.contains("("){
							while calcul.stack[calcul.stack.count-1] != "(" {
								self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
							}
							if calcul.stack[calcul.stack.count-1] == "("{
								calcul.stack.remove(at: calcul.stack.count-1)
							}
							while calcul.stack.count != 0 {
								self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
							}
						}
						else {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
							break
						}
					}
					//	이건 오류되어야한다
					else{
						self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
					}
				}

			}
		}
		if calcul.stack.isEmpty == false{
			self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
		}
		
		//======================================================================================================
		//	후위식으로 변환
		//======================================================================================================
		else {
			for i in self.calcul.postfixNotation.indices {
				var twoIntArray : [Double] = [Double](repeating: 0, count: 2)
				if i > calcul.postfixNotation.count - 1 {
					self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
				}
				else {
					if NumberFormatter().number(from:calcul.postfixNotation[i]) != nil {
						self.calcul.stack.append(calcul.postfixNotation[i])
					}
					else if calcul.postfixNotation[i] == "+"{
						twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						self.calcul.stack.append(String(twoIntArray[0]+twoIntArray[1]))
					}
					else if calcul.postfixNotation[i] == "-"{
						twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						self.calcul.stack.append(String(twoIntArray[0]-twoIntArray[1]))
					}
					else if calcul.postfixNotation[i] == "*"{
						twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						self.calcul.stack.append(String(twoIntArray[0]*twoIntArray[1]))
					}
					else if calcul.postfixNotation[i] == "/"{
						twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? 0
						self.calcul.stack.append(String(twoIntArray[0]/twoIntArray[1]))
					}
					if i == self.calcul.postfixNotation.count-1 {
						calcul.result = Double(calcul.stack.popLast() ?? "") ?? 0
					}
				}
			}
		}
		
		return	calcul.result
	}
	
	func operatorPop(operatorString : String){
		
		if operatorString == "+" || operatorString == "-"{
			
			if calcul.stack[calcul.stack.count-1] == "+"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "-"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "*"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "/"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "("{
				
			}
		}
		
		else if operatorString == "*" || operatorString == "/"{
			if calcul.stack[calcul.stack.count-1] == "+"{
				
			}
			else if calcul.stack[calcul.stack.count-1] == "-"{
				
			}
			else if calcul.stack[calcul.stack.count-1] == "*"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "/"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\0")
			}
			else if calcul.stack[calcul.stack.count-1] == "("{
				
			}
		}
		
	}
}
