//
//  InfiniteScrollView.swift
//  cocoatest
//
//  Created by 김우진 on 2021/07/31.
//

import SwiftUI
var abb : Int = 1
struct InfiniteScrollView: View {

    // an ObservedObject object which holds the array we populate our List with.마이리스트라는건 음 옵저버네
    @ObservedObject var myList = ObservableArray<Data>(array: [Data(value: "Infinite Scroll", id: abb)])
        
    //initialize ViewModel class which we will use to requests for data
    let viewModel = InfiniteScrollViewModel()

    init() {
        
        self.viewModel.viewUpdate = self
    }
    
    var body: some View {
        
        List (self.myList.array.enumerated().map({ $0 }), id: \.1.self.id) { (index,listItem) in
            Text(listItem.value).onAppear(perform: {
            
                let count = self.myList.array.count


                if index == count-1 {

                  self.viewModel.getNewItems(currentListSize: count)
                }
                
            })
            
        }
    }
}

extension InfiniteScrollView: ViewUpdateProtocol{
    func appendData(list: [Data]?) {
        self.myList.array.append(contentsOf: list!)
    }

}

protocol ViewUpdateProtocol{
    func appendData(list: [Data]?)
}

struct InfiniteScrollView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScrollView()
  }
  
}
