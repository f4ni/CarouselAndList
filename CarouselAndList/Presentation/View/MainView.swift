//
//  MainView.swift
//  CarouselAndList
//
//  Created by Furkan ic on 6.02.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = ViewModel()
    @State var navigationPath = NavigationPath()
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                VStack {
                    mainContainerView
                        .padding(.bottom, 24)
                }
                
                floatingButton
                    .padding(.bottom)
                    .padding(.trailing)
                
                if viewModel.isLoading {
                    ActivityIndicatorView()
                }
            }
            .navigationTitle("Movie Bag")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.bg)
            
        }
        .sheet(isPresented: $showSheet, content: {
            sheetView
        })
        .alert(viewModel.errorMessage, isPresented: $viewModel.showAlert) {}
        .task {
            viewModel.fetchMovies()
        }
    }
    
    var mainContainerView: some View {
        ScrollView {
            VStack {
                bannerView
                    .listRowBackground(Color.clear)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                listView
            }
            .padding(24)
        }
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
               .resizable()
               .scaledToFit()
               .frame(width: 16)
            TextField(text: $viewModel.searchText) {
               
            }
        }
        .padding(8)
        .background(.gray.opacity(0.16))
        .cornerRadius(12)
        .padding(.vertical, 24)
        .background(.bg)
    }
    
    var bannerView: some View {
        ZStack {
            if let bannerList = viewModel.movieList?.bannerList {
                CarouselView(movies: bannerList, selectedIndex: $viewModel.selection)
            }
        }
    }
    
    var listView: some View {
        ZStack {
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(viewModel.filteredMovies.filter({$0.type == viewModel.selection?.type})) { movie in
                        MovieListItem(
                            movie: movie
                        )
                    }
                } header: {
                    searchBar
                }
            }
        }
    }
    
    var floatingButton: some View {
        Button(action: {
            showSheet.toggle()
        }, label: {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .rotationEffect(.init(degrees: 90))
                .padding()
                .frame(width: 48, height: 48)
                .background(.floatingButton)
                .clipShape(Circle())
                .foregroundStyle(Color.white)
                .shadow(radius: 3)
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    var sheetView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.listOfMoviesNames())
            Text(viewModel.countOfMovies())
            Text(viewModel.getTopOccurringForList())
        }
    }
}

#Preview {
    MainView()
}
