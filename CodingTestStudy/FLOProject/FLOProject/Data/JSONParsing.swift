//
//  FLOViewModel.swift
//  FLOProject
//
//  Created by KimWooJin on 2022/01/04.
//

import Foundation
import UIKit
import SwiftUI

struct Song : Codable {
	var singer : String
	var album : String
	var title : String
	var duration : Int
	var image : String
	var file : String
	var lyrics : String
}

class json_Song : ObservableObject {
	@Published var userSong : Song
	init(song : Song){
		self.userSong = song
	}
}

var songData : Song = loadJson("song.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
	
	let data: Data
	// 웹 사이트 연결로 얻는 json은 url값이 필요하다.
	guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
		fatalError("\(filename) not found.")
	}
	
	do {
		data = try Data(contentsOf: file)
	} catch {
		fatalError("Could not load \(filename): (error)")
	}
	
	do {
		return try JSONDecoder().decode(T.self, from: data)
	} catch {
		fatalError("Unable to parse \(filename): (error)")
	}
}
