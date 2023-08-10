//
//  UpdateInfoCarViewModel.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import Foundation
import Combine
import FirebaseFirestore

class UpdateInfoCarViewModel: ObservableObject {
    
    @Published var car: Car
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(car: Car = Car(brandName: "",
                        modelName: "",
                        engineName: "",
                        transmissionName: "",
                        year: "",
                        imageUrl: "",
                        price: 0,
                        driveUnit: "")) {
        
        self.car = car
        
        self.$car
            .dropFirst()
            .sink { [weak self] car in
                self?.modified = true
            }
            .store(in: &self.cancellables)
    }
    
    private var db = Firestore.firestore()
    
    private func addCar(_ car: Car) {
        do {
            let _ = try db.collection("cars").addDocument(from: car)
        }
        catch {
            print(error)
        }
    }
    
    private func updateCar(_ car: Car) {
        if let documentId = car.id {
            do {
                try db.collection("cars").document(documentId).setData(from: car)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func removeCarFromDB() {
        if let documentId = car.id {
            db.collection("cars").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateOrAddCar() {
        if let _ = car.id {
            self.updateCar(self.car)
        } else {
            addCar(car)
        }
    }
    
    func saveCar() {
        self.updateOrAddCar()
    }
    
    func deleteCar() {
        self.removeCarFromDB()
    }
}
