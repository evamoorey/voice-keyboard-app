//
//  AppControlService.swift
//  VoiceKeyboard
//
//  Created by Ева Галюта on 24.03.2023.
//

import Foundation

import Foundation
import GRPC
import NIO
import SwiftProtobuf

class AppControlService {
    private let host = "localhost"
    private let port = 50033
    private var id = 0
    
    init() {
    }
    
    func turnOnMicro(status: Bool) -> String {
        do {
            let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
            defer {
                try? group.syncShutdownGracefully()
            }

            let channel = try GRPCChannelPool.with(
                target: .host(self.host, port: self.port),
                transportSecurity: .plaintext,
                eventLoopGroup: group
            )

            let client = AppControl_AppControlNIOClient(channel: channel)
            
            let statusCmd: AppControl_ChangeMicrophoneStatusRequest = .with {
                $0.on = status
            }

            _ = try client.changeMicrophoneStatus(statusCmd).response.wait()

        } catch let error as GRPCStatus {
            print("ERROR (Get command): \(error)")
            return error.message ?? "Ошибка сервера"
        } catch {
            print("ERROR (Command service): \(error)")
        }
        return "OK"
    }
}
