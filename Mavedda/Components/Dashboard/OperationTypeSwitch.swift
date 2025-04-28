//
//  OperationTypeSwitch.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 28.04.2025.
//

import SwiftUI

struct OperationTypeSwitch: View {
    let width: CGFloat = 45
    let height: CGFloat = 105
    let cornerRadius: CGFloat = 17

    @State private var isPlusActive: Bool = false
    @State private var isMinusActive: Bool = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color("background_operation_type_selection"))
                .frame(width: width, height: height)

            if isPlusActive {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.black)
                    .frame(width: width, height: height * 0.65)
                    .offset(y: height * 0.25)
            }

            if isMinusActive {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.black)
                    .frame(width: width, height: height * 0.65)
                    .offset(y: -height * 0.25)
            }

            VStack {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isMinusActive.toggle()
                        isPlusActive = false
                    }
                } label: {
                    Image("icon_minus")
                        .resizable()
                        .renderingMode(.template)
                        .font(.title2)
                        .foregroundColor(isMinusActive ? .white : .black)
                        .frame(width: 24, height: 24)
                }
                .frame(height: height * 0.5)

                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isPlusActive.toggle()
                        isMinusActive = false
                    }
                } label: {
                    Image("icon_plus")
                        .resizable()
                        .renderingMode(.template)
                        .font(.title2)
                        .foregroundColor(isPlusActive ? .white : .black)
                        .frame(width: 24, height: 24)
                }
                .frame(height: height * 0.5)
            }
        }
        .frame(width: width, height: height)
    }
}

struct OperationTypeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        OperationTypeSwitch()
    }
}
