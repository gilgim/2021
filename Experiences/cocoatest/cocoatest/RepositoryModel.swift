//
//  RepositoryModel.swift
//  cocoatest
//
//  Created by 김우진 on 2021/07/30.
//

import Foundation
import RxSwift

protocol InfiniteScrollRepoProtocol {
    //behaviorSubject : 둘다댐
    func getDataArray() -> BehaviorSubject<[Data]>
    func fetchListItems(currentListSize : Int)
}

class InfiniteScrollRepository : InfiniteScrollRepoProtocol {
    
    private let listObservable = BehaviorSubject<[Data]>(value: [])
    
    func getDataArray() -> BehaviorSubject<[Data]>{
            return listObservable
    }
    //list 에다가 계속 추가해주는 작업임
    func fetchListItems(currentListSize: Int) {
        var dummyList : [Data] = []
        let limit = 20
        
        let page = currentListSize/limit + 1
        
        for index in 1...limit{
            dummyList.append(Data(value: "Page \(page) -> Item \(index)", id: index+currentListSize))
        }
        listObservable.onNext(dummyList)
    }
}
