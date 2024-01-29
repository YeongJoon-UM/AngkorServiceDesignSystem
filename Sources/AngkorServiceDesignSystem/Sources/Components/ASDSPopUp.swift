//
//  ASDSPopUp.swift
//  AngkorChat
//
//  Created by 정영준 on 2024/01/23.
//


import SwiftUI

public struct ASDSPopUpViewModifier: ViewModifier {
    private let popUp: ASDSPopUpView
    @Binding var isPresented: Bool
    
    public init(popUp: ASDSPopUpView, isPresented: Binding<Bool>) {
        self.popUp = popUp
        self._isPresented = isPresented
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                Color.black.opacity(0.6).ignoresSafeArea()
                popUp
            }
            .opacity(isPresented ? 1 : 0)
            .animation(.easeInOut, value: isPresented)
        }
    }
}

extension View {
    public func ASDSPopUp(_ isPresented: Binding<Bool>, popUp: () -> ASDSPopUpView) -> some View {
        self.modifier(ASDSPopUpViewModifier(popUp: popUp(), isPresented: isPresented))
    }
}

public struct ASDSPopUpView: View {
    private let popUpType: PopUpType
    private let title: String?
    private let content: String
    
    private let rightLabel: String
    private let rightAction: () -> Void
   
    private let leftLabel: String
    private let leftAction:() -> Void
  
    public init(title: String? = nil, content: String, popUpType: PopUpType = .OneButton, rightLabel: String, rightAction: @escaping () -> Void) {
        self.title = title
        self.content = content
        self.popUpType = popUpType
        self.rightLabel = rightLabel
        self.rightAction = rightAction
        self.leftLabel = ""
        self.leftAction = { }
    }
    
    public init(title: String? = nil, content: String, popUpType: PopUpType = .TwoButton, rightLabel: String, rightAction: @escaping () -> Void, leftLabel: String, leftAction: @escaping () -> Void) {
        self.title = title
        self.content = content
        self.popUpType = popUpType
        self.rightLabel = rightLabel
        self.rightAction = rightAction
        self.leftLabel = leftLabel
        self.leftAction = leftAction
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if self.popUpType == .OneButton {
                if let title = self.title {
                    Text(title)
                        .ASDSFont(.H6)
                        .padding(.bottom, 4)
                    Text(content)
                        .ASDSFont(.BodySmall)
                        .padding(.bottom, 16)
                    HStack(spacing: 0) {
                        Spacer()
                        ASDSButton(action: {
                            rightAction()
                        }, label: {
                            Text(rightLabel)
                        }, buttonType: .Basic, buttonSize: .Small, buttonState: .Default, buttonWidth: 72)
                    }
                } else {
                    Text(content)
                        .ASDSFont(.H6)
                        .padding(.bottom, 16)
                    HStack(spacing: 0) {
                        Spacer()
                        ASDSButton(action: {
                            rightAction()
                        }, label: {
                            Text(rightLabel)
                        }, buttonType: .Basic, buttonSize: .Small, buttonState: .Default, buttonWidth: 72)
                    }
                }
            } else {
                if let title = self.title {
                    Text(title)
                        .ASDSFont(.H6)
                        .padding(.bottom, 4)
                    Text(content)
                        .ASDSFont(.BodySmall)
                        .padding(.bottom, 24)
                    HStack(spacing: 8) {
                        ASDSButton(action: {
                            leftAction()
                        }, label: {
                            Text(leftLabel)
                        }, buttonType: .Line, buttonSize: .Small, buttonState: .Default, buttonWidth: 120)
                        
                        ASDSButton(action: {
                            rightAction()
                        }, label: {
                            Text(rightLabel)
                        }, buttonType: .Basic, buttonSize: .Small, buttonState: .Default, buttonWidth: 120)
                    }
                } else {
                    Text(content)
                        .ASDSFont(.H6)
                        .padding(.bottom, 24)
                    HStack(spacing: 8) {
                        ASDSButton(action: {
                            leftAction()
                        }, label: {
                            Text(leftLabel)
                        }, buttonType: .Line, buttonSize: .Small, buttonState: .Default, buttonWidth: 120)
                        
                        ASDSButton(action: {
                            rightAction()
                        }, label: {
                            Text(rightLabel)
                        }, buttonType: .Basic, buttonSize: .Small, buttonState: .Default, buttonWidth: 120)
                    }
                }
            }
        }
        .padding(16)
        .background(Color.ASDS.backgroundPrimary)
        .cornerRadius(8)
        .frame(width: 280)
    }

}

extension ASDSPopUpView {
    public enum PopUpType {
        case OneButton
        case TwoButton
    }
}

