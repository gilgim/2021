//
//  OrderSheet.swift
//  CoreDataPreprare
//
//  Created by KimWooJin on 2021/10/25.
//

import SwiftUI

struct OrderSheet: View {
       
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State var selectedPizzaIndex = 1
    @State var numberOfSlices = 1
    @State var tableNumber = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pizza Details")) {
                    Picker(selection: $selectedPizzaIndex, label: Text("Pizza Type")) {
                        ForEach(0 ..< pizzaTypes.count) {
                                Text(self.pizzaTypes[$0]).tag($0)
                        }
                    }
                    
                    Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
                }
                
                Section(header: Text("Table")) {
                    TextField("Table Number", text: $tableNumber)
                        .keyboardType(.numberPad)
                    
                }
                
                Button(action: {
                    guard self.tableNumber != "" else{return}
                    let newOrder = Order(context: viewContext)
                    newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                    newOrder.orderStatus = .pending
                    newOrder.tableNumber = self.tableNumber
                    newOrder.nuberOfSlice = Int16(self.numberOfSlices)
                    newOrder.id = UUID()
                    
                    //저장하는 부분
                    do{
                        try viewContext.save()
                        presentationMode.wrappedValue.dismiss()
                        print("Order saved.")
                    }catch{
                        print("error")
                    }
                    
                }) {
                    Text("Add Order")
                }
            }
                .navigationTitle("Add Order")
        }
    }
}

struct OrderSheet_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheet()
    }
}
