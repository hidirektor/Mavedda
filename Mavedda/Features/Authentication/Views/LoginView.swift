//
//  LoginView.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 22.04.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var phoneNumber: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Hesap Oluştur") // "Create Account"
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Text("Cep telefonu numaranla ya da mail adresinle hesap aç.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)
                
                TextField("Cep telefonu numaranı gir.", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color("background"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 11)
                            .stroke(Color("inputFieldStrokeColor"), lineWidth: 0.5)
                                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
                
                Text("Sana giriş kodu göndereceğiz")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 24)
                
            }
            .padding(.top, 80)
            .background(Color("background"))
            
            Spacer()
            
            VStack {
                Button(action: {
                    // Handle continue action
                }) {
                    Text("Devam Et")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("mainButtonColor"))
                    .cornerRadius(13)
                }
                .padding(.horizontal)
                
                Text("ya da")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.vertical, 10)
                
                HStack {
                    Button(action: {
                    }) {
                        Text("Telefon")
                            .font(.headline)
                            .foregroundColor(Color("background"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("activeColor"))
                            .cornerRadius(8)
                    }
                    .padding(.leading)
                    
                    Button(action: {
                        // Handle email login
                    }) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(Color("blackColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("inactiveButtonColor"))
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                EmptyView()
                    .frame(height: 20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
