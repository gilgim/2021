//
//  ExerRoutineView.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/27.
//

import SwiftUI

struct ExerRoutineView: View {
    @Environment(\.presentationMode) var presentationmode
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var exerroutinevm = ExerRoutineViewModel()
    var body: some View {
        // * subscript로 무한 뷰 구현해보기
        GeometryReader{ geo in
            VStack{
                HStack(spacing : 40){
                    ForEach(1..<7){ i in
                        VStack{
                            Color.blue
                        }
                        .frame(width: self.exerroutinevm.defaultuserdata.userdevicewidth * 0.8, height: self.exerroutinevm.defaultuserdata.userdeviceheight * 0.8)
                    }
                }
                .position(x: geo.size.width / 2, y: self.exerroutinevm.defaultuserdata.userdeviceheight/2)
            }
            Button {
                presentationmode.wrappedValue.dismiss()
            } label: {
                Text("완료")
            }
        }
    }
}

struct ExerRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        ExerRoutineView()
    }
}
