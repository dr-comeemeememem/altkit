import SwiftUI

struct Main: View {
    @State public var pageTitles: [String] = []
    @State public var pages: [String] = [] 
    @State private var newPageURL = ""
    @State private var makeTab: Bool = false
    @State private var deletePage = false
    
    var body: some View {
        NavigationView {
            List {
                if !pages.isEmpty {
                    ForEach(0..<min(pages.count, pageTitles.count), id: \.self) { index in
                        NavigationLink(destination: WebViewContainer(urlString: pages[index], pageTitle: $pageTitles[index]).navigationBarTitle(pageTitles[index] + " " + pages[index])) {
                            Text(pageTitles[index])
                        }
                    }
                    .onDelete(perform: deleteTabs)
                } else {
                    Text("Use the Plus button to create a tab")
                }
            }
            .navigationBarTitle("Altkit Browser", displayMode: .inline)
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        makeTab = true
                    }) {
                        Image(systemName: "plus.circle")
                            .symbolRenderingMode(.multicolor)
                    }
                    .popover(isPresented: $makeTab) {
                        TextField("Enter URL", text: $newPageURL)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Button("Create") {
                            makeTab = false
                            if !newPageURL.isEmpty {
                                pageTitles.append("Loading...")
                                pages.append(newPageURL)
                                newPageURL = ""
                            }
                        }
                        .padding(.bottom)
                    }
                }
            )
        }
    }
    
    private func deleteTabs(at offsets: IndexSet) {
        pageTitles.remove(atOffsets: offsets)
        pages.remove(atOffsets: offsets)
    }
}
