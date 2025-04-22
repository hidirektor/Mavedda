import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    let screenWidth = UIScreen.main.bounds.width
    let cardWidth: CGFloat

    init() {
        // Kart genişliklerini ekran genişliğine göre ayarla
        cardWidth = (screenWidth - 45) / 2 // İki kart ve aralarındaki boşluk için
    }

    var body: some View {
        VStack(spacing: 15) {
            // Üst Bölüm (Oranları Koruyarak)
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.title2)
                    .foregroundColor(Color(.label))
                    .frame(width: screenWidth * 0.08) // Oransal genişlik
                Spacer(minLength: screenWidth * 0.02) // Oransal boşluk

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.secondaryLabel))
                    TextField("Kalan kart taksitlerim...", text: $searchText)
                        .foregroundColor(Color(.secondaryLabel))
                }
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(width: screenWidth * 0.6) // Oransal genişlik

                Spacer(minLength: screenWidth * 0.02) // Oransal boşluk

                HStack(spacing: 2) {
                    Image(systemName: "cloud.fill")
                        .foregroundColor(Color(red: 0.45, green: 0.78, blue: 0.64))
                    Text("CO2")
                        .font(.caption)
                        .foregroundColor(Color(.label))
                }
                .frame(width: screenWidth * 0.1) // Oransal genişlik

                Spacer(minLength: screenWidth * 0.02) // Oransal boşluk

                Circle()
                    .frame(width: screenWidth * 0.08, height: screenWidth * 0.08) // Oransal boyut
                    .foregroundColor(Color(.systemGray4))
            }
            .padding(.horizontal)
            .frame(height: screenWidth * 0.12) // Oransal yükseklik

            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black)
                    .frame(height: screenWidth * 0.09) // Oransal yükseklik
                    .overlay(
                        HStack {
                            Text("32 dk.")
                                .foregroundColor(.white)
                                .padding(.leading)
                            Spacer()
                            Text("1 saat")
                                .foregroundColor(Color(red: 0.63, green: 0.45, blue: 0.85))
                            Spacer()
                            Text("4 gün")
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }
                    )
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .frame(height: screenWidth * 0.09) // Tekrar oransal yükseklik

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Button("Durum") {
                        print("Durum butonu tıklandı")
                    }
                    .buttonStyle(TabButtonStyle())

                    Button("Gelen") {
                        print("Gelen butonu tıklandı")
                    }
                    .buttonStyle(TabButtonStyle())

                    Button("Giden") {
                        print("Giden butonu tıklandı")
                    }
                    .buttonStyle(TabButtonStyle())

                    Button("Mavedda AI") {
                        print("Mavedda AI butonu tıklandı")
                    }
                    .buttonStyle(ActiveTabButtonStyle())
                }
                .padding(.horizontal)
                .frame(height: screenWidth * 0.1) // Oransal yükseklik
            }

            // Alt Bölüm (Kartlar - Sabit Genişlik ve Oransal Yükseklik)
            LazyVGrid(columns: [GridItem(.fixed(cardWidth)), GridItem(.fixed(cardWidth))], spacing: 15) {
                // Giden Kartı
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: cardWidth * 0.6) // Genişliğe göre oransal yükseklik
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "arrow.up.forward.square.fill")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.91, green: 0.30, blue: 0.24))
                                Text("Giden ₺")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                            }
                            Text("% 19,75")
                                .foregroundColor(Color(.secondaryLabel))
                            Text("₺ 7.898,99")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.label))
                            Text("Geçen haftaya göre")
                                .font(.caption)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .padding()
                        , alignment: .leading
                    )

                // Gelen Kartı
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: cardWidth * 0.6)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "arrow.down.backward.square.fill")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.34, green: 0.74, blue: 0.54))
                                Text("Gelen")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                            }
                            Text("%100.00")
                                .foregroundColor(Color(.secondaryLabel))
                            Text("₺ 40.000,00")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.label))
                            Spacer()
                        }
                        .padding()
                        , alignment: .leading
                    )

                // Bakiyem Kartı
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: cardWidth * 0.6)
                    .overlay(
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "waveform.path.ecg.rectangle.fill")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.22, green: 0.47, blue: 0.98))
                                Text("Bakiyem")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                            }
                            Text("₺ 32.101,01")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.label))
                            Text("Günlük Harcama Limiti \(Text("1.106,93").bold()) ₺")
                                .font(.caption)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                        .padding()
                        , alignment: .leading
                    )

                // Kredi Kartı ve Mal Varlığım Kartı (Tek Sütunda Birleşmiş)
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.secondarySystemBackground))
                    .frame(height: cardWidth * 0.6)
                    .overlay(
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.75, green: 0.62, blue: 0.89))
                                Text("Kredi Kart Bo")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "infinity")
                                    .font(.title3)
                                    .foregroundColor(Color(red: 0.30, green: 0.69, blue: 0.31))
                                Text("Mal Varlığım")
                                    .font(.headline)
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            Spacer()
                        }
                        .padding()
                        , alignment: .leading
                    )
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .background(Color(.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Özel Buton Stilleri (Aynı Kalıyor)
struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(configuration.isPressed ? Color(.systemGray4) : Color(.systemGray5))
            .foregroundColor(Color(.label))
            .cornerRadius(8)
    }
}

struct ActiveTabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(red: 0.85, green: 0.93, blue: 0.87))
            .foregroundColor(Color(red: 0.18, green: 0.36, blue: 0.21))
            .cornerRadius(8)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
