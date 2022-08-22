//
//  PersnalDataView2.swift
//  HealthCalendar
//
//  Created by KimWooJin on 2021/11/30.
//

import SwiftUI

struct PersnalDataView2: View {
	@State var a = ""
	@State var b = ""
    var body: some View {
		//=================================================================
		// 네비게이션 뷰로 작성.
		//=================================================================
		NavigationView{
			VStack{
				Text("이름과 성별을 입력해주세요.")
				HStack{
					TextField("이름",text:$a)
					Spacer()
					Picker("",selection: $b){
						Text("남자")
						Text("여자")
					}
					.pickerStyle(SegmentedPickerStyle())
				}
			}
			.navigationBarHidden(true)
			
		}
    }
}

struct PersnalDataView2_Previews: PreviewProvider {
    static var previews: some View {
        PersnalDataView2()
    }
}
