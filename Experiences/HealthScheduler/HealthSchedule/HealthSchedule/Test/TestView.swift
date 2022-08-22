//
//  TestView.swift
//  HealthSchedule
//
//  Created by KimWooJin on 2021/10/29.
//

import SwiftUI

struct TestView: View {
    @State var someNumber = 123.0

        var body: some View {
            let someNumberProxy = Binding<String>(
                get: { String(format: "%.02f", Double(self.someNumber)) },
                set: {
                    if let value = NumberFormatter().number(from: $0) {
                        self.someNumber = value.doubleValue
                    }
                }
            )

            return VStack {
                TextField("Number", text: someNumberProxy)

                Text("number: \(someNumber)")
            }
          }
    }

//        VStack{VStack {
//            Text(myValue.textValue)
//            TextField("Type here", text: $myValue.textValue)
//        }
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//            TextField("Number",text: someNumverProxy)
//            TextField(
//                            "Username",
//                            text: $username,
//                            onEditingChanged: { (isBegin) in
//                                if isBegin {
//                                    print("Begins editing")
//                                } else {
//                                    print("Finishes editing")
//                                }
//                            },
//                            onCommit: {
//                                print("commit")
//                            }
//                        )
//
//        }


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct MyStruct {
    var a: Int
    var b: Int
    func fonttest(){
        for family: String in UIFont.familyNames {
                        print(family)
                        for names : String in UIFont.fontNames(forFamilyName: family){
                            print("=== \(names)")
                        }
                    }
    }
}
extension MyStruct {
    var textValue: String {
        get {
            return "\(a).\(b)"
        }
        set {
            let items = newValue.components(separatedBy: ".")
            guard items.count == 2, let a = Int(items[0]), let b = Int(items[1]) else {
                return
            }
            self.a = a
            self.b = b
        }
    }
}
