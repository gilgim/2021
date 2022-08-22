//
//  AlbumimageViewModel.swift
//  FLOProject
//
//  Created by KimWooJin on 2022/01/04.
//

import Foundation
import Combine

// 이미지 구현
class ImageLoader: ObservableObject {
	var didChange = PassthroughSubject<Data, Never>()
	var data = Data() {
		didSet {
			didChange.send(data)
		}
	}

	init(urlString:String) {
		guard let url = URL(string: urlString) else { return }
		//	 HTTP 요청을 생성하는지, 다시 재개하고, 중단할수 있는 백그라운드 다운로드도 구현
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else { return }
			DispatchQueue.main.async {
				self.data = data
			}
		}
		task.resume()
	}
}
