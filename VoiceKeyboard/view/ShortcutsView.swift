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
    @State var commands: [String: String]
    
    init(service: CommandService) {
        self.commandService = service
        self.commands = commandService.getCommands()
    }
    
    var body: some View {
        VStack (alignment: .center) {
            ForEach(commands.map{($0, $1)}, id: \.0) { command, shortcut in
                HStack (alignment: .center){
                    Text(shortcut).font(Font.headline.weight(.bold))
                    Text(command).font(Font.headline.weight(.bold))
                }
            }
        }
    }
    
}

//struct ShortcutsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShortcutsView(service: CommandService())
//    }
//}

