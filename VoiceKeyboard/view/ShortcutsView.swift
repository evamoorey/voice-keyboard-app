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
    @State var commands: [CommandInfo]
    @State private var sortOrder = [KeyPathComparator(\CommandInfo.command)]
    @State private var selection: CommandInfo.ID?
    
    init(service: CommandService) {
        self.commandService = service
        self.commands = commandService.getCommands()
    }
    
    var body: some View {
        VStack (alignment: .center) {
            Text("Сохраненные сочетания").font(Font.headline.weight(.bold)).padding(.top, 6).padding(.bottom, 10)
            Table(selection: $selection, sortOrder: $sortOrder) {
                TableColumn("Команда", value: \.command) { commandInfo in
                    VStack (alignment: .leading){
                        Text(commandInfo.command)
                        Text(commandInfo.shortcut).foregroundStyle(.secondary)
                    }
                }.width(255)
            }rows: {
                ForEach(commands, content: TableRow.init)
            }.onChange(of: sortOrder) { newOrder in
                commands.sort(using: newOrder)
            }.background(Color(hex: "EBEBF5").opacity(0.0))
                .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width: 308, height: 200)).frame(width: 290, height: 185, alignment: .top)
        }.frame(width: 333, height: 268, alignment: .top)
    }
}



//struct ShortcutsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShortcutsView(service: CommandService())
//    }
//}

