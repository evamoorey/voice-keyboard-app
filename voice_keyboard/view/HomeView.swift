//
//  HomeView.swift
//  voice-keyboard
//
//  Created by Ева Галюта on 12.03.2023.
//
import SwiftUI

struct HomeView: View {
    private let taskProcess: Process
    private let commandService: CommandService
    
    init(process: Process, service: CommandService) {
        self.taskProcess = process
        self.commandService = service
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Голосовая клавиатура").font(Font.headline.weight(.bold))
                        Text("v1.0.0")
                    }
                    HStack {
                        Button {
                            // Settings
                        }label: {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 19.0, height: 19.0)
                        }.buttonStyle(PlainButtonStyle()).focusable(false).frame(width: 28, height: 28)
                        Divider().frame(width:1, height: 20)
                        Button {
                            print("Shut down server")
                            taskProcess.interrupt()
                            NSApplication.shared.terminate(nil)
                        }label: {
                            Image(systemName: "power")
                                .resizable()
                                .frame(width: 17.0, height: 17.0)
                        }.buttonStyle(PlainButtonStyle()).focusable(false).frame(width: 28, height: 28)
                    }.background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:93, height: 40, alignment: .leading)).padding(.leading, 40)
                }.background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:309, height: 70)).padding(.top, 31)
                HStack {
                    NavigationLink(destination: AddShortcutView(service: commandService)) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "EBEBF5").opacity(0.2))
                                Image(systemName: "sparkles")
                                    .resizable()
                                    .frame(width: 15.0, height: 19.0)
                            }.frame(width: 30.0, height: 30.0).padding()
                            VStack (alignment: .leading) {
                                Text("Добавить").font(Font.headline.weight(.bold))
                                Text("команду").font(Font.headline.weight(.bold))
                            }
                        }.frame(width:195, height:85, alignment: .leading)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:202, height: 85)).focusable(false).padding(.leading, 4)
                    NavigationLink(destination: ShortcutsView(service: commandService)) {
                        VStack (alignment: .leading) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "EBEBF5").opacity(0.2))
                                Image(systemName: "folder")
                                    .resizable()
                                    .frame(width: 18.0, height: 16.0)
                            }.frame(width: 30.0, height: 30.0)
                            VStack (alignment: .leading) {
                                Text("Введённые").font(Font.headline.weight(.bold))
                                Text("команды").font(Font.headline.weight(.bold))
                            }
                        }.frame(width:77, height:85, alignment: .leading)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).padding(.leading, 17)
                }.frame(width: 309, height: 85, alignment: .leading).padding(.top, 21)
                HStack {
                    Button {
                        // Import shortcuts
                    }label: {
                        VStack (alignment: .leading) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "EBEBF5").opacity(0.2))
                                Image(systemName: "square.and.arrow.down")
                                    .resizable()
                                    .frame(width: 17.0, height: 18.0)
                            }.frame(width: 30.0, height: 30.0)
                            VStack (alignment: .leading) {
                                Text("Импорт").font(Font.headline.weight(.bold))
                                Text("команд").font(Font.headline.weight(.bold))
                            }
                        }.frame(width:70, height:85, alignment: .leading)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).frame(width:95, height: 85)
                    Button {
                        // Export shortcuts
                    }label: {
                        VStack (alignment: .leading) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "EBEBF5").opacity(0.2))
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .frame(width: 17.0, height: 18.0)
                            }.frame(width: 30.0, height: 30.0)
                            VStack (alignment: .leading) {
                                Text("Экспорт").font(Font.headline.weight(.bold))
                                Text("команд").font(Font.headline.weight(.bold))
                            }
                        }.frame(width:70, height:85, alignment: .leading)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).frame(width:95, height: 85)
                }.frame(width: 309, height: 85, alignment: .leading).padding(.top, 4)
            }
        }.frame(width: 333, height: 288, alignment: .top)
    }
}

//var taskProcess = Process()
//
//struct HomeView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        HomeView(process: taskProcess, service: CommandService())
//    }
//}
