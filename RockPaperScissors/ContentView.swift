//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nam Vu Hai Nguyen on 2023-12-14.
//

import SwiftUI

struct ContentView: View {
    @State private var botMove: Int = Int.random(in: 0...2)
    @State private var promptMove: Int = Int.random(in: 0...3)
    @State private var score: Int = 0
    @State private var currentRound: Int = 0
    @State private var rounds: Int = 10
    @State private var endGame: Bool = false
    @State private var highestScore: Int = 0
    
    let moves: [String] = ["Rock", "Paper", "Scissors"]
    let prompts: [String] = ["Player Wins", "Player Loses", "Bot Wins", "Bot Loses"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.94, green: 0.78, blue: 0.25), location: 0.15),
                .init(color: Color(red: 0.93, green: 0.83, blue: 0.47), location: 0.15)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Round \(currentRound) of \(rounds)")
                    .font(.title2.weight(.medium))
                Spacer()
                Text("\(score)")
                    .font(.largeTitle.weight(.bold))
                Spacer()
                Spacer()
                Image(moves[botMove])
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                Text("\(prompts[promptMove])")
                    .font(.headline.weight(.medium))
                Spacer()
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            moveTapped(playerMove: number)
                        } label: {
                            Image(moves[number])
                                .resizable()
                                .scaledToFit() // Ensure the image fits within the button
                                .frame(minWidth: 0, maxWidth: 120) // Allow the image to take all available width
                        }
                    }
                }
                Spacer()
                Text("High Score: \(highestScore)")
                    .font(.title3.weight(.medium))
                Spacer()
                Spacer()
            }
            .alert("Result", isPresented: $endGame) {
                Button("Play again!", action: restart)
            } message: {
                if (score <= 3) {
                    Text("""
                You got \(score) out of \(rounds)
                Focus more next time!
                """)
                } else if (score >= 4 && score <= 7) {
                    Text("""
                You got \(score) out of \(rounds)
                Pretty good job!
                """)
                } else {
                    Text("""
                You got \(score) out of \(rounds)
                You are amazing!
                """)
                }
            }
        }
    }
    func moveTapped(playerMove: Int) {
        if (botMove == 0 && (promptMove == 0 || promptMove == 3)) {
            if (playerMove == 1) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        } else if (botMove == 0 && (promptMove == 1 || promptMove == 2)) {
            if (playerMove == 2) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        } else if (botMove == 1 && (promptMove == 0 || promptMove == 3)) {
            if (playerMove == 2) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        } else if (botMove == 1 && (promptMove == 1 || promptMove == 2)) {
            if (playerMove == 0) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        } else if (botMove == 2 && (promptMove == 0 || promptMove == 3)) {
            if (playerMove == 0) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        } else {
            if (playerMove == 1) {
                score += 1
            } else {
                score > 0 ? (score -= 1) : (score = 0)
            }
        }
        currentRound += 1
        currentRound == rounds ? endGame = true : randomize()
    }
    func randomize() {
        botMove = Int.random(in: 0...2)
        promptMove = Int.random(in: 0...3)
    }
    func restart() {
        if (score > highestScore) {
            highestScore = score
        }
        currentRound = 0
        score = 0
        randomize()
    }
}

#Preview {
    ContentView()
}
