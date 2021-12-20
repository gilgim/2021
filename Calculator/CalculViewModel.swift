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
//	포함요소 : {Property Wrapper 변수, 최종함수, 후위식 변환함수, 후위식 해석함수}
//==================================================================
class CalculViewModel : ObservableObject {
	//--------------------------------------------------------------
	//	<Model과 View를 연결 시키는 Property Wrapper 변수>
		@Published var calcul = CalculModel(stack: [], mathExpression: [], postfixNotation: [],result: Double.nan)
	//--------------------------------------------------------------
	
	//	두자리 숫자일 때 String에 + 하기 위한 임시스트링
	var tempString = ""
	
	// MARK: 뷰에서 실행시킬 최종함수
	//--------------------------------------------------------------
	//	뷰에서 실행시킬 최종함수
	//--------------------------------------------------------------
	func CalculFunc()->Double{
		
		//	여러번 눌렀을 수 도 있기 떄문에 항상 초기화 해준다
		calcul.postfixNotation = []
		tempString = ""
		calcul.stack = []
		calcul.result = Double.nan
		
		changepostfixNotation()
		
		//	스택이 빈 배열이 아니면 오류이다.
		if calcul.stack.isEmpty == false{
			self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
			print(calcul.result)
		}
		else {
			// 함수에서 오류가 났을 경우 계산식을 실행하지 않는다.
			if self.calcul.postfixNotation == Array(arrayLiteral: "오류입니다."){
				print(calcul.result)
			}
			else {
				postfixNotationCalcul()
			}
		}
		
		return	calcul.result
	}
	
	// MARK: 입력식을 후위식으로 바꾸는 함수
	//--------------------------------------------------------------
	//	입력식을 후위식으로 변환하는 함수
	//--------------------------------------------------------------
	func changepostfixNotation() {
		
		//	연산을 여러번 시도했을 때 후위식이 비어있지 않으면 겹쳐지기때문에 초기화한다.
		self.calcul.postfixNotation = []
		
		
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
						//	연산자는 연속적으로 올 수 없는 연산기호이다.
						//	따로 오류로 지정해서 판단해주었다.
						//	오류인 부분이 생각보다 많아서 오류가 아닌 부분을 if로 두었으면 더 좋을 거 같다.
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
										operatorPop(operatorString: "+",i: i)
										if NumberFormatter().number(from: calcul.mathExpression[i-1]) == nil {
											
										}
										else{
											//	마지막까지 for문이 돌았을 경우에 스택에 해당 연산자를 넣어준다.
											if j == tempCount-1 {
												calcul.stack.append("+")
											}
										}
									}
								}
							
							//	+의 주석과 순서가 같다.
							case "-":
								if calcul.stack.count == 0 {
									calcul.stack.append("-")
								}
								else {
									let tempCount = calcul.stack.count
									//	스택의 크기만큼 돌아가는 for문
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "-",i: i)
										if NumberFormatter().number(from: calcul.mathExpression[i-1]) == nil {
											
										}
										else{
											//	마지막까지 for문이 돌았을 경우에 스택에 해당 연산자를 넣어준다.
											if j == tempCount-1 {
												calcul.stack.append("-")
											}
										}
									}
								}
								
							//	+의 주석과 순서가 같다.
							case "*":
								if calcul.stack.count == 0 {
									calcul.stack.append("*")
								}
								else {
									let tempCount = calcul.stack.count
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "*",i: i)
										if j == tempCount-1 {
											calcul.stack.append("*")
										}
									}
								}
								
							//	+의 주석과 순서가 같다.
							case "/":
								if calcul.stack.count == 0 {
									calcul.stack.append("/")
								}
								else {
									let tempCount = calcul.stack.count
									for j in 0 ..< tempCount{
										operatorPop(operatorString: "/",i: i)
										if j == tempCount-1 {
											calcul.stack.append("/")
										}
									}
								}
							//===============================<사칙연산 마지막 부분>=================================
								
							//=================================================================================
							//	(,) 연산 처리 부분
							//=================================================================================
							case "(":
								
								//	괄호 앞에 숫자가 왔을 시에 *연산을 해야하기 때문에 i 바로 전 값의 존재를 확인
								if i-1 < calcul.mathExpression.count-1 && i-1 > 0 {
									
									//	괄호 전 값이 숫자라면 *연산을 집어넣어야한다.
									if NumberFormatter().number(from:calcul.mathExpression[i-1]) != nil {
										calcul.stack.append("*")
									}
									
								}
								
								//	괄호 앞에 숫자가 없다면 바로 여는 괄호를 스택에 집어넣는다.
								calcul.stack.append("(")
								
							case ")":
								//--------------------------------------------------------------
								//	)를 읽었다면 아래와 같은 로직이 필요하다.
								//	(를 만날 때까지 숫자는 후위식에 연산자는 스택에 집어넣는다.
								//	(를 만나면 스택에 있는 연산자를 poplast()해서 후위식에 넣는다.
								//--------------------------------------------------------------
								
								//	스택에 여는 괄호가 포함되있어야 올바른 식이다.
								if calcul.stack.contains("("){
									
									//	(가 나올 때 까지 스택의 마지막요소를 poplast()한다.
									while calcul.stack[calcul.stack.count-1] != "(" {
										self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
									}
									
									//	여는 괄호를 만났다면 그 괄호는 스택에서 그냥 지워준다.
									if calcul.stack[calcul.stack.count-1] == "("{
										calcul.stack.remove(at: calcul.stack.count-1)
									}
								}
								
								//	스택에 ( 가 없으면 잘못된 구문이므로 오류처리한다.
								else {
									self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
									break
								}
							//================================<괄호처리 끝>======================================
							default:
								self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
							}
						}
					}
				}
				//	마지막에는 숫자나 닫는 괄호만 오는게 정상적인 식이기 때문에 구문을 나눠준다.
				else if calcul.mathExpression[calcul.mathExpression.count - 1] == ")" || NumberFormatter().number(from:calcul.mathExpression[calcul.mathExpression.count - 1]) != nil{
					
					//--------------------------------------------------------------
					//	입력식의 마지막이 연속적숫자 나 단일 숫자를 생각해 임시스트링에 숫자를 넣어준다.
					//	후위식에 임시스트링을 넣어주고 스택의 모든 요소를 후위식에 넣어준다.
					//--------------------------------------------------------------
					if NumberFormatter().number(from:calcul.mathExpression[i]) != nil {
						tempString += calcul.mathExpression[i]
						self.calcul.postfixNotation.append(tempString)
						while calcul.stack.count != 0 {
							self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
						}
					}
					
					//--------------------------------------------------------------
					//	)를 읽었다면 아래와 같은 로직이 필요하다.
					//	(를 만날 때까지 숫자는 후위식에 연산자는 스택에 집어넣는다.
					//	(를 만나면 스택에 있는 연산자를 poplast()해서 후위식에 넣는다.
					//	마지막이 ) 이기때문에 스택에 있는 모든 요소를 후위식에 넣어준다.
					//--------------------------------------------------------------
					else if calcul.mathExpression[i] == ")" {
						if calcul.stack.contains("("){
							while calcul.stack[calcul.stack.count-1] != "(" {
								self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
							}
							if calcul.stack[calcul.stack.count-1] == "("{
								calcul.stack.remove(at: calcul.stack.count-1)
							}
							while calcul.stack.count != 0 {
								self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
							}
						}
						//	스택에 ( 가 없으면 잘못된 구문이므로 오류처리한다.
						else {
							self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
							break
						}
					}
					//	)와 숫자를 제외한 혹시 다른 값이 들어올 수 있기때문에 오류처리해준다.
					else{
						self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
					}
				}
				//	마지막에 숫자나 닫는 괄호가 아닌 모든 경우에 수는 오류이다.
				else {
					self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
				}

			}
		}
	}
	
	// MARK: 연산자에 따른 스택연산함수
	//--------------------------------------------------------------
	//	연산자에 따른 스택연산함수
	//--------------------------------------------------------------
	func operatorPop(operatorString : String , i : Int){
		//--------------------------------------------------------------
		//	+,- 일 경우에 스택에 있는 모든 연산자가 나와야한다.
		//	- 앞에 연산자가 올 경우 음수 취급을 해야한다.
		//--------------------------------------------------------------
		if operatorString == "+" || operatorString == "-"{
			if i-1 > 0 {
				if NumberFormatter().number(from: calcul.mathExpression[i-1]) == nil  && tempString.contains(operatorString) == false{
					tempString += operatorString
				}
				else if calcul.stack[calcul.stack.count-1] == "+"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "-"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "*"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "/"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "("{
					
				}
			}
			else{
				if calcul.stack[calcul.stack.count-1] == "+"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "-"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "*"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "/"{
					self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
				}
				else if calcul.stack[calcul.stack.count-1] == "("{
					
				}
			}
			
		}
		//--------------------------------------------------------------
		//	*,/ 일 경우에 스택에 * 와 / 일 때 만 poplast()를 실행한다.
		//--------------------------------------------------------------
		else if operatorString == "*" || operatorString == "/"{
			if calcul.stack[calcul.stack.count-1] == "+"{
				
			}
			else if calcul.stack[calcul.stack.count-1] == "-"{
				
			}
			else if calcul.stack[calcul.stack.count-1] == "*"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
			}
			else if calcul.stack[calcul.stack.count-1] == "/"{
				self.calcul.postfixNotation.append(self.calcul.stack.popLast() ?? "\(Double.nan)")
			}
			else if calcul.stack[calcul.stack.count-1] == "("{
				
			}
		}
	}
	
	// MARK: 후위식 계산 함수
	//--------------------------------------------------------------
	//	후위식 계산 함수
	//--------------------------------------------------------------
	func postfixNotationCalcul() {
		
		for i in self.calcul.postfixNotation.indices {
			
			//	연산하는 두 값을 저장할 임시 배열
			var twoIntArray : [Double] = [Double](repeating: 0, count: 2)
			
			//	후위식의 크기보다 i 가 커질 경우에는 오류처리한다.
			if i > calcul.postfixNotation.count - 1 {
				self.calcul.postfixNotation = Array(arrayLiteral: "오류입니다.")
			}
			else {
				
				//--------------------------------------------------------------
				//	후위식에 숫자는 일단 스택에 넣어둔다.
				//	스택에 있는 두 숫자를 임시 배열에 넣어둔다
				//	i 가 증가하면서 만나는 연산자에 따라 임시배열에 두 숫자를 연산한다.
				//	연산된 숫자는 다시 스택에 넣어 마지막 하나의 값이 남을때 까지 진행한다.
				//--------------------------------------------------------------
				
				if NumberFormatter().number(from:calcul.postfixNotation[i]) != nil {
					self.calcul.stack.append(calcul.postfixNotation[i])
				}
				else if calcul.postfixNotation[i] == "+"{
					
					twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					
					self.calcul.stack.append(String(twoIntArray[0]+twoIntArray[1]))
					
				}
				else if calcul.postfixNotation[i] == "-"{
					
					twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					
					self.calcul.stack.append(String(twoIntArray[0]-twoIntArray[1]))
					
				}
				else if calcul.postfixNotation[i] == "*"{
					
					twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					
					self.calcul.stack.append(String(twoIntArray[0]*twoIntArray[1]))
					
				}
				else if calcul.postfixNotation[i] == "/"{
					
					twoIntArray[1]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					twoIntArray[0]	= Double(self.calcul.stack.popLast() ?? "0") ?? Double.nan
					
					self.calcul.stack.append(String(twoIntArray[0]/twoIntArray[1]))
					
				}
				// i 가 마지막에 도달 했을 때 결과에 스택에 있는 마지막 숫자를 넣어준다.
				if i == self.calcul.postfixNotation.count-1 {
					calcul.result = Double(calcul.stack.popLast() ?? "") ?? Double.nan
				}
			}
		}
	}
}
