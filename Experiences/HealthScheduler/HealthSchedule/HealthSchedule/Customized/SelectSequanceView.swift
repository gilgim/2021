//
//  SelectSequanceView.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/26.
//

import SwiftUI

struct SelectSequanceView: View {
    let userdevicewidth = UIScreen.main.bounds.width
    let userdeviceheight = UIScreen.main.bounds.height
    @State var showpersnaldata : Bool = false
    @State var showexerroutine : Bool = false
    @State var showrestday : Bool = false
    var body: some View {
        VStack(spacing : 20){
            
            Group{
                //신체입력을 위한 버튼설계 + 헬스경력정보도 여기에서 입력하기
                Button {
                    print("개인 정보 입력하기")
                    showpersnaldata = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(maxWidth: userdevicewidth * 0.7, maxHeight: userdeviceheight * 0.08)
                        Text("개인 정보 입력하기")
                            .foregroundColor(Color.black)
                    }
                }
                
                Image(systemName: "arrow.down")
            }
            
            Group{
                //헬스 경력에 따른 루틴추천를 해주고 루틴 선택을 버튼이벤트시 설정
                Button {
                    print("루틴 선택")
                    showexerroutine = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(maxWidth: userdevicewidth * 0.7, maxHeight: userdeviceheight * 0.08)
                        Text("루틴 선택하기")
                            .foregroundColor(Color.black)
                    }
                    
                }
                
                Image(systemName: "arrow.down")
            }
            
//            Group{
//                //휴식일 정보를 여기에서 따로 정하기
//                Button {
//                    print("휴식일 선택하기")
//                    showrestday = true
//                } label: {
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 15)
//                            .frame(maxWidth: userdevicewidth * 0.7, maxHeight: userdeviceheight * 0.08)
//                        Text("휴식일 선택하기")
//                            .foregroundColor(Color.black)
//                    }
//                }
//
//                Image(systemName: "arrow.down")
//
//
//            }
            
            Group{
                //부위당 운동 세부 부위 선택하기
                Button {
                    print("세부 운동 선택하기")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(maxWidth: userdevicewidth * 0.7, maxHeight: userdeviceheight * 0.08)
                        Text("세부 운동 선택하기")
                            .foregroundColor(Color.black)
                    }
                }
                Image(systemName: "arrow.down")
            }
            
            Group{
                //부위 당 세트 수 정하기
                Button {
                    print("세트 수 정하기")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(maxWidth: userdevicewidth * 0.7, maxHeight: userdeviceheight * 0.08)
                        Text("세트 수 정하기")
                            .foregroundColor(Color.black)
                    }
                }
                Image(systemName: "arrow.down")
            }
            
            Group{
                Button {
                    print("사용하기")
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .frame(maxWidth: userdevicewidth * 0.5, maxHeight: userdeviceheight * 0.08)
                        Text("사용하기 ")
                            .foregroundColor(Color.black)
                    }
                }
            }

        }
        .shadow(radius: 10)
        .fullScreenCover(isPresented: $showpersnaldata, content: {
            PersnalDataView()
        })
        .fullScreenCover(isPresented: $showexerroutine, content: {
            ExerRoutineView()
        })
        .fullScreenCover(isPresented: $showrestday, content: {
            RestDay()
        })
    }
}

struct SelectSequanceView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSequanceView()
    }
}
