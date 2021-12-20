//
//  CalculView.swift
//  Calculater
//
//  Created by KimWooJin on 2021/12/18.
//

import SwiftUI

struct CalculView: View {
	//================================================
	//	<버튼 눌렀을 때 연결되있는 ViewModel>
	@StateObject var calculVM = CalculViewModel()
	@State var resultBool = false
	//================================================
	//================================================
	//	<고정 변수>
	let deviceWidth = UIScreen.main.bounds.width
	let deviceHeight = UIScreen.main.bounds.height
	//================================================
    var body: some View {
		
		ZStack{
			
			Color.black
				.ignoresSafeArea()
			
			VStack{
				
				HStack{
					
					VStack(alignment:.leading){
						
						Text("입력식 : \(calculVM.calcul.mathExpression.joined(separator: ""))")
							.foregroundColor(.white)
							.font(.system(size: 20, weight: .bold, design: .default))
							.padding(.bottom,10)
						
						Text("후위식 : \(self.calculVM.calcul.postfixNotation.joined(separator: ""))")
							.foregroundColor(.white)
							.font(.system(size: 20, weight: .bold, design: .default))
						
					}
					.padding(30)
					
					Spacer()
					
				}
				
				if resultBool {
					
					//-----------------------------------------------------------------------
					//	결과 값이 세자리가 넘어가면 폰트를 줄여서 최대한 보여주려고 한다.
					//	소숫점 2자리까지가 표기한다.
					//-----------------------------------------------------------------------
					VStack(alignment:.trailing){
						
						Text("\(self.calculVM.calcul.result, specifier: "%.2f")")
							.foregroundColor(.white)
						
					}
					.font(.system(size: calculVM.calcul.result < 1000 ? 90 : 37 , weight: .bold, design: .default))
				}
				
				Spacer()
				
				ButtonView(calculVM: self.calculVM,resultBool: self.$resultBool)
					.padding(20)
				
			}
		}
    }
}

struct CalculView_Previews: PreviewProvider {
    static var previews: some View {
        CalculView()
    }
}
struct ButtonView : View {
	//================================================
	//	<버튼 눌렀을 때 연결되있는 ViewModel>
	@StateObject var calculVM : CalculViewModel
	//================================================
	//================================================
	//	<고정 변수>
	let deviceWidth = UIScreen.main.bounds.width
	let deviceHeight = UIScreen.main.bounds.height
	//================================================
	
	//================================================
	//	<버튼 행에 있는 요소들>
	let firstRow = ["AC","(",")","÷"]
	let secondRow = ["7","8","9","×"]
	let	thirdRow = ["4","5","6","-"]
	let	fourRow = ["1","2","3","+"]
	let	fiveRow = ["0",".","="]
	//================================================
	// <결과값 뷰를 보여주는 Bool>
	@Binding var resultBool : Bool
	//================================================
	var body: some View {
		
		VStack(spacing:(deviceWidth/4 - (deviceHeight * 0.48/5))){
			
			HStack(spacing:0){
				
				ForEach(self.firstRow.indices) { i in
					
					Button{
						if firstRow[i] == "AC"{
							self.calculVM.calcul.postfixNotation.removeAll()
							self.calculVM.calcul.mathExpression.removeAll()
							self.calculVM.calcul.stack.removeAll()
							self.resultBool = false
							self.calculVM.calcul.result = 0
						}
						else if firstRow[i] == "÷"{
							self.calculVM.calcul.mathExpression.append("/")
						}
						else{
							self.calculVM.calcul.mathExpression.append(firstRow[i])
						}
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .light_gray)
							.overlay(Text("\(self.firstRow[i])")
										.foregroundColor(i != 3 ? .black : .white))
					}
				}
				
			}
			
			HStack(spacing:0){
				
				ForEach(self.secondRow.indices) { i in
					
					Button{
						if self.secondRow[i] == "×"{
							self.calculVM.calcul.mathExpression.append("*")
						}
						else {
							self.calculVM.calcul.mathExpression.append(secondRow[i])
						}
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(self.secondRow[i])"))
					}
					
				}
				
			}
			
			HStack(spacing:0){
				
				ForEach(self.thirdRow.indices) { i in
					
					Button{
						self.calculVM.calcul.mathExpression.append(self.thirdRow[i])
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(self.thirdRow[i])"))
					}
					
				}
				
			}
			
			HStack(spacing:0){
				
				ForEach(self.fourRow.indices) { i in
					
					Button{
						self.calculVM.calcul.mathExpression.append(self.fourRow[i])
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(self.fourRow[i])"))
					}
					
				}
				
			}
			
			HStack(spacing:0){
				
				ForEach(self.fiveRow.indices) { i in
					
					if i == 0 {
						HStack{
							
							Button{
								self.calculVM.calcul.mathExpression.append(self.fiveRow[i])
							}label:{
								RoundedRectangle(cornerRadius: 100)
									.foregroundColor(i == 3 ? .orange : .gray)
									.frame(width: deviceWidth * 0.5-(deviceWidth/4 - (deviceHeight * 0.48/5))/2)
									.overlay(HStack{
										Text("\(self.fiveRow[i])")
											.padding()
										Spacer()
									})
							}
							
						}
						.frame(width : deviceWidth * 0.5)
						
					}
					
					else{
						
						HStack{
							
							Button{
								if self.fiveRow[i] != "="{
									self.calculVM.calcul.mathExpression.append(fiveRow[i])
								}
								else {
									self.resultBool = true
									self.calculVM.CalculFunc()
								}
							}label:{
								Circle()
									.foregroundColor(i == 2 ? .orange : .gray)
									.overlay(Text("\(self.fiveRow[i])"))
							}
							
						}
						.frame(width : deviceWidth * 0.25)
						
					}
				}
			}
		}
		.foregroundColor(.white)
		.font(.system(size: 40, weight: .bold, design: .default))
		.frame(width: deviceWidth, height: deviceHeight * 0.48 + ((deviceWidth/4 - (deviceHeight * 0.48/5))) * 5)
	}
}
