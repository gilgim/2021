//
//  ContentView.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/10/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showOrderSheet = false
    //이게 있어서 저장할 수 있는거임
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Order.entity(), sortDescriptors: [], predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    private var items: FetchedResults<Order>

    var body: some View {
        List{
           Text("Sample Order")
        }
        .navigationTitle("My Order")
        .navigationBarItems(trailing: Button(action: {
                showOrderSheet = true
            }, label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }))
        .sheet(isPresented: $showOrderSheet) {
            OrderSheet()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    /*
     ContentView 구성 전에 preview에서 viewContext를 허용하는지를 확인해야함
     */
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
