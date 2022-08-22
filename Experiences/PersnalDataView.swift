//
//  PersnalDataView.swift
//  HealthCalendar
//
//  Created by KimWooJin on 2021/11/18.
//

import SwiftUI
/**
///----------------------------------------------------------------------
/// <코어데이터>를 통해서 사용자 입력데이터 저장
/// 1.이름
/// 2.나이
/// 3.키
/// 4.몸무게
///----------------------------------------------------------------------
 */
struct PersnalDataView: View {
    // MARK: 프로퍼티 모음
    //=================================================================
    // <환경변수>
	let deviceWidth = UIScreen.main.bounds.width
	let deviceHeight = UIScreen.main.bounds.height
    // 팝업뷰 해제, 코어데이터에 접근하기위한 변수
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    //=================================================================
    
    //=================================================================
    // <CoreData>
    // CoreData 속에 데이터베이스를 불러오기
    @FetchRequest(entity: PersnalData.entity(), sortDescriptors: []) var pernalCoreData : FetchedResults<PersnalData>
    //=================================================================
    
    //=================================================================
    //  <View>에서 변화되는 변수
    @StateObject var persnalData = PersnalDataViewModel()
    let persnalDataContents : [String] = ["이름","성별","나이","키","몸무게"]          // ForEach를 위한 고정배열
    //=================================================================
    
    // MARK: Body 시작점
    var body: some View {
        VStack{
			//----------------------------------------------------------------------
			// 제목
			//----------------------------------------------------------------------
			ZStack{
				Colors().backgroundColor
				HStack{
					Image(systemName:"person.crop.circle")
						.resizable()
						.scaledToFit()
						.padding()
					Text("개인정보")
						.foregroundColor(.white)
						.font(Font.custom("BinggraeSamanco", size: deviceWidth * 0.2))
				}
				.frame(width: deviceWidth, height: deviceHeight * 0.1)
			}
			ZStack{
				//----------------------------------------------------------------------
				// persnalDataContents를 이용한 ForEach
				//----------------------------------------------------------------------
				VStack(spacing:-10){
					// MARK: 사용자 정보 받는 부분
					ForEach(persnalDataContents, id: \.self){ content in
						HStack{
							switch content{
								//=================================================================
								// 이름
								//=================================================================
								case "이름" :
								ZStack{
									//----------------------------------------------------------------------
									// 테두리 색
									//----------------------------------------------------------------------
									RoundedRectangle(cornerRadius: 15)
										.foregroundColor(.white)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
 									RoundedRectangle(cornerRadius: 15)
										.stroke(lineWidth: 5)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
									
									HStack{
										Spacer()
										Text("\(content)")
											.padding(30)
										Text(":")
										TextField("예) 홍길동", text: self.persnalData.nameBinding,onEditingChanged: { Bool in
											if Bool {                               // TextField 클릭시 Bool은 True가 된다.
												self.persnalData.namePush = true                                // TextField 클릭시 nameBinding의 보여주는 값을 변동시키기 위해서 namePush를 이용한다.
											}
											else {
												self.persnalData.namePush = false
											}
										})
										.keyboardType(.namePhonePad)
										.multilineTextAlignment(.center)
									}
									.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.085))				//GoyangIlsan_L 써도된다
								}
								case "성별":
								ZStack{
									//----------------------------------------------------------------------
									// 테두리 색
									//----------------------------------------------------------------------
									RoundedRectangle(cornerRadius: 15)
										.stroke(lineWidth: 5)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
									
									HStack{
										Spacer()
										Text("\(content)")
											.padding(30)
										Text(":")
										TextField("예) 홍길동", text: self.persnalData.nameBinding,onEditingChanged: { Bool in
											if Bool {                               // TextField 클릭시 Bool은 True가 된다.
												self.persnalData.namePush = true                                // TextField 클릭시 nameBinding의 보여주는 값을 변동시키기 위해서 namePush를 이용한다.
											}
											else {
												self.persnalData.namePush = false
											}
										})
										.keyboardType(.namePhonePad)
										.multilineTextAlignment(.center)
									}
									.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.085))				//GoyangIlsan_L 써도된다
								}
								//=================================================================
								// 나이
								//=================================================================
								case "나이" :
								ZStack{
									//----------------------------------------------------------------------
									// 테두리 색
									//----------------------------------------------------------------------
									RoundedRectangle(cornerRadius: 15)
										.stroke(lineWidth: 5)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
									
									HStack{
										Spacer()
										Text("\(content)")
											.padding(30)
										Text(":")
										TextField("예) 18살", text: self.persnalData.ageBinding,onEditingChanged: { Bool in
											if Bool {
												self.persnalData.agePush = true
											}
											else {
												self.persnalData.agePush = false
											}
										})
										.keyboardType(.numberPad)
										.multilineTextAlignment(.center)
									}
									.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.085))
								}
								//=================================================================
								// 키
								//=================================================================
								case "키" :
								ZStack{
									//----------------------------------------------------------------------
									// 테두리 색
									//----------------------------------------------------------------------
									RoundedRectangle(cornerRadius: 15)
										.stroke(lineWidth: 5)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
									HStack{
										Spacer()
										Text("\(content)")
											.padding(30)
										Text(":")
										TextField("예) 170cm", text: self.persnalData.heightBinding,onEditingChanged: { Bool in
											if Bool {
												self.persnalData.heightPush = true
											}
											else {
												self.persnalData.heightPush = false
											}
										})
										.keyboardType(.decimalPad)
										.multilineTextAlignment(.center)
									}
									.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.085))
								}
								//=================================================================
								// 몸무게
								//=================================================================
								case "몸무게":
								ZStack{//----------------------------------------------------------------------
									// 테두리 색
									//----------------------------------------------------------------------
									RoundedRectangle(cornerRadius: 15)
										.stroke(lineWidth: 5)
										.frame(width: deviceWidth * 0.95, height: deviceHeight * 0.08)
										.padding()
									HStack{
										Spacer()
										Text("\(content)")
											.padding(30)
										Text(":")
										TextField("예) 75kg", text: self.persnalData.weightBinding,onEditingChanged: { Bool in
											if Bool {
												self.persnalData.weightPush = true
											}
											else {
												self.persnalData.weightPush = false
											}
										})
										.keyboardType(.decimalPad)
										.multilineTextAlignment(.center)
									}
									.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.085))
								}
								default :
									Text("Nothing")
							}
						}
					}
				}
				.frame(width:deviceWidth, height: deviceHeight * 0.65)

			}
			//----------------------------------------------------------------------
            // <완료버튼>
            //----------------------------------------------------------------------
            Button {
                //----------------------------------------------------------------------
                // <입력 값을 코어데이터에 저장한다.>
                //----------------------------------------------------------------------
                
                if self.pernalCoreData.isEmpty {                               // persnalCoreData가 빈 배열이면 True값이 리턴된다.
                    PersnalData(context: viewContext).name = persnalData.persnalData.name
                    PersnalData(context: viewContext).age = persnalData.persnalData.age
                    PersnalData(context: viewContext).height = persnalData.persnalData.height
                    PersnalData(context: viewContext).weight = persnalData.persnalData.weight
                }
                
                else{                               // persnalCoreData가 빈 배열이 아닐 경우 False를 던진다.
                    self.pernalCoreData[0].name = persnalData.persnalData.name
                    self.pernalCoreData[0].age = persnalData.persnalData.age
                    self.pernalCoreData[0].height = persnalData.persnalData.height
                    self.pernalCoreData[0].weight = persnalData.persnalData.weight
                }

                do{
                    try viewContext.save()
                }
                catch{}
                presentationMode.wrappedValue.dismiss()                //팝업뷰 해제 -> 원래 뷰로 돌아가기
            }
			//=================================================================
			//  완료버튼
			//=================================================================
            label: {
                ZStack{
					Colors().backgroundColor
                    Text("완료")
                        .foregroundColor(.white)
						.font(Font.custom("GoyangIlsanR-Regular", size: deviceWidth * 0.1))
                }
            }
            //----------------------------------------------------------------------
        }
        // MARK: CoreData 나타날 때 실행되는 곳
        //=================================================================
        //  <CoreData>에 [0]가 없다면 만들어주고 있다면 [0]에 값을 대입
        //=================================================================
        .onAppear {
            //----------------------------------------------------------------------
            // <빈배열 일때>
            // 코어 데이터에 값을 넣어서 배열을 만든다.
            //----------------------------------------------------------------------
            if self.pernalCoreData.isEmpty {
                PersnalData(context: viewContext).name = ""
                PersnalData(context: viewContext).age = 0
                PersnalData(context: viewContext).height = 0
                PersnalData(context: viewContext).weight = 0
            }
            //----------------------------------------------------------------------
            // <빈 배열이 아닐때>
            // [0]번째 값을 넣어서 처음값을 다시 설정한다.
            //----------------------------------------------------------------------
            else {
				persnalData.persnalData.name = self.pernalCoreData[0].name
                persnalData.persnalData.age = self.pernalCoreData[0].age
                persnalData.persnalData.height = self.pernalCoreData[0].height
                persnalData.persnalData.weight = self.pernalCoreData[0].weight
            }
        }
    }
    // MARK: Body 끝점
}

struct PersnalDataView_Previews: PreviewProvider {
    static var previews: some View {
        PersnalDataView()
    }
}
