//
//  CalculView.swift
//  Calculater
//
//  Created by KimWooJin on 2021/12/18.
//

import SwiftUI

struct CalculView: View {
	//========================================
	//	버튼 눌렀을 때 연결되있는 ViewModel
	@StateObject var calculVM = CalculViewModel()
	@State var resultBool = false
	//========================================
	//========================================
	//	고정 변수
	let deviceWidth = UIScreen.main.bounds.width
	let deviceHeight = UIScreen.main.bounds.height
	//========================================
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
	//========================================
	//	버튼 눌렀을 때 연결되있는 ViewModel
	@StateObject var calculVM : CalculViewModel
	//========================================
	//========================================
	//	고정 변수
	let deviceWidth = UIScreen.main.bounds.width
	let deviceHeight = UIScreen.main.bounds.height
	//========================================
	
	//========================================
	//	버튼 행에 있는 요소들
	let firstRow = ["AC","(",")","÷"]
	let secondRow = ["7","8","9","×"]
	let	thirdRow = ["4","5","6","-"]
	let	fourRow = ["1","2","3","+"]
	let	fiveRow = ["0",".","="]
	//========================================
	@Binding var resultBool : Bool
	var body: some View {
		VStack(spacing:(deviceWidth/4 - (deviceHeight * 0.48/5))){
			HStack(spacing:0){
				ForEach(firstRow.indices) { i in
					Button{
						if firstRow[i] == "AC"{
							calculVM.calcul.postfixNotation.removeAll()
							calculVM.calcul.mathExpression.removeAll()
							calculVM.calcul.stack.removeAll()
							calculVM.calcul.result = 0
						}
						else if firstRow[i] == "÷"{
							calculVM.calcul.mathExpression.append("/")
						}
						else{
							calculVM.calcul.mathExpression.append(firstRow[i])
						}
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .light_gray)
							.overlay(Text("\(firstRow[i])")
										.foregroundColor(i != 3 ? .black : .white))
					}
				}
			}
			HStack(spacing:0){
				ForEach(secondRow.indices) { i in
					Button{
						if secondRow[i] == "×"{
							calculVM.calcul.mathExpression.append("*")
						}
						else {
							calculVM.calcul.mathExpression.append(secondRow[i])
						}
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(secondRow[i])"))
					}
				}
			}
			HStack(spacing:0){
				ForEach(thirdRow.indices) { i in
					Button{
						calculVM.calcul.mathExpression.append(thirdRow[i])
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(thirdRow[i])"))
					}
				}
			}
			HStack(spacing:0){
				ForEach(fourRow.indices) { i in
					Button{
						calculVM.calcul.mathExpression.append(fourRow[i])
					}label:{
						Circle()
							.foregroundColor(i == 3 ? .orange : .gray)
							.overlay(Text("\(fourRow[i])"))
					}
				}
			}
			HStack(spacing:0){
				ForEach(fiveRow.indices) { i in
					if i == 0 {
						HStack{
							Button{
								calculVM.calcul.mathExpression.append(fiveRow[i])
							}label:{
								RoundedRectangle(cornerRadius: 100)
									.foregroundColor(i == 3 ? .orange : .gray)
									.frame(width: deviceWidth * 0.5-(deviceWidth/4 - (deviceHeight * 0.48/5))/2)
									.overlay(HStack{
										Text("\(fiveRow[i])")
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
								if fiveRow[i] != "="{
									calculVM.calcul.mathExpression.append(fiveRow[i])
								}
								else {
									resultBool = true
									self.calculVM.CalculFunc()
								}
							}label:{
								Circle()
									.foregroundColor(i == 2 ? .orange : .gray)
									.overlay(Text("\(fiveRow[i])"))
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
