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
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        Text("commands")
    }
    
}

