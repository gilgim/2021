//
//  CalculModel.swift
//  Calculater
//
//  Created by KimWooJin on 2021/12/18.
//

import Foundation
//==================================================================
//	<MVVM 디자인 패턴의 Model>
//	뷰에서 다룰 변수들을 Model에 넣어둔다.
//	포함요소 : {스택, 입력식, 후위식, 결과값}
//==================================================================
struct CalculModel {
	//--------------------------------------------------------------
	//	stack : 스택
	//	mathExpression : 사용자 입력식
	//	postfixNotation : 후위식
	//	result : 결과값
	//--------------------------------------------------------------
	var stack : [String]
	var mathExpression : [String]
	var postfixNotation : [String] 
	var result : Double
}
