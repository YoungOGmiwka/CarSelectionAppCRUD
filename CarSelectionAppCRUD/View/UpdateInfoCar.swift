//
//  UpdateInfoCarView.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import SwiftUI

struct UpdateInfoCarView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var updateViewModel = UpdateInfoCarViewModel()
    @State var deleteAction = false
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    var saveButton: some View {
        Button {
            self.doneTapped()
        } label: {
            Text(mode == .new ? "Done" : "Save")
        }
        .disabled(!updateViewModel.modified)
    }
    
    var cancelButton: some View {
        Button {
            self.cancelTapped()
        } label: {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Марка", text: $updateViewModel.car.brandName)
                    TextField("Модель", text: $updateViewModel.car.modelName)
                } header: {
                    Text("Название машины")
                }
                
                Section {
                    TextField("Характеристики двигателя", text: $updateViewModel.car.engineName)
                } header: {
                    Text("Двигатель")
                }
                
                Section {
                    TextField("Механика/Автомат", text: $updateViewModel.car.transmissionName)
                } header: {
                    Text("КПП")
                }
                
                Section {
                    TextField("Полный/Задний/Передний", text: $updateViewModel.car.driveUnit)
                } header: {
                    Text("Привод")
                }
                
                Section {
                    TextField("Год", text: $updateViewModel.car.year)
                } header: {
                    Text("Год выпуска")
                }
                
                Section {
                    TextField("Цена", value: $updateViewModel.car.price, formatter: NumberFormatter())
                } header: {
                    Text("Цена машины")
                }
                
                Section {
                    TextField("Ссылка на фотографию машины", text: $updateViewModel.car.imageUrl)
                } header: {
                    Text("Фотография")
                }
                
                if mode == .edit {
                    Section {
                        Button {
                            self.deleteAction.toggle()
                        } label: {
                            Text("Удалить машину")
                                .foregroundColor(.red)
                        }

                    }
                }
            }
            .navigationTitle(mode == .new ? "Добавление машины" : updateViewModel.car.brandName)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .actionSheet(isPresented: $deleteAction) {
                ActionSheet(title: Text("Вы уверены?"),
                            buttons: [
                                .destructive(Text("Удалить машину"),
                                             action: {
                                                 self.deleteTapped()
                                             }),
                                .cancel()
                            ])
            }
        }
    }
    
    func doneTapped() {
        self.updateViewModel.saveCar()
        self.dismiss()
    }
    
    func deleteTapped() {
        updateViewModel.deleteCar()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func cancelTapped() {
        self.dismiss()
    }
}

enum Mode {
    case new
    case edit
}

enum Action {
    case done
    case delete
    case cancel
}

struct UpdateInfoCarView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateInfoCarView()
    }
}
