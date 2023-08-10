//
//  CarsViewModel.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import Foundation
import Combine
import FirebaseFirestore

class CarsViewModel: ObservableObject {
    @Published var cars = [Car]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
        unsubscribe()
    }
    
    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func subscribe() {
        if listenerRegistration == nil {
            listenerRegistration = db.collection("cars").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.cars = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Car.self)
                }
            }
        }
    }
    
    func removeCars(atOffsets indexSet: IndexSet) {
        let cars = indexSet.lazy.map { self.cars[$0] }
        cars.forEach { car in
            if let documentId = car.id {
                db.collection("cars").document(documentId).delete { error in
                    if let error = error {
                        print("Unable to remove document: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}
