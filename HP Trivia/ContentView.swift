import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var moveBackgroundImage = false
    @State private var scalePlayButton = false
    @State private var animateViewsIn = false
    @State private var showInstructions = false
    @State private var showSettings = false
    @State private var showGameplay = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: moveBackgroundImage ? geo.size.width / 1.1 : -geo.size.width / 1.1, y: 0)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            moveBackgroundImage.toggle()
                        }
                    }
                VStack {
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                Text("HP")
                                    .font(.custom(Constants.hpFont, size: 70))
                                    .padding(.bottom, -50)
                                Text("Trivia")
                                    .font(.custom(Constants.hpFont, size: 60))
                            }
                            .transition(.move(edge: .top))
                            .padding(.top, 70)
                        }
                    }
                    .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                    Spacer()
                    VStack {
                        if animateViewsIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                Text("33")
                                Text("27")
                                Text("15")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundStyle(.white)
                            .background(.black.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 15))
                            .transition(.opacity)
                        }
                    }
                    .animation(.linear(duration: 1).delay(4), value: animateViewsIn)
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showInstructions.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: -geo.size.width / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showGameplay.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(.brown)
                                        .clipShape(.rect(cornerRadius: 7))
                                        .shadow(radius: 5)
                                }
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.3).repeatForever()){
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height / 3))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2), value: animateViewsIn)
                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Button {
                                    showSettings.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(x: geo.size.width / 4))
                            }
                        }
                        .animation(.easeOut(duration: 0.7).delay(2.7), value: animateViewsIn)
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    Spacer()
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear {
            animateViewsIn = true
//            playAudio()
        }
        .sheet(isPresented: $showInstructions, content: {
            Instructions()
        })
        .sheet(isPresented: $showSettings) {
            Settings()
        }
        .fullScreenCover(isPresented: $showGameplay) {
            Gameplay()
        }
    }
    private func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
}
