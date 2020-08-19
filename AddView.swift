//
//  AddView.swift
//  iExpenses
//
//  Created by Consultant on 7/4/20.
//  Copyright © 2020 Osulor Inc. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    static let types = ["Business","Personal"]
    @State private var showingError = false
    @Binding var isPresented: Bool

    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                
                TextField("Amount", text:  $amount)
                    .keyboardType(.numberPad)
            }
            .alert(isPresented: $showingError){
                Alert(title: Text("Invalid amount"), message: Text("Please enter a valid amount"), dismissButton: .default(Text("OK")))
            }
        .navigationBarTitle("Add new expense")
        .navigationBarItems(trailing:
            Button("Save"){
                if let actualAmount = Int(self.amount){
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                   // self.presentationMode.wrappedValue.dismiss()
                    self.isPresented = false
                    
                } else {
                    self.showingError = true
                    }
                }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses(), isPresented: .constant(false))
    }
}
