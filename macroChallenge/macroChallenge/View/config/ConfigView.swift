//
//  ConfigView.swift
//  macroChallenge
//
//  Created by rebeca primo on 12/06/23.
//

import SwiftUI

struct ConfigView: View {
    @Binding var viewState: ViewState
        @Environment(\.dismiss) private var dismiss

        var body: some View {
            ZStack {
                Image("fundoC")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Separator()
                    RectangleButton(title: "Privacidade", view: PoliticaView())
                    RectangleButton(title: "Termos de uso", view: TermosView())
                    Spacer()
                }
                .padding(.top, 100)
            }
            .navigationBarTitle("Informações")
            .font(.custom("SpecialElite-Regular", size: 20))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss.callAsFunction()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 19, weight: .heavy))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

