//
//  AddBookView.swift
//  Bookworm
//
//  Created by harsh Khandelwal on 29/10/21.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    // to dismiss the popupView
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    var currentDate = Date()
    
    let genres = ["Fantasy", "Horror", "Anime", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)

                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
//                        When it comes to filling in the button’s action, we’re going to create an instance of the Book class using our managed object context, copy in all the values from our form (converting rating to an Int16 to match Core Data), then save the managed object context.
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        // MARK: Challenge 3
                        newBook.currentDate = self.currentDate

                        try? self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                // MARK: Challenge 1
                .disabled(self.genre.isEmpty || self.title.isEmpty || self.author.isEmpty)
            }
            .navigationBarTitle("Add Book")
        }
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
