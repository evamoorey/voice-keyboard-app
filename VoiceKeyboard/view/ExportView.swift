//
//  ExportView.swift
//  VoiceKeyboard
//
//  Created by Ева Галюта on 24.03.2023.
//

import SwiftUI

struct ExportView: View {
    private let commandService: CommandService
    @State var directoryName = "<none>"
    @State var showFileChooser = false
    @State private var showingAlert = false
    @State private var response: String = "OK"
    @State private var state: String = "Ошибка"
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Экспорт").font(Font.headline.weight(.bold))
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = true
                panel.canChooseFiles = false
                if panel.runModal() == .OK {
                    directoryName = panel.url?.path() ?? "<none>"
                }
                print(directoryName)
                if directoryName == "<none>" {
                    state = "Ошибка"
                    response = "Папка не была выбрана"
                    showingAlert = true
                } else {
                    response = commandService.exportCommands(path: directoryName + "commands.json")
                    if response != "OK" {
                        state = "Ошибка"
                        showingAlert = true
                    } else {
                        state = "Инфо"
                        response = "Команды экспортированы успешно в " + directoryName
                        showingAlert = true
                    }
                }
            } label: {
                Text("Нажмите для выбора папки")
            }.alert(state, isPresented: $showingAlert) {
            } message: {
                Text(response)
            }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:200, height: 25, alignment: .leading)).frame(width:200, height: 25).padding(.top, 10)
        }.frame(width: 333, height: 288)
    }
}
