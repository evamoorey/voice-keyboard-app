//
//  voice_keyboardApp.swift
//  voice-keyboard
//
//  Created by Ева Галюта on 19.01.2023.
//

import Foundation
import SwiftUI
import GRPC
import NIO
import AVFoundation

@main
struct VoiceKeyboardApp: App {
    private let taskProcess: Process
    private var commandService: CommandService
    private let appControlService: AppControlService
    private let host = "localhost"
    private let port = 50033
    
    init() {
        self.taskProcess = Process()
        self.commandService = CommandService()
        self.appControlService = AppControlService()
        
        print("Init server")
        
        let commandsPath = Bundle.main.url(forResource: "commands",withExtension:"json")?.relativePath
        if let mainPath = Bundle.main.url(forResource: "server", withExtension: "")?.relativePath {
            try? safeShell(mainPath, conf: commandsPath ?? "", task: taskProcess)
            print("Process started on: " + taskProcess.description)
        }
        
        if !Connection().established(host: self.host, port: self.port) {
            print("Server doesn't response")
            NSApplication.shared.terminate(nil)
        } else {
            print("Connection set")
        }
    }
    
    var body: some Scene {
        MenuBarExtra("Voice keyboard", systemImage: "chevron.backward.to.line") {
            HomeView(process: taskProcess, service: commandService, appControl: appControlService)
        }.menuBarExtraStyle(.window)
    }
    
    func safeShell(_ command: String, conf: String, task: Process) throws {
        taskProcess.standardOutput = FileHandle.standardOutput
        taskProcess.standardError = FileHandle.standardOutput
        let result = command + " -p macos"
        taskProcess.arguments = ["-c", result]
        taskProcess.executableURL = URL(fileURLWithPath: "/bin/bash")
        taskProcess.standardInput = nil
        try taskProcess.run()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

