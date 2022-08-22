//
//  FLOView.swift
//  FLOProject
//
//  Created by KimWooJin on 2022/01/04.
//

import SwiftUI

struct FLOView: View {
	//==================================================================
	//	<고정 값>
	let userDeviceWidth = UIScreen.main.bounds.width
	let userDeviceHeight = UIScreen.main.bounds.width
	//==================================================================
	//==================================================================
	//	<JSON>
		@StateObject var jsonSong = json_Song(song: songData)
	//	<ViewModel>
	
	
	//==================================================================
    var body: some View {
		VStack{
			Spacer()
			Text("\(jsonSong.userSong.title)")
			Text("\(jsonSong.userSong.singer)")
			Albumimage(withURL: jsonSong.userSong.image)
			Text("가사")
			Text("\(jsonSong.userSong.duration)")
			Text("재생버튼")
		}
    }
}

struct FLOView_Previews: PreviewProvider {
    static var previews: some View {
        FLOView()
    }
}
