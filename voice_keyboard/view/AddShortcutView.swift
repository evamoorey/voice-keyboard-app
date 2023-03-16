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
    
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Добавить команду").font(Font.headline.weight(.bold))
            HStack (alignment: .top){
                VStack (alignment: .leading) {
                    Text("Сочетание клавиш").font(Font.headline.weight(.bold)).padding(.leading, -3)
                    TextField("Введите сочетание", text: $hotKey).textFieldStyle(PlainTextFieldStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5).background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.1))).frame(width:126, height: 30, alignment: .leading)).frame(width: 121, height: 30)
                        
                }.padding(.all, 20)
                
                VStack (alignment: .leading){
                    Text("Команда").font(Font.headline.weight(.bold)).padding(.leading, -3)
                    HStack {
                        TextField("Введите комманду", text: $command).textFieldStyle(PlainTextFieldStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5).background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.1))).frame(width:126, height: 30, alignment: .leading)).frame(width: 121, height: 30)
                        Button {
                            // Add textfield
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 17.0, height: 17.0)
                        }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:33, height: 30, alignment: .leading)).padding(.leading, 10)
                    }
                    
                    Button {
                        // Save
                        self.response = commandService.addCommand(command: self.command, hotKey: self.hotKey)
                        if self.response != "OK" {
                            self.showingAlert = true
                        }
                    } label: {
                        Text("Добавить").font(Font.headline.weight(.bold))
                    }.alert("Ошибка", isPresented: $showingAlert) {
                    } message: {
                        Text(self.response)
                    }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:85, height: 25, alignment: .leading)).frame(width:80, height: 25).padding(.leading, 82)
                }.padding(.all,20).padding(.leading, -37)
            }.padding(.top, 10)
        }
    }
}

//struct AddShortcutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddShortcutView(service: CommandService())
//    }
//}

