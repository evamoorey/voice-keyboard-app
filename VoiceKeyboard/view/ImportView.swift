//
//  ImportView.swift
//  VoiceKeyboard
//
//  Created by Ева Галюта on 24.03.2023.
//

import SwiftUI

struct ImportView: View {
    private let commandService: CommandService
    @State var fileName = "<none>"
    @State var showFileChooser = false
    @State private var showingAlert = false
    @State private var response: String = "OK"
    @State private var state: String = "Ошибка"
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Импорт").font(Font.headline.weight(.bold))
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                panel.canChooseFiles = true
                panel.allowedContentTypes = [.json]
                if panel.runModal() == .OK {
                    fileName = panel.url?.path() ?? "<none>"
                }
                if fileName == "<none>" {
                    state = "Ошибка"
                    response = "Файл не был выбран"
                    showingAlert = true
                } else {
                    response = commandService.importCommands(path: fileName)
                    if response != "OK" {
                        state = "Ошибка"
                        showingAlert = true
                    } else {
                        state = "Инфо"
                        response = "Команды импортированы успешно"
                    }
                }
            } label: {
                Text("Нажмите для выбора файла .json")
            }.alert(state, isPresented: $showingAlert) {
            } message: {
                Text(self.response)
            }.buttonStyle(PlainButtonStyle()).focusable(false).background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(hex: "EBEBF5").opacity(0.3), lineWidth: 0.5)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color(hex: "EBEBF5").opacity(0.25))).frame(width:200, height: 25, alignment: .leading)).frame(width:200, height: 25).padding(.top, 10)
        }.frame(width: 333, height: 288)
    }
}
