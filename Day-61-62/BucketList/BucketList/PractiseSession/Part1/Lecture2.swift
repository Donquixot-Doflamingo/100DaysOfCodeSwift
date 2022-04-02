//
//  Lecture2.swift
//  BucketList
//
//  Created by harsh Khandelwal on 26/11/21.
//

// MARK:                    Writing data to the documents directory

import SwiftUI

struct Lecture2: View {
    
    func getDocumentsDirectory() -> URL {
    /*
         That documents directory is ours to do with as we please, and because it belongs to the app it will automatically get deleted if the app itself gets deleted. Other than physical device limitations there is no limit to how much we can store, although remember that users can use the Settings app to see how much storage your app takes up – be respectful!
         
         Now that we have a directory to work with, we can read and write files there freely. You already met String(contentsOf:) and Data(contentsOf:) for reading data, but for writing data we need to use the write(to:) method. When used with strings this takes three parameters:
         
         -> A URL to write to.
            //MARK: Explanation
     The first of those can be created by combining the documents directory URL with a filename, such as myfile.txt.
     
         -> Whether to make the write atomic, which means “all at once”.
            //MARK: Explanation
    The second should nearly always be set to true. If this is set to false and we try to write a big file, it’s possible that another part of our app might try and read the file while it’s still being written. This shouldn’t cause a crash or anything, but it does mean that it’s going to read only part of the data, because the other part hasn’t been written yet. Atomic writing causes the system to write our full file to a temporary filename (not the one we asked for), and when that’s finished it does a simple rename to our target filename. This means either the whole file is there or nothing is.
         -> What character encoding to use.
            //MARK: Explanation
     The third parameter is something we looked at briefly in project 5, because we had to use a Swift string with an Objective-C API. Back then we used the character encoding UTF-16, which is what Objective-C uses, but Swift’s native encoding is UTF-8, so we’re going to use that instead.
    */
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
        
    }
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
