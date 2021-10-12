//
//  ContentView.swift
//  MapProject
//
//  Created by user on 12.10.2021.
//

import SwiftUI
import MapKit

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct LocationVC: View {
    @StateObject var locationViewModel = LocationViewModel()
 
    @State var selection = 0
    var body: some View {
           
        TabView(selection: $selection) {
            LocationView()
                        .tabItem {
                            Image(systemName: "location.fill")
                            Text("Location")
                        }
                        .tag(0)
                .environmentObject(locationViewModel)
            
            MapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
                .tag(1)
        }
    
    }
}

struct LocationView: View{
    @EnvironmentObject var locationViewModel: LocationViewModel
    var body: some View{
        ZStack{
            Color.init(#colorLiteral(red: 0, green: 0.8823529412, blue: 0.01960784314, alpha: 1)).edgesIgnoringSafeArea(.all)
        VStack {
            Text("Your\nlocation")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.custom("SilomBol", size: 56))
            Image("icons8-region")
            HStack {
                Text("Lon: ")
                    .foregroundColor(.white)
                    .font(.custom("SilomBol", size: 28))
                Spacer()
                Text("\(locationViewModel.longitude)")
                    .foregroundColor(.white)
                    .font(.custom("SilomBol", size: 28))
            }
            .padding(.horizontal)
            
            HStack {
                Text("Lat: ")
                    .foregroundColor(.white)
                Spacer()
                Text("\(locationViewModel.latitude)")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .font(.custom("SilomBol", size: 28))
            Spacer()
        }
        }
    }
}

struct MapView: View {
    @State var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.45, longitude: 37.36), latitudinalMeters: 10000, longitudinalMeters: 10000)
    var body: some View{
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LocationVC()
    }
}
