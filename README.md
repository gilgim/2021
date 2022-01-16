# KimWooJin_CodingTest

### 와이어바알리 코딩테스트

<br> 아이폰 마다 화면 크기가 다르기에 달라질 때마다 동일 비율을 적용해 깨짐이 없게 만들었습니다.<br>또한 제공된 과제를 그대로 구현한 뷰와 스스로 각색시킨 뷰도 올렸습니다. 

<img width="481" alt="스크린샷 2022-01-16 오후 8 19 06" src="https://user-images.githubusercontent.com/82685270/149660973-6c75fe99-86ea-48e7-b91e-1aa04d7a0ce4.png">
　　　　　　　　　　　　　　<아이폰12>
<img width="479" alt="스크린샷 2022-01-16 오후 8 35 51" src="https://user-images.githubusercontent.com/82685270/149660987-ea7cdc98-e910-4382-b726-a1602aa1e327.png">
　　　　　　　　　　　　　　<아이폰8><br>
<pre>
<code>
struct ContentView: View {
    var body: some View {
	//	예제 뷰 <----------- 기본 뷰
	Basic_ERCView()

	//	커스텀 뷰
	//Custom_ERCView()
    }
}
</code>
</pre>
<br><br><br>
해당 화면는 커스텀 뷰입니다.
<img width="481" alt="스크린샷 2022-01-16 오후 9 58 23" src="https://user-images.githubusercontent.com/82685270/149667353-293c1de9-4b8f-4037-99ff-7c67e9dcada3.png">
　　　　　　　　　　　　　　<Custom아이폰12>
<img width="479" alt="스크린샷 2022-01-16 오후 8 35 15" src="https://user-images.githubusercontent.com/82685270/149667360-4e0d0d3d-56e8-4356-8256-7fe7536e80f1.png">
　　　　　　　　　　　　　　<Custom 아이폰8><br>

<br>
UI 테스트는 알람과 환율이 즉각적으로 바뀌는지 환율이 바뀔 때 마다 송금액이 바뀌는지를 테스트합니다.
<pre>
<code>
func testExample() throws {
let app = XCUIApplication()

basicViewFuc(app: app) <--------------- 제공된 과제에 대한 UI테스트 입니다. 
//customViewFuc(app: app) <--------------- 커스텀 뷰에 대한 UI테스트 입니다. 
}
</code>
</pre>
