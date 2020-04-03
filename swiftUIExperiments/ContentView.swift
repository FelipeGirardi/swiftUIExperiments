//
//  ContentView.swift
//  swiftUIExperiments
//
//  Created by Felipe Girardi on 02/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var soundData: Sounds
    @State private var searchText : String = ""
    @State var isPlaying : Bool = false
    @State var volumeLevel: Float = 0.5
    
    var body: some View {
        VStack {
            
            SearchBar(text: $searchText, placeholder: "")
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                 HStack {
                     ForEach((1...20), id: \.self) { _ in
                         Image(systemName: "bookmark")
                            .resizable()
                            .frame(height: 20)
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                     }
                 }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.isPlaying.toggle()
                    self.soundData.playAudio()

                }, label: {
                    Image(systemName: "play")
                })
                
                Spacer()
                
                Button(action: {
                    self.isPlaying.toggle()
                    self.soundData.pauseAudio()

                }, label: {
                    Image(systemName: "pause")
                })
                
                Spacer()
            }
            
            HStack {
                
                Text("Volume")
                    .padding()
                
                Slider(value: $soundData.sliderVolume)
                    .padding()
            }
            
        }
        .onAppear() {
            self.soundData.setAudioPlayer(soundfile: "Gruss vom Laettweiher.mp3")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
