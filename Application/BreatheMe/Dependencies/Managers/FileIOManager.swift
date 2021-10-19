//
//  FileManager.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 19.10.2021.
//

import Foundation

class FileIOManager {

    private var fileHandle: FileHandle?

    deinit {
        fileHandle?.closeFile()
    }

    func createFileForShare() -> URL {
         URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent("yoga_training.txt")
    }

    func appendText(text: String, to fileURL: URL) throws {
        guard let data = text.data(using: .utf8) else { return }

        if let file = fileHandle ?? FileHandle(forWritingAtPath: fileURL.path) {
            file.seekToEndOfFile()
            file.write(data)
        }
        else {
            try data.write(to: fileURL, options: .atomic)
        }
    }

    func commmit() {
        fileHandle?.closeFile()
    }

}
