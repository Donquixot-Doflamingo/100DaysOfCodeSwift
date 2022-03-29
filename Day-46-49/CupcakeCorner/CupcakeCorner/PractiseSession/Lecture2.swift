//
//  Lecture2.swift
//  CupcakeCorner
//
//  Created by harsh Khandelwal on 26/10/21.
//

import SwiftUI
//iOS gives us built-in tools for sending and receiving data from the internet, and if we combine it with Codable support then it’s possible to convert Swift objects to JSON for sending, then receive back JSON to be converted back to Swift objects. Even better, when the request completes we can immediately assign its data to properties in SwiftUI views, causing our user interface to update.
struct Response: Codable{
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}
struct Lecture2: View {
    
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData(){
        /*
        1. Creating the URL we want to read.
        2. Wrapping that in a URLRequest, which allows us to configure how the URL should be accessed.
        3. Create and start a networking task from that URL request.
        4. Handle the result of that networking task.
        */
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        /*
         URLSession is the iOS class responsible for managing network requests. You can make your own session if you want to, but it’s very common to use the shared session that iOS creates for us to use – unless you need some specific behavior, using the shared session is fine.
         
        Our code then calls dataTask(with:) on that shared session, which creates a networking task from a URLRequest and a closure that should be run when the task completes. In our code that’s provided using trailing closure syntax, and as you can see it accepts three parameters:

        -> data is whatever data was returned from the request.
        -> response is a description of the data, which might include what type of data it is, how much was sent, whether there was a status code, and more.
        -> error is the error that occurred.
         
         Now, cunningly some of those properties are mutually exclusive, by which I mean that if an error occurred then data won’t be set, and if data was sent back then error won’t be set. This strange state of affairs exists because the URLSession API was made before Swift came along, so there was no nicer way of representing this either-or state.
         
         Notice the way we call resume() on the task straight away? That’s the gotcha – that’s the thing you’ll forget time and time again. Without it the request does nothing and you’ll be staring at a blank screen. But with it the request starts immediately, and control gets handed over to the system – it will automatically run in the background, and won’t be destroyed even after our method ends.

         When the request finishes, successfully or not, step 4 kicks in – that’s the closure inside the data task, and is responsible for doing something with the data or error. In our case we’re going to check whether the data was set, and if it was try to decode it into an instance of our Response struct because that’s what the iTunes API sends back. We don’t actually want the whole response, just the results array inside it so that our List will show them all.
        */
        URLSession.shared.dataTask(with: request) { data, response, error in
            // step 4
            /*
             However, there’s another catch here: URLSession automatically runs in the background, which means its completion closure will also be run in the background. By “background” I mean what’s technically known as a background thread – an independent piece of code that’s running at the same time as the rest of our program. This means the network request can be running, and even take a few seconds, without stopping our UI from being interactive.

             iOS likes to have all its user interface work done on what’s called the main thread, which is the one where the program was started. This stops two pieces of code trying to manipulate the user interface simultaneously, because if all UI-related work takes place on the main thread then it can’t clash.

             We want to change the results property of our view to be whatever was downloaded through the iTunes API, which in turn will update our user interface. That might work great on a background thread because SwiftUI is super smart, but honestly it’s just not worth the risk – it’s a much better idea to fetch your data in the background, decode it from JSON in the background, then actually update the property on the main thread to avoid any potential for problems.

             iOS gives us a very particular way of sending work to the main thread: DispatchQueue.main.async(). This takes a closure of work to perform, and sends it off to the main thread for execution. As you can see from its name, what’s actually happening is that it’s added to a queue – a big line of work that’s waiting for execution. The “async” part is short for “asynchronous”, which means our own background work won’t wait for the closure to be run; we just add it to the queue and carry on working in the background.
             */
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Lecture2_Previews: PreviewProvider {
    static var previews: some View {
        Lecture2()
    }
}
