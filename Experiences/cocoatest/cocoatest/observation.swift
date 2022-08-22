//
//  observation.swift
//  cocoatest
//
//  Created by 김우진 on 2021/07/31.
//

import Foundation
import Combine

class ObservableArray<T>: ObservableObject {

  var cancellables = [AnyCancellable]()
  
  @Published var array:[T] = []
  
  init(array: [T])  {
    self.array = array
  }
  
  func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })
            

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
   }
}
