//
//  ContentView.swift
//  Pinch
//
//  Created by Apptycoons on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: PROPERTIES
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    // MARK: FUNCTIONS
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    // MARK: CONTENT
    
    var body: some View {
        NavigationView{
            ZStack{
                // MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2) , radius: 12 , x: 2 , y :2)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(imageScale)
                    .offset(imageOffset)
                    .animation(.linear(duration: 1), value: isAnimating)
                // MARK: - DOUBLE TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else{
                           resetImageState()
                        }
                    })
                // MARK: - DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = value.translation
                                }
                            }
                            .onEnded { _ in
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
                
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            }
        }//: NAVIGATION
        .navigationViewStyle(.stack)
        
    }
}

#Preview {
    ContentView()
}
