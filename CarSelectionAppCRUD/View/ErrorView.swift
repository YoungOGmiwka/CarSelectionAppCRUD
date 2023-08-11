//
//  ErrorView.swift
//  AvtomobilkaApp
//
//  Created by Михаил
//

import SwiftUI

struct ErrorView: View {
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "exclamationmark.icloud.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 70, weight: .heavy))
                HStack {
                    Text("No Results")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .heavy))
                        .multilineTextAlignment(.center)
                }
                HStack {
                    Text("Check the spelling or try a new search.")
                        .foregroundColor(.black.opacity(0.65))
                        .font(.system(size: 14, weight: .medium))
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
