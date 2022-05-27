//
//  ContentView.swift
//  RockScizorsPaper
//
//  Created by Manoel Leal on 19/05/22.
//

import SwiftUI

struct MainImage: View {
    var option: String
    
    var body: some View{
        Image(option)
            .resizable()
            .frame(width: 150, height: 150)
    }
 
}

struct OptionImage: View{
    var option: String
    
    var body: some View {
        Image(option)
            .resizable()
            .frame(width: 75, height: 75)
    }
}

struct ContentView: View {
    
    let gameOptions = ["rock", "scissors", "paper"]
    
    @State private var myOption = Int.random(in: 0...2)
    @State private var pcOption = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingMessageMatch = false
    @State private var scoreTitle = ""
    @State private var gameCount = 0
    @State private var showingReset = false
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Your Score")
                        .font(.title)
                    Text(score, format: .number)
                        .font(.title2)
                }.padding()
                Spacer()
                HStack(alignment: .top){
                    
                    MainImage(option: gameOptions[myOption])
                        .padding()
                        
                    Spacer()
                    MainImage(option: gameOptions[pcOption])
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .padding()
                }
                Spacer()
                    Section{
                        HStack{
                            ForEach(0..<3){ number in
                                Button{
                                    match(number)
                                } label: {
                                    OptionImage(option: gameOptions[number])
                                        .padding(.horizontal)
                                }
                                
                            }
                        
            
                        }
                    } header: {
                        Text("Choose your option!")
                    }
        
            }
            .navigationTitle("Play the game!").navigationBarTitleDisplayMode(.inline)
            
        }.alert(scoreTitle, isPresented: $showingMessageMatch){
            Button{
                
            } label: {
                Text("OK")
            }
        } message: {
            Text("\(gameOptions[myOption].uppercased()) vs \(gameOptions[pcOption].uppercased())")
        }
        .alert("Finish", isPresented: $showingReset){
            Button("OK", action: resetScore)
        } message: {
            Text("Your final score is \(score)")
        }
    }
    
    func match(_ number: Int){
        gameCount += 1
        myOption = number
        pcOption = Int.random(in: 0...2)
        let myOptionValue = gameOptions[number]
        let pcOptionValue = gameOptions[pcOption]
        
        if myOptionValue == "rock" && pcOptionValue == "paper"{
            scoreTitle = "You lose this match"
            score -= 1
        } else if myOptionValue == "rock" && pcOptionValue == "scissors"{
            scoreTitle = "You win this match"
            score += 1
        } else if myOptionValue == "paper" && pcOptionValue == "rock"{
            scoreTitle = "You win this match"
            score += 1
        } else if myOptionValue == "paper" && pcOptionValue == "scissors"{
            scoreTitle = "You lose this match"
            score -= 1
        } else if myOptionValue == "scissors" && pcOptionValue == "paper"{
            scoreTitle = "You win this match"
            score += 1
        } else if myOptionValue == "scissors" && pcOptionValue == "rock"{
            scoreTitle = "You lose this match"
            score -= 1
        } else {
            scoreTitle = "Tied match"
            score = score
        }
        
        if gameCount == 10 {
            showingReset.toggle()
            gameCount = 0
        }
        
        if showingReset{
            showingMessageMatch = false
        } else {
            showingMessageMatch = true
        }
        
    }
    
    func resetScore(){
        score = 0
    }
    


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
