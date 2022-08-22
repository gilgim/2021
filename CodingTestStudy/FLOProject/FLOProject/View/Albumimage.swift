//
//  Albumimage.swift
//  FLOProject
//
//  Created by KimWooJin on 2022/01/04.
//

import Foundation
import SwiftUI

struct Albumimage : View {
	@StateObject var jsonSong = json_Song(song: songData)
	@ObservedObject var imageLoader : ImageLoader
	@State var image : UIImage = UIImage()
	
	init(withURL url:String) {
		imageLoader = ImageLoader(urlString:url)
	}
	
	var body: some View{
		Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width:100, height:100)
						.onReceive(imageLoader.didChange) { data in
						self.image = UIImage(data: data) ?? UIImage()
						}
	}
}
