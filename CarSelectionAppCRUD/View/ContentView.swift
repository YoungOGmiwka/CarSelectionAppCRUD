//
//  ContentView.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import SwiftUI
import URLImage

struct ContentView: View {
    
    @StateObject var viewModel = CarsViewModel()
    @State var presentAddCarSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.cars) { car in
                    NavigationLink {
                        DetailCarView(car: car)
                    } label: {
                        CarRowView(car: car)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Машины")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
            .onAppear {
                print("CarListView appears. Subscribind to data updates")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddCarSheet) {
                UpdateInfoCarView()
            }
        }
    }
    
    private var addButton: some View {
        Button {
            self.presentAddCarSheet.toggle()
        } label: {
            Image(systemName: "plus.app")
        }

    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
