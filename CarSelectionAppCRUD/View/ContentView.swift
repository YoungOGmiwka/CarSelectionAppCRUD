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
    @State private var searchCar = ""
    @State private var selectedSortOption = SortOption.allCases.first!
    
    var filteredCars: [Car] {
        if searchCar.isEmpty {
            return viewModel.sortedCarPrice(on: selectedSortOption)
        }
        let filteredCars = viewModel.cars.compactMap { item in
            let brandNameQuery = item.brandName.range(of: searchCar, options: .caseInsensitive) != nil
            let modelNameQuery = item.modelName.range(of: searchCar, options: .caseInsensitive) != nil
            return (brandNameQuery || modelNameQuery) ? item : nil
        }
        return filteredCars
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(filteredCars) { car in
                    NavigationLink {
                        DetailCarView(car: car)
                    } label: {
                        CarRowView(car: car)
                            .foregroundColor(.black)
                    }
                }
            }
            .searchable(text: $searchCar)
            .overlay {
                if filteredCars.isEmpty {
                    ErrorView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .frame(width: 300, height: 300)
                }
            }
            .navigationTitle("Машины")
            .animation(.easeIn, value: filteredCars)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("", selection: $selectedSortOption.animation()) {
                            ForEach(SortOption.allCases, id: \.rawValue) { option in
                                Label(option.rawValue, systemImage: option.rawValue).tag(option)
                            }
                        }
                        .labelsHidden()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.square")
                    }
                }
                
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

enum SortOption: String, CaseIterable {
    case defaultSort = "По умолчанию"
    case lowestPrice = "По убыванию цены"
    case highestPrice = "По возрастанию цены"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
