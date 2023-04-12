//
//  AddShortcutMenu.swift
//  voice-keyboard
//
//  Created by Ева Галюта on 12.03.2023.
//

import SwiftUI
import UserNotifications


struct AddShortcutView: View {
    private let commandService: CommandService
    @State private var hotKey: String = ""
    @State private var command: String = ""
    @State private var showingAlert = false
    @State private var response: String = "OK"
    @State private var state: String = "Ошибка"
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Добавить команду").font(Font.headline.weight(.bold)).padding(.top, 10)
            HStack (alignment: .top){
                VStack (alignment: .leading) {
                    Text("Сочетание клавиш").font(Font.headline.weight(.bold)).padding(.leading, -1)
                    TextField("Введите сочетание", text: $hotKey).textFieldStyle(PlainTextFieldStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5).background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.1))).frame(width:135, height: 30, alignment: .leading)).frame(width: 125, height: 30)
                }.padding(.all, 20).padding(.leading, 4)
                VStack (alignment: .leading){
                    Text("Команда").font(Font.headline.weight(.bold)).padding(.leading, -1)
                    HStack {
                        TextField("Введите комманду", text: $command).textFieldStyle(PlainTextFieldStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5).background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.1))).frame(width:135, height: 30, alignment: .leading)).frame(width: 125, height: 30)
                    }
                    Button {
                        // Save
                        
                        if command.count > 37 {
                            state = "Ошибка"
                            response = "Длинна команды более 37 символов"
                            showingAlert = true
                        } else if hotKey.count > 37 {
                            state = "Ошибка"
                            response = "Длинна сочетания более 37 символов"
                            showingAlert = true
                        } else {
                            response = commandService.addCommand(command: self.command, hotKey: self.hotKey)
                            if response != "OK" {
                                state = "Ошибка"
                                showingAlert = true
                            } else {
                                state = "Инфо"
                                response = "Команда добавлена"
                                showingAlert = true
                            }
                        }
                    } label: {
                        Text("Добавить").font(Font.headline.weight(.bold))
                    }.alert(state, isPresented: $showingAlert) {
                    } message: {
                        Text(self.response)
                    }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:85, height: 25, alignment: .leading)).frame(width:80, height: 25).padding(.leading, 47).padding(.top, 5)
                }.padding(.all,20).padding(.leading, -15)
            }.padding(.top, -10)
        }.frame(width: 333, height: 288)
    }
    
}
