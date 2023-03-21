//
//  CommandService.swift
//  voice-keyboard
//
//  Created by Ева Галюта on 05.03.2023.
//

import Foundation
import GRPC
import NIO
import SwiftProtobuf

class CommandService {
    private let host = "localhost"
    private let port = 50033
    private var id = 0
    
    init() {
    }
    
    func addCommand(command: String, hotKey: String) -> String {
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
            
            let client = Commands_CommandsNIOClient(channel: channel)
            
            let addCmd: Commands_AddCommandRequest = .with {
                $0.command = command
                $0.hotkey = hotKey
            }
                        
            _ = try client.addCommand(addCmd).response.wait()

        } catch let error as GRPCStatus {
            print("ERROR (Add command): \(error)")
            return error.message ?? "Ошибка сервера"
        } catch {
            print("ERROR (Command service): \(error)")
        }
        return "OK"
    }
    
    func deleteCommand(command: String) -> String {
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
            
            let client = Commands_CommandsNIOClient(channel: channel)
            
            let deleteCmd: Commands_DeleteCommandRequest = .with {
                $0.command = command
            }
                        
            _ = try client.deleteCommand(deleteCmd).response.wait()

        } catch let error as GRPCStatus {
            print("ERROR (Delete command): \(error)")
            return error.message ?? "Ошибка сервера"
        } catch {
            print("ERROR (Command service): \(error)")
        }
        return "OK"
    }
    
    func getCommands() -> [CommandInfo] {
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
            
            let client = Commands_CommandsNIOClient(channel: channel)

            let response = try client.getCommands(SwiftProtobuf.Google_Protobuf_Empty()).response.wait()
            print(response.commands)
            
            var commands = [CommandInfo]()
            for (key, value) in response.commands {
                commands.append(CommandInfo(id: id, command: key, shortcut: value))
                id += 1
            }
            commands.sort {
                $0.command < $1.command
            }
            return commands
        } catch let error as GRPCStatus {
            print("ERROR (Get command): \(error)")
            return []
        } catch {
            print("ERROR (Command service): \(error)")
        }
        return []
    }
}
