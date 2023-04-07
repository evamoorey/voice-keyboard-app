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
    private let appControlService: AppControlService
    
    @State private var status = true
    @State private var showingAlert = false
    @State private var state: String = "Ошибка"
    @State private var response: String = "OK"
    @State private var fileName = "<none>"
    @State private var directoryName = "<none>"
    
    init(process: Process, service: CommandService, appControl: AppControlService) {
        self.taskProcess = process
        self.commandService = service
        self.appControlService = appControl
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
                            print("Shut down server")
                            taskProcess.interrupt()
                            NSApplication.shared.terminate(nil)
                        }label: {
                            Image(systemName: "power")
                                .resizable()
                                .frame(width: 17.0, height: 17.0)
                        }.buttonStyle(PlainButtonStyle()).focusable(false).frame(width: 28, height: 28)
                    }.background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:40, height: 40, alignment: .leading)).padding(.leading, 78)
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
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).padding(.leading, 15)
                }.frame(width: 309, height: 85, alignment: .leading).padding(.top, 21)
                HStack {
                    Button {
                        // Import commands
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
                                showingAlert = true
                            }
                        }
                    }label:{
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
                    }.alert(state, isPresented: $showingAlert) {
                    } message: {
                        Text(self.response)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).frame(width:95, height: 85)
                    Button {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = false
                        panel.canChooseDirectories = true
                        panel.canChooseFiles = false
                        if panel.runModal() == .OK {
                            directoryName = panel.url?.path() ?? "<none>"
                        }
                        print(directoryName)
                        if directoryName == "<none>" {
                            state = "Ошибка"
                            response = "Папка не была выбрана"
                            showingAlert = true
                        } else {
                            response = commandService.exportCommands(path: directoryName + "commands.json")
                            if response != "OK" {
                                state = "Ошибка"
                                showingAlert = true
                            } else {
                                state = "Инфо"
                                response = "Команды экспортированы успешно в " + directoryName
                                showingAlert = true
                            }
                        }
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
                    }.alert(state, isPresented: $showingAlert) {
                    } message: {
                        Text(response)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).frame(width:95, height: 85).padding(.leading, 3)
                    Button {
                        // Mute/unmute
                        self.status.toggle()
                        self.response = appControlService.turnOnMicro(status: self.status)
                        if self.response != "OK" {
                            self.showingAlert = true
                        }
                    }label: {
                        VStack (alignment: .leading) {
                            ZStack {
                                Circle()
                                    .fill(status ? Color(hex: "EBEBF5").opacity(0.2) : Color(hex: "3478F6"))
                                Image(systemName: "mic.slash")
                                    .resizable()
                                    .frame(width: 17.0, height: 19.0)
                            }.frame(width: 30.0, height: 30.0)
                            VStack (alignment: .leading) {
                                Text("Пауза").font(Font.headline.weight(.bold))
                                Text(" ").font(Font.headline.weight(.bold))
                            }
                        }.frame(width:70, height:85, alignment: .leading)
                    }.alert("Ошибка", isPresented: $showingAlert) {
                    } message: {
                        Text(self.response)
                    }.buttonStyle(PlainButtonStyle()).background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color(hex: "EBEBF5").opacity(0.2), lineWidth: 0.5)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EBEBF5").opacity(0.05))).frame(width:95, height: 85)).focusable(false).frame(width:95, height: 85).padding(.leading, 3)
                }.frame(width: 309, height: 85, alignment: .leading).padding(.top, 4).padding(.leading, 3)
            }
        }.frame(width: 333, height: 288, alignment: .top)
    }
}

//var taskProcess = Process()
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(process: taskProcess, service: CommandService())
//    }
//}
