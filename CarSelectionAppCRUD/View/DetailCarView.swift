//
//  EditCarView.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import SwiftUI
import URLImage

struct DetailCarView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State var editCarSheet = false
    
    var car: Car
    
    var body: some View {
        Form {
            Section(header: Text("Название машины")) {
                Text(car.brandName)
                Text(car.modelName)
            }
            
            Section(header: Text("Двигатель")) {
                Text(car.engineName)
            }
            
            Section(header: Text("КПП")) {
                Text(car.transmissionName)
            }
            
            Section(header: Text("Привод")) {
                Text(car.driveUnit)
            }
            
            Section(header: Text("Год выпуска")) {
                Text(car.year)
            }
            
            
            Section(header: Text("Цена")) {
                Text("\(car.price)")
            }
            
            Section(header: Text("Фотография")) {
                if let imgUrl = car.imageUrl,
                   let url = URL(string: imgUrl) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .frame(height: 240)
                            .clipped()
                    }
                }
            }
        }
        .navigationTitle("\(car.brandName) " + "\(car.modelName)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                editButton {
                    self.editCarSheet.toggle()
                }
            }
        }
        .sheet(isPresented: self.$editCarSheet) {
            UpdateInfoCarView(updateViewModel: UpdateInfoCarViewModel(car: car), mode: .edit) { result in
                if case .success(let action) = result, action == .delete {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text("Edit")
        }
    }
}

struct DetailCarView_Previews: PreviewProvider {
    static var previews: some View {
        let car = Car(brandName: "BMW",
                      modelName: "X5 M",
                      engineName: "40d 3.0d AT (340 л.с.)",
                      transmissionName: "Автомат",
                      year: "2022",
                      imageUrl: "https://www.allcarz.ru/wp-content/uploads/2022/04/foto-x7-2023_04.jpg",
                      price: 8900000,
                      driveUnit: "Полный")
        return
        NavigationView {
            DetailCarView(car: car)
        }
    }
}
