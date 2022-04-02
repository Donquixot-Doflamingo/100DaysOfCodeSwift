//
//  challenge.swift
//  CoreDataProject
//
//  Created by harsh Khandelwal on 07/11/21.
//

import SwiftUI

struct challenge: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    //MARK-: Chllenge 1.1 Creating sortDescriptors variables
    let sortDescriptors = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]
    
    //MARK -: Chllenge 3.1 create @State private var of filteringStyle
    @State private var filteringStyle = FilterType.beginWidth
    
    //MARK -: Chllenge 3.1 create array of FilteringStyle
    let arrayOfFilterType : Array<FilterType> = FilterType.allCases
    
    var body: some View {
        VStack {
            //MARK-: Chllenge 1.3 Put sortDiscriptors to the filteredList
            filteredList(filterKey: "lastName", filterValue: lastNameFilter, sortDiscriptors: [], filteringType : filteringStyle) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                let harsh = Singer(context: self.moc)
                harsh.firstName = "harsh"
                harsh.lastName = "Khandelwal"
                
                let barns = Singer(context: self.moc)
                barns.firstName = "Barns"
                barns.lastName = "Courtney"

                try? self.moc.save()
            }
            //MARK -: Chllenge 3.5 Check letter with the button and func checkLetter
            
            HStack{
                Button("Show A") {
                    self.lastNameFilter = self.checkLetter(letter: "A")
                }

                Button("Show S") {
                    self.lastNameFilter = self.checkLetter(letter: "S")
                }
            }
            
            //MARK -: Chllenge 3.6 Create picker for filteringStyle
            
            Picker("For filtering Style", selection: $filteringStyle){
                ForEach(arrayOfFilterType, id: \.self){ filterType in
                    Text("\(filterType.rawValue)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    //MARK -: Chllenge 3.4 Create func checkLetter
    
    func checkLetter(letter : String) -> String{
        switch filteringStyle{
            case .beginWidth:
            return letter.capitalized
            case .beginWidthCaseSensitive:
                return letter.lowercased()
            case .contains :
                return letter
            case .containsCaseSensitive:
                return letter.lowercased()
            case .endsWith:
                return letter.lowercased()
            default:
                return letter.lowercased()
        }
    }
}

struct challenge_Previews: PreviewProvider {
    static var previews: some View {
        challenge()
    }
}
