//
//  PersnalDataView.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/27.
//

import SwiftUI

struct PersnalDataView: View {
    
    
    //--------View가 변화하면서 다룰 변수들--------//
    let contents : [String] = ["이름", "나이", "키", "몸무게"]
    // * selecsequance의 viewmodel데이터를 끌어다 쓰기위함.
    @StateObject var persnaldatavm = PersnalDataViewModel()
    // * 프레젠테이션모드는 sheet에서의 활동 제어
    @Environment(\.presentationMode) var presentationmode
    // * CoreData 접근하기위한 것
    @FetchRequest(entity: PersnalData.entity(), sortDescriptors: []) var persnalcoredata : FetchedResults<PersnalData>
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        /*--------
         지오메트리리더로 기기에 따른 화면값은
         지오메트리리더만영향을 받고 지오메트리리더
         안에 있는 요소는 지오의 영향을 받음
         --------*/
        GeometryReader{ geo in
            // * 수직 뷰로 구성
            VStack{
                /*
                 개인정보 헤드라인 수평 뷰구성
                 geo.size.height * 0.07 에 맞춰서
                 자동으로 폰트나 이미지가 변화함
                */
                HStack{
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    Text("개인정보")
                        .font(Font.custom("JalnanOTF", size: 100))
                        .minimumScaleFactor(0.001)
                }
                .frame(width: geo.size.width, height: DefaultUserData().userdeviceheight * 0.07, alignment: .leading)
                .padding(.vertical, 10.0)
                
                ZStack{
                    VStack{
                        ForEach(contents,id : \.self){ content in
                            HStack{
                                switch content {
                                case "이름" :
                                    Text("\(content)")
                                    TextField("ex) name", text: self.persnaldatavm.namebinding,onEditingChanged: { Bool in
                                        if Bool {
                                            self.persnaldatavm.namepushbool = true
                                        }
                                        else {
                                            self.persnaldatavm.namepushbool = false
                                        }
                                    })
                                        .multilineTextAlignment(.center)
                                case "나이" :
                                    Text("\(content)")
                                    TextField("ex) age", text: self.persnaldatavm.agebinding,onEditingChanged: { Bool in
                                        // * 클릭 했을 때
                                        if Bool {
                                            self.persnaldatavm.agepushbool = true
                                        }
                                        else {
                                            self.persnaldatavm.agepushbool = false
                                            print(self.persnaldatavm.persnaldata.age)
                                        }
                                    })
                                        .multilineTextAlignment(.center)
                                case "키" :
                                    Text("\(content)")
                                    TextField("ex) height", text: self.persnaldatavm.heightbinding,onEditingChanged: { Bool in
                                        // * 클릭 했을 때
                                        if Bool {
                                            self.persnaldatavm.heightpushbool = true
                                        }
                                        else {
                                            self.persnaldatavm.heightpushbool = false
                                        }
                                    })
                                        .multilineTextAlignment(.center)
                                case "몸무게" :
                                    Text("\(content)")
                                    TextField("ex) weight", text: self.persnaldatavm.weightbinding,onEditingChanged: { Bool in
                                        // * 클릭 했을 때
                                        if Bool {
                                            self.persnaldatavm.weightpushbool = true
                                        }
                                        else {
                                            self.persnaldatavm.weightpushbool = false
                                        }
                                    })
                                        .multilineTextAlignment(.center)
                                default:
                                    Text("Nothing")
                                }
                                
                            }
                            .padding()
                        }
                    }
                }
                
                Button {
                        // * 빈 배열일 때
                        if self.persnalcoredata.isEmpty {
                            PersnalData(context: viewContext).name = persnaldatavm.persnaldata.name
                            PersnalData(context: viewContext).age = Int16(persnaldatavm.persnaldata.age)
                            PersnalData(context: viewContext).height = persnaldatavm.persnaldata.heigth
                            PersnalData(context: viewContext).weight = persnaldatavm.persnaldata.weight
                            
                        }
                        // * 빈 배열이 아닐때
                        else {
                            self.persnalcoredata[0].name = persnaldatavm.persnaldata.name
                            self.persnalcoredata[0].age = Int16(persnaldatavm.persnaldata.age)
                            self.persnalcoredata[0].height = persnaldatavm.persnaldata.heigth
                            self.persnalcoredata[0].weight = persnaldatavm.persnaldata.weight
                        }
                        // * 저장하는 기능
                        do{
                            try viewContext.save()
                        }
                        catch{}
                        presentationmode.wrappedValue.dismiss()
                    
                    }
                    label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(self.persnaldatavm.buttonable() ? Color.gray : Color.blue)
                                .shadow(radius: 10)
                            Text("완료")
                                .padding()
                                .font(Font.custom("NotoSansKR-Black", size: 100))
                                .foregroundColor(Color.white)
                                .minimumScaleFactor(0.001)
                        }
                        .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.1)
                    }
                    .disabled(self.persnaldatavm.buttonable())
                    .padding(5)

                }
            
        }
        .onAppear {
            if self.persnalcoredata.isEmpty {
                PersnalData(context: viewContext).name = ""
                PersnalData(context: viewContext).age = 0
                PersnalData(context: viewContext).height = 0
                PersnalData(context: viewContext).weight = 0
            }
            // * 빈 배열이 아닐때
            else {
                 persnaldatavm.persnaldata.name = self.persnalcoredata[0].name
                persnaldatavm.persnaldata.age = Int(self.persnalcoredata[0].age)
                persnaldatavm.persnaldata.heigth = self.persnalcoredata[0].height
                persnaldatavm.persnaldata.weight = self.persnalcoredata[0].weight
            }
        }
    }
}


struct PersnalDataView_Previews: PreviewProvider {
    static var previews: some View {
        PersnalDataView()
    }
}
