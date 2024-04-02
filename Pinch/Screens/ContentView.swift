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
    @State private var isDrawerOpen : Bool = false
    let pages: [Page] = pagesData
    @State private var pageIndex : Int = 1
    
    // MARK: FUNCTIONS
    func resetImageState(){
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String{
        return pages[pageIndex - 1 ].imageName
    }
    // MARK: CONTENT
    
    var body: some View {
        NavigationView{
            ZStack{
                //adding this so that z-stack covers full screen
                Color.clear
                // MARK: - PAGE IMAGE
                Image(currentPage())
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
                // MARK: -- MAGNIFICATION GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = value
                                    }else if imageScale > 5{
                                        resetImageState()
                                    }
                                }
                            }
                            .onEnded{_ in
                                if imageScale > 5 {
                                    imageScale = 5
                                }else if imageScale < 1 {
                                    resetImageState()
                                }                            }
                    )
                
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(){
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            }
            // MARK: INFO PANEL
            .overlay(
                InfoPanelView(scale: imageScale, offSet: imageOffset)
                    .padding(.horizontal)
                    .padding(.top , 30)
                , alignment: .top
            )
            //MARK: CONTROLS
            .overlay(
                Group{
                    HStack{
                        // SCALE DOWN
                        Button(action: {
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                    // safety precaution
                                    if imageScale <= 1{
                                        resetImageState()
                                    }
                                }
                            }
                        }, label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        })
                        
                        // RESET
                        Button(action: {
                            withAnimation(.spring()){
                                resetImageState()
                            }
                            resetImageState()
                        }, label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        })
                        
                        // SCALE UP
                        Button(action: {
                            withAnimation(.spring()){
                                if imageScale < 5{
                                    imageScale += 1
                                    // safety precaution
                                    if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                        }, label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                            
                        })
                        
                    }//: CONTROLS
                    .padding(.horizontal,20)
                    .padding(.vertical,12)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom,20)
                ,alignment: .bottom
            )
            // MARK: DRAWER
            .overlay(
                HStack(spacing: 12){
                    // MARK: DRAWER HANDLE
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut){
                                isDrawerOpen.toggle()
                            }
                        }
                    // MARK: DRAWER THUMBNAIL
                    ForEach(pages) { page in
                        Image(page.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(4)
                            .shadow(radius: 4)
                            .opacity(isDrawerOpen ? 1 : 0)
                            .animation(.easeOut(duration: 0.5), value : isDrawerOpen)
                            .onTapGesture {
                                isAnimating = true
                                pageIndex = page.id
                            }
                    }
                    
                    Spacer()
                }//: DRAWER
                    .padding(.vertical,16)
                    .padding(.horizontal,8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .offset(x: isDrawerOpen ? 20 : 215)
                    .padding(.top,UIScreen.main.bounds.height / 12)
                ,alignment :.topTrailing
            )
        }//: NAVIGATION
        .navigationViewStyle(.stack)
        
    }
}

#Preview {
    ContentView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
