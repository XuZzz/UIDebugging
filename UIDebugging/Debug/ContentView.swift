//
//  ContentView.swift
//  UIDebugging
//
//  Created by Xu on 2020/10/20.
//

import SwiftUI

@available(iOS 13.0, *)
struct ContentView: View {
    @State var text: String = "hello"
    var body: some View {
        CustomView(text: self.$text)
    }
}

@available(iOS 13.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { //将内容视图放置在NavigationView中里，从而预览当前页面位于导航视图里的效果
            ContentView()
        }
    }
}
