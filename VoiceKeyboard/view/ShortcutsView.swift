//
//  MainView.swift
//  voice-keyboard
//
//  Created by Ева Галюта on 12.03.2023.
//

import SwiftUI
import GRPC
import NIO
import AVFoundation

struct ShortcutsView: View {
    private let commandService: CommandService
    @State private var commands: [CommandInfo]
    @State private var selection: CommandInfo.ID?
    @State private var response: String = "OK"
    @State private var showingAlert = false
    
    
    init(service: CommandService) {
        self.commandService = service
        self.commands = commandService.getCommands()
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Сохраненные сочетания").font(Font.headline.weight(.bold)).padding(.top, 6).padding(.bottom, 7)
            List (commands, id: \.id, selection: $selection) { commandInfo in
                VStack (alignment: .leading){
                    Text(commandInfo.command)
                    Text(commandInfo.shortcut).foregroundStyle(.secondary)
                }.frame(width: 290, height: 35, alignment: .leading).listRowSeparator(.visible).listRowSeparatorTint(Color(hex: "EBEBF5").opacity(0.1))
            }.frame(width: 320, height: 155).padding(.leading, -15)
            Button {
                // Delete
                let idx = selection
                if idx != nil  {
                    let curCommand = commands.first{$0.id == idx}?.command
                    if curCommand != nil {
                        self.response = commandService.deleteCommand(command: curCommand!)
                    }
                }
                
                if self.response != "OK" {
                    self.showingAlert = true
                }
                self.commands = commandService.getCommands()
            } label: {
                Text("Удалить").font(Font.headline.weight(.bold))
            }.alert("Ошибка", isPresented: $showingAlert) {
            } message: {
                Text(self.response)
            }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:85, height: 25, alignment: .leading)).frame(width:80, height: 25).padding(.top, 7)
        }.frame(width: 333, height: 268, alignment: .top).onAppear {
            self.commands = commandService.getCommands()
        }
    }
}
