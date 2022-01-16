//
//  (Custom)ERCView.swift
//  ExchangeRateCalculation
//
//  Created by KimWooJin on 2022/01/15.
//

import SwiftUI

struct Custom_ERCView: View {
	//	ViewModel을 객체화
	@StateObject var ercViewModel = ERCViewModel()
	//==================================================================
	//	<고정 값들> : 폰트나 Padding 과 같은 값들을 디바이스 마다 자동 적용시킴
	
	//	기기 세로값
	let userDeviceHeight = UIScreen.main.bounds.height
	
	//	기기 가로값
	let userDeviceWidth = UIScreen.main.bounds.width
	//==================================================================
	var body: some View {
		
		NavigationView{
			
			VStack(){
				
				Divider()
				
				//==================================================================
				//	1 번째 row HStack
				
				HStack(spacing:0){
					
					//==================================================================
					//	<오른쪽 송금국가(고정)>
					
					Text("송금국가")
						.padding(.leading,userDeviceWidth*0.05)
						.font(Font.system(size: userDeviceWidth*0.05, weight: .bold, design: .rounded))
					
					Text(" : \(ercViewModel.ercModel.source)")
					
					//==================================================================
					
					Spacer()
					
					//==================================================================
					//	<왼쪽 입력 뷰>
					
					Text("송금액 : ")
						.font(Font.system(size: userDeviceWidth*0.05, weight: .bold, design: .rounded))
					
					TextField("금액",text: ercViewModel.ercCostBinding)
								.font(Font.system(size: userDeviceWidth*0.04))
								.multilineTextAlignment(.trailing)
								.frame(width: userDeviceWidth*0.3, height: userDeviceWidth*0.07)
								.padding(.trailing,userDeviceWidth*0.05)
								.overlay(
									RoundedRectangle(cornerRadius: 10)
										.stroke()
										.padding(.trailing,userDeviceWidth*0.028)
								)
								.keyboardType(.decimalPad)
					
								.toolbar{
									ToolbarItemGroup(placement: .keyboard) {
										Button("Done") {
											UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
										}
										Spacer()
									}
								}
					
								.accessibilityLabel("selectCountry")
								//.accessibilityLabel("costTextField")
	
				}
					.frame(maxWidth : userDeviceWidth, alignment: .leading)
				//===========================<1번째 줄 끝>============================
				
				Divider()
					
				//==================================================================
				//	2번째 줄
				
				Text("수취국가를 선택해주세요.")
					.font(Font.system(size: userDeviceWidth*0.05, weight: .bold, design: .rounded))
					.padding(.top,userDeviceWidth*0.03)
					.padding(.horizontal,userDeviceWidth*0.05)
					.frame(maxWidth : userDeviceWidth, alignment: .leading)
				
				
				HStack{
					
					Text("수취국가 : ")
						.padding(.horizontal,userDeviceWidth*0.03)
					
					//	수취국가 텍스트
					Picker("",selection: $ercViewModel.receiptString){
						ForEach(ercViewModel.receiptCountry,id:\.self){ i in
						 Text(i)
						}
					}
					.onChange(of: ercViewModel.receiptString, perform: { newValue in
						ercViewModel.Calc()
					})
					
					
					Spacer()
					
					Text("조회시간 : \(ercViewModel.ERCTimeStamp(timestamp: ercViewModel.ercModel.timestamp))")
						.font(Font.system(size: userDeviceWidth*0.025))
						.padding(.horizontal,userDeviceWidth*0.03)
					
				}
				.frame(maxWidth : userDeviceWidth)
				.overlay(RoundedRectangle(cornerRadius: 10).stroke().foregroundColor(.gray))
				.padding(.horizontal,userDeviceWidth*0.05)
				//===========================<2번째 줄 끝>==============================
				
				Divider()
				
				//==================================================================
				//	3번째 줄
				HStack(spacing:0){
					
					Text("선택한 국가의 환율은")
					
					Text(" \(ercViewModel.ERCDouble(country: ercViewModel.receiptString),specifier: "%.2f") ")
						.font(Font.system(size: userDeviceWidth*0.045, weight: .bold, design: .rounded))
					
					VStack{
						Text("\(ercViewModel.ERCChangeWord()) / USD ")
							.padding(.top,userDeviceWidth*0.01)
							.font(Font.system(size: userDeviceWidth*0.03))
					}
					
					Text("입니다.")
				}
					.padding(userDeviceWidth*0.025)
				//===========================<3번째 줄 끝>==============================
				
				Divider()
				
				//==================================================================
				//	4번째 줄
				HStack(spacing:0){
					
					Text("해당 금액의 수취금액은 ")
					
					Text("\(ercViewModel.ercCostSum,specifier: "%.2f")")
						.font(Font.system(size: userDeviceWidth*0.045, weight: .bold, design: .rounded))
					
					Text(" \(ercViewModel.ERCChangeWord())")
						.padding(.top,userDeviceWidth*0.01)
						.font(Font.system(size: userDeviceWidth*0.03))
					
					Text(" 입니다.")
				}
				.padding()
				//===========================<4번째 줄 끝>==============================
				
				Spacer()
			}
			.navigationTitle(Text("환율계산"))
			.frame(maxWidth : userDeviceWidth, alignment: .leading)
		}
	}
}

struct Custom_ERCView_Previews: PreviewProvider {
	static var previews: some View {
		Custom_ERCView()
		Custom_ERCView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
			.previewDisplayName("iPhone 8")
	}
}
