//
//  ContentView.swift
//  iPhoneSample
//
//  Created by Kévin Sibué on 28/09/2022.
//

import SwiftUI
import KVFileKit

struct Entry: Identifiable {
    let id: String
    let path: String
    let isDirectory: Bool
}

public final class ViewModel: ObservableObject {

    let fileSystem = FileSystem(fileManager: FileManager.default)
    var directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

    @Published
    var entries: [Entry] = []

    @Published
    var directoryName: String = ""

    @Published
    var fileName: String = ""

    @Published
    var fileExtension: String = ""

    @Published
    var fileContent: String = ""

    init() {
        refreshEntries()
    }

    func refreshEntries() {
        guard let url = directoryUrl else { return }
        entries = fileSystem.getEntries(from: url).compactMap {
            let isDirectory = $0 is Directory
            return Entry(id: $0.path.path, path: $0.path.path, isDirectory: isDirectory)
        }
    }

    func addDirectory() {
        guard let url = directoryUrl,
              let directory = fileSystem.getDirectory(from: url) else { return }
        defer {
            directoryName = ""
        }
        do {
            _ = try directory.createDirectory(with: directoryName)
            refreshEntries()
        } catch {
            print(error)
        }
    }

    func addFile() {
        guard let url = directoryUrl,
              let directory = fileSystem.getDirectory(from: url) else { return }
        defer {
            fileName = ""
            fileExtension = ""
        }
        do {
            _ = try directory.createFile(with: fileName, ext: fileExtension)
            refreshEntries()
        } catch {
            print(error)
        }
    }

    func change(url: URL) {
        self.directoryUrl = url
        self.refreshEntries()
    }

    func goBack() {
        guard let url = directoryUrl else { return }
        self.directoryUrl = url.deletingLastPathComponent()
        self.refreshEntries()
    }

    func readAsText(_ entry: Entry) {
        let file = fileSystem.getFile(from: URL(fileURLWithPath: entry.path))
        fileContent = file?.readAsString() ?? ""
    }

}

struct ContentView: View {

    @State
    var displayText: Bool = false

    @StateObject
    var model = ViewModel()

    var body: some View {
        List {
            Section("Items") {
                Button {
                    model.goBack()
                } label: {
                    Text("..")
                }
                ForEach(model.entries) { entry in
                    if entry.isDirectory {
                        Button {
                            model.change(url: URL(fileURLWithPath: entry.path))
                        } label: {
                            Text("\(entry.path)")
                        }
                    } else {
                        HStack {
                            Text("\(entry.path)")
                            Button("Read as text") {
                                model.readAsText(entry)
                                displayText = true
                            }
                        }
                    }
                }
            }
            Section("Create directory") {
                TextField("Directory's name", text: $model.directoryName)
                Button(action: model.addDirectory) {
                    Text("Create")
                }
            }
            Section("Create file") {
                TextField("File's name", text: $model.fileName)
                TextField("File's extension", text: $model.fileExtension)
                Button(action: model.addFile) {
                    Text("Create")
                }
            }
        }
        .sheet(isPresented: $displayText) {
            ScrollView {
                VStack {
                    Text(model.fileContent)
                    Button {
                        displayText = false
                    } label: {
                        Text("Fermer")
                    }
                }
            }
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
