//
//  ContentView.swift
//  FLOProject
//
//  Created by KimWooJin on 2022/01/03.
//

import SwiftUI

struct ContentView: View {
	@State var showSplash = false
    var body: some View {
		FLOView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
