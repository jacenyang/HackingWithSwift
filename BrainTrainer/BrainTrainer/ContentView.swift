//
//  ContentView.swift
//  BrainTrainer
//
//  Created by Jason Yang on 24/06/21.
//

import SwiftUI

struct ContentView: View {
    let rps = ["Rock", "Paper", "Scissors"]
    let colors = [Color.red, Color.green, Color.blue]
    let emojis = ["✊", "✋", "✌️"]
    
    @State var randomMove = Int.random(in: 0..<3)
    @State var shouldWin = Bool.random()
    
    @State var score = 0
    @State var round = 1
    @State var showAlert = false
    
    func check(_ move: Int) {
        if move - randomMove == 2 {
            print("Lose")
            if shouldWin == false {
                score += 1
            }
        } else if move - randomMove == 1 {
            print("Win")
            if shouldWin == true {
                score += 1
            }
        } else if move - randomMove == -2 {
            print("Win")
            if shouldWin == true {
                score += 1
            }
        } else if move - randomMove == -1 {
            print("Lose")
            if shouldWin == false {
                score += 1
            }
        }
        
        reset()
        
        if round == 10 {
            showAlert = true
        } else {
            round += 1
        }
    }
    
    func reset() {
        randomMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func playAgain() {
        score = 0
        round = 1
    }
    
    var body: some View {
        VStack {
            Spacer(minLength: 100)
            VStack {
                HStack {
                    VStack {
                        Text("Score")
                            .fontWeight(.semibold)
                            .padding()
                        Text("\(score)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    VStack {
                        Text("Round")
                            .fontWeight(.semibold)
                            .padding()
                        Text("\(round)/10")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                }
            }
            VStack {
                Text("Computer chose")
                    .fontWeight(.semibold)
                    .padding()
                Text(rps[randomMove])
                    .font(.title)
                    .fontWeight(.bold)
            }
            VStack {
                Text("You should")
                    .fontWeight(.semibold)
                    .padding()
                Text(shouldWin ? "Win" : "Lose")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer(minLength: 100)
            VStack {
                HStack {
                    Spacer(minLength: 25)
                    ForEach(0..<rps.count) { number in
                        Button {
                            check(number)
                        } label: {
                            ZStack {
                                colors[number]
                                    .cornerRadius(15)
                                Text("\(emojis[number])\n\(rps[number])")
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Spacer(minLength: 25)
                }
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            Spacer(minLength: 100)
        }
        .font(.title3)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Play Again")) {
                self.playAgain()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
