//
//  ExportView.swift
//  VoiceKeyboard
//
//  Created by Ева Галюта on 24.03.2023.
//

import SwiftUI

struct ExportView: View {
    private let commandService: CommandService
    
    init(service: CommandService) {
        self.commandService = service
    }
    
    var body: some View {
        Text("Export!")
    }
}

//struct ExportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExportView()
//    }
//}
