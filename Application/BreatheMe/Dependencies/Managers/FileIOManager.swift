//
//  FileManager.swift
//  BreatheMe
//
//  Created by Denis Kovalev on 19.10.2021.
//

import Foundation

/// A manager class for working with file system
class FileIOManager {
    // MARK: - Properties

    private var fileHandle: FileHandle?

    // MARK: - Deinitialization

    deinit {
        fileHandle?.closeFile()
    }

    // MARK: - File system methods

    /// Deletes `file`
    func deleteFile(_ file: URL) {
        try? FileManager.default.removeItem(at: file)
    }

    /// Creates an empty file and returns its url
    func createFileForShare() -> URL {
        URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(GlobalConstants.tempFileName)
    }

    /// Appends `text` to the end of file at `fileURL`. Doesn't close file connection after writing, use `commit()` for this.
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

    /// Closes opened file connection
    func commmit() {
        fileHandle?.closeFile()
        fileHandle = nil
    }

}
