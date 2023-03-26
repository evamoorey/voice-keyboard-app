//
//  CheckConnection.swift
//  VoiceKeyboard
//
//  Created by Ева Галюта on 26.03.2023.
//

import Foundation
import GRPC
import NIO
import SwiftProtobuf

class Connection {
    
    func established(host: String, port: Int) -> Bool {
        do {
            let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
            defer {
                try? group.syncShutdownGracefully()
            }
            
            let channel = try GRPCChannelPool.with(
                target: .host(host, port: port),
                transportSecurity: .plaintext,
                eventLoopGroup: group
            )
            
            let client = Commands_CommandsNIOClient(channel: channel)
            
            _ = try client.getCommands(SwiftProtobuf.Google_Protobuf_Empty()).response.wait()
            return true
        } catch {
            return false
        }
    }
}
