//
//  ContentView.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: PersnalData.entity(), sortDescriptors: []) var a :
    FetchedResults<PersnalData>
    var familys : [String] = UIFont.familyNames
    var intnt : Int16 {
      return  PersnalData(context: viewContext).age
    }
    
    var body: some View {
        VStack{
            SelectSequanceView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
