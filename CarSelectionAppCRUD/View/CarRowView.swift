//
//  CarRowView.swift
//  CarSelectionAppCRUD
//
//  Created by Михаил
//

import SwiftUI
import URLImage

struct CarRowView: View {
    
    let car: Car
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 10) {
                Text(car.brandName)
                    .fontWeight(.medium)
                    .font(Font.custom("", size: 20))
                Text(car.modelName)
                    .fontWeight(.medium)
                    .font(Font.custom("", size: 20))
            }
            .padding(.top)
            .padding(.horizontal)
            
            HStack {
                Text("\(car.price) ₽")
                    .bold()
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                if let imgUrl = car.imageUrl,
                   let url = URL(string: imgUrl) {
                    URLImage(url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .frame(height: 240)
                            .clipped()
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(car.engineName)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.medium)
                            .font(Font.custom("", size: 16))
                            .foregroundColor(.black.opacity(0.65))
                        
                        Text(car.transmissionName)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.medium)
                            .font(Font.custom("", size: 16))
                            .foregroundColor(.black.opacity(0.65))
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Text(car.driveUnit)
                            .font(Font.custom("", size: 16))
                            .kerning(0.14)
                            .foregroundColor(.black.opacity(0.65))
                            .multilineTextAlignment(.leading)
                        
                        
                        Text("\(car.year)")
                            .font(Font.custom("", size: 16))
                            .kerning(0.14)
                            .foregroundColor(.black.opacity(0.65))
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.4), radius: 10)
        .padding(.all)
    }
}

struct CarRowView_Previews: PreviewProvider {
    static var previews: some View {
        CarRowView(car: Car.dummyData)
    }
}
