//
//  TopBarView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 27.04.2025.
//

import SwiftUI

struct TopBarView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        HStack {
            Image("logo_mavedda_light")
                .resizable()
                .scaledToFit()
                .frame(height: 56)

            Spacer()
            
            HStack {
                Image("icon_search")
                    .foregroundColor(.black)
                
                TextField("Kalan kart taksitlerim...", text: $searchText)
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(11)
            
            Spacer()
            
            Image("profile_pic")
                .resizable()
                .frame(width: 44, height: 44)
                .cornerRadius(13)
        }
    }
}
