

import SwiftUI

struct Basic_ERCView: View {
	//	ViewModel을 객체화
	@StateObject var ercViewModel = ERCViewModel()
	
	//==================================================================
	//	<고정 값들>
	
	//	기기 세로값
	let userDeviceHeight = UIScreen.main.bounds.height
	
	//	기기 가로값
	let userDeviceWidth = UIScreen.main.bounds.width
	//==================================================================
	var body: some View {
			VStack{
				Spacer()
					.frame(width: userDeviceWidth, height: userDeviceHeight * 0.05)
				Text("환율계산")
					.font(Font.system(size: userDeviceHeight * 0.05))
				
				//	":"를 기준으로 HStack을 두 개의 VStack으로 나눈다. HStack은 왼쪽 정렬
				HStack{
					
					//==================================================================
					//	왼쪽 VStack 오른쪽 정렬
					VStack(alignment:.trailing,spacing: 10){
						Text("송금국가 :")
						Text("수취국가 :")
						Text("환율 :")
						Text("조회시간 :")
						Text("송금액 :")
					}
					//==================================================================
					
					
					//==================================================================
					//	오른쪽 VStack : 왼쪽 정렬
					VStack(alignment:.leading,spacing: 10){
						
						Text("미국(\(ercViewModel.ercModel.source))")
						
						Text(ercViewModel.receiptString)
							.onTapGesture {
								withAnimation {
									ercViewModel.showBool = true
								}
								//	키보드 숨기는 함수 실행
								UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
							}
							.accessibilityLabel("selectCountry")
							
						
						//	환율 나타내는 Text
						Text("\(ercViewModel.ERCDouble(country: ercViewModel.receiptString),specifier: "%.2f") \(ercViewModel.ERCChangeWord()) / USD")
						
						//	시간 텍스트
						Text("\(ercViewModel.ERCTimeStamp(timestamp: ercViewModel.ercModel.timestamp))")
						
						//	텍스트 필드의 열을 구성하기 위한 HStack
						HStack{
							
							//	사용자 금액 입력 텍스트필드
							TextField("금액",text: ercViewModel.ercCostBinding)
								.padding(.horizontal,4)
							
								//	검은 겉 테두리
								.overlay(Rectangle().stroke())
							
								//	텍스트 필드 왼쪽 정렬
								.multilineTextAlignment(.trailing)
								.frame(width: userDeviceWidth*0.28)
							
								//	키보드로 문자열의 입력을 막을 수 있고, 다른 방법은 블로그에 구현해놨다.
								.keyboardType(.decimalPad)
							
								//	키보드에 확인 버튼을 추가한다.
								.toolbar{
									ToolbarItemGroup(placement: .keyboard) {
										Button("Done") {
											UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
										}
										Spacer()
									}
								}
								.accessibilityLabel("costTextField")
								Text("USD")
								.fixedSize()
						}
					}
					//==================================================================
					
				}
				.padding()
				.font(Font.system(size: userDeviceWidth*0.04))
				.frame(width: userDeviceWidth,alignment: .leading)
				
				Spacer()
					.frame(width: userDeviceWidth, height: userDeviceHeight*0.05)
				Text("수취금액은 \(ercViewModel.ercCostSum,specifier: "%.2f") \(ercViewModel.ERCChangeWord()) 입니다.")
					.font(Font.system(size: userDeviceWidth*0.045))
				
				//	<Custom keyboard> : Picker 키보드를 재현해 준 뷰
				Spacer()
				PickerKeyBoard(ercViewModel: self.ercViewModel)
					.accessibility(identifier: "KeyboardPicker")
			}
		
			// 화면 전체를 클릭했을 시 커스텀 키보드가 사라진다.
			.onTapGesture {
				withAnimation {
					ercViewModel.showBool = false
				}
			}
	}
}

struct Basic_ERCView_Previews: PreviewProvider {
	static var previews: some View {
//        Basic_ERCView()
//			.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//			.previewDisplayName("iPhone 8")
		Basic_ERCView()
	}
}

struct PickerKeyBoard : View {
	//	ViewModel을 객체화
	@StateObject var ercViewModel : ERCViewModel
	
	//==================================================================
	//	<고정 값들>
	
	//	기기 세로값
	let userDeviceHeight = UIScreen.main.bounds.height
	
	//	기기 가로값
	let userDeviceWidth = UIScreen.main.bounds.width
	//==================================================================
	var body: some View{
		if ercViewModel.showBool {
			
			//	toolbar Button과의 간격은 0이다.
			VStack(spacing:0){
				
				//==================================================================
				//	키보드 완료 버튼
				
				Button{
					withAnimation {
						ercViewModel.showBool = false
					}
				}label: {
						Text("Done")
							.padding(userDeviceWidth * 0.03)
							.frame(width: userDeviceWidth, alignment: .leading)
							//	툴바 색
							.overlay(Color.gray.opacity(0.2))
				}
				//==================================================================
				
				//==================================================================
				//	Picker
				
				//	PickerView의 색
				Color.gray.opacity(0.4)
					.overlay(
						Picker("",selection: $ercViewModel.receiptString){
							ForEach(ercViewModel.receiptCountry,id:\.self){ i in
							 Text(i)
							}
						}
							//	receiptString가 바뀔 때마다 Calc를 실행하여 계산시켜준다.
							.onChange(of: ercViewModel.receiptString, perform: { newValue in
								ercViewModel.Calc()
							})
							.pickerStyle(.wheel)
							.accessibilityLabel("countryPicker")
					)
				//==================================================================
			}
			//	아래 키보드이기 때문에 SafeArea뷰까지 채워져야 한다.
			.ignoresSafeArea()
			.frame(width: userDeviceWidth, height: userDeviceHeight*0.33683)
			.transition(.move(edge: .bottom).animation(.easeInOut(duration: 0.001)))
		}
	}
}


