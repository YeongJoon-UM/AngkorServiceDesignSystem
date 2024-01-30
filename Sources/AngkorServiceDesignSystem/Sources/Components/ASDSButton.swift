//
//  ASDSButton.swift
//  AngkorChat
//
//  Created by 정영준 on 2024/01/23.
//

import SwiftUI

public struct ASDSButton<Label: View>: View {
    private let action: () -> Void
    private let label: Label
    private let buttonType: ButtonType
    private let buttonSize: ButtonSize
    private var buttonState: ButtonState
    private let buttonWidth: CGFloat?
    
    /// Width 지정 버튼
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label, buttonType: ButtonType, buttonSize: ButtonSize, buttonState: ButtonState, buttonWidth: CGFloat) {
        self.action = action
        self.label = label()
        self.buttonType = buttonType
        self.buttonSize = buttonSize
        self.buttonState = buttonState
        self.buttonWidth = buttonWidth
    }
    
    /// Width 미지정 버튼 (Hug 방식)
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label, buttonType: ButtonType, buttonSize: ButtonSize, buttonState: ButtonState) {
        self.action = action
        self.label = label()
        self.buttonType = buttonType
        self.buttonSize = buttonSize
        self.buttonState = buttonState
        self.buttonWidth = nil
    }
    
    
    public var body: some View {
        Button(action: action) {
            label
        }
        .buttonStyle(ASDSButtonStyle(buttonType: buttonType, buttonSize: buttonSize, buttonState: buttonState, buttonWidth: buttonWidth))
        .disabled(buttonState == .Disabled)
    }
}


extension ASDSButton {
    private struct ASDSButtonStyle: ButtonStyle {
        let buttonType: ButtonType
        let buttonSize: ButtonSize
        var buttonState: ButtonState
        let buttonWidth: CGFloat?
        let buttonMinWidth: CGFloat
        let labelHorizontalPadding: CGFloat
        let fontType: ASDSFontType
        
        let cornerRadius: CGFloat
        
        var textColor: Color {
            switch buttonState {
            case .Default:
                return Color.ASDS.labelPrimary
            case .Active:
                return Color.ASDS.primary
            case .Disabled:
                return Color.ASDS.labelTertiary
            case .Progress:
                return Color.ASDS.labelPrimary
            }
        }
        
        init(buttonType: ButtonType, buttonSize: ButtonSize, buttonState: ButtonState, buttonWidth: CGFloat?) {
            self.buttonType = buttonType
            self.buttonSize = buttonSize
            self.buttonState =  buttonState
            self.buttonWidth = buttonWidth
            
            switch buttonSize {
            case .Xlarge:
                self.cornerRadius = 0
                self.fontType = .H6
                self.buttonMinWidth = .infinity
                self.labelHorizontalPadding = 16
            case .Large:
                self.cornerRadius = 8
                self.fontType = .H6
                self.buttonMinWidth = 96
                self.labelHorizontalPadding = 16
            case .Medium:
                self.cornerRadius = 8
                self.fontType = .H7
                self.buttonMinWidth = 72
                self.labelHorizontalPadding = 8
            case .Small:
                self.cornerRadius = 6
                self.fontType = .H7
                self.buttonMinWidth = 60
                self.labelHorizontalPadding = 8
            case .Xsmall:
                self.cornerRadius = 100
                self.fontType = .Caption
                self.buttonMinWidth = 48
                self.labelHorizontalPadding = 4
            }
        }
        
        func makeBody(configuration: Self.Configuration) -> some View {
            switch buttonType {
            case .Basic:
                if buttonState == .Progress {
                    ASDSButtonProgressView(color: Color.ASDS.white, size: buttonSize == .Xsmall ? 16 : buttonSize == .Small ? 20 : 24)
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .background(Color.ASDS.primary)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                } else {
                    configuration.label
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .ASDSFont(fontType, color: textColor)
                        .background(buttonState == .Disabled ? Color.ASDS.gray03 : configuration.isPressed ? Color.ASDS.primaryDark : Color.ASDS.primary)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                }
            case .BasicUnaccent:
                if buttonState == .Progress {
                    ASDSButtonProgressView(color: Color.ASDS.white, size: buttonSize == .Xsmall ? 16 : buttonSize == .Small ? 20 : 24)
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .background(Color.ASDS.primary)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                } else {
                    configuration.label
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .ASDSFont(fontType, color: textColor)
                        .background(buttonState == .Disabled ? Color.ASDS.gray06 : configuration.isPressed ? Color.ASDS.gray03 : Color.ASDS.gray05)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                }
            case .LineAccent:
                if buttonState == .Progress {
                    ASDSButtonProgressView(color: Color.ASDS.primary, size: buttonSize == .Xsmall ? 16 : buttonSize == .Small ? 20 : 24)
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .background(Color.ASDS.backgroundElevatedPrimary)
                        .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(Color.ASDS.primary, lineWidth: 1))
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                } else {
                    configuration.label
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .ASDSFont(fontType, color: textColor)
                        .background(buttonState == .Disabled ? Color.ASDS.backgroundElevatedPrimary : configuration.isPressed ? Color.ASDS.primaryLight : Color.ASDS.backgroundElevatedPrimary)
                        .cornerRadius(cornerRadius)
                        .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(buttonState == .Disabled ? Color.ASDS.gray06 : Color.ASDS.primary))
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                }
            case .Line:
                if buttonState == .Progress {
                    ASDSButtonProgressView(color: Color.ASDS.gray02, size: buttonSize == .Xsmall ? 16 : buttonSize == .Small ? 20 : 24)
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .background(Color.ASDS.backgroundElevatedPrimary)
                        .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(Color.ASDS.gray05, lineWidth: 1))
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                } else {
                    configuration.label
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .ASDSFont(fontType, color: buttonState == .Disabled ? Color.ASDS.labelTertiary : configuration.isPressed ? Color.ASDS.labelSecondary : textColor)
                        .background(Color.ASDS.backgroundElevatedPrimary)
                        .cornerRadius(cornerRadius)
                        .overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(buttonState == .Disabled ? Color.ASDS.gray06 : Color.ASDS.gray05))
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                }
            case .Text:
                if buttonState == .Progress {
                    ASDSButtonProgressView(color: Color.ASDS.gray02, size: buttonSize == .Xsmall ? 16 : buttonSize == .Small ? 20 : 24)
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                } else {
                    configuration.label
                        .padding(.horizontal, buttonWidth == nil ? labelHorizontalPadding : 0)
                        .frame(minWidth: buttonMinWidth, maxWidth: buttonWidth, minHeight: buttonSize.height, maxHeight: buttonSize.height)
                        .contentShape(RoundedRectangle(cornerRadius: 8))
                        .ASDSFont(fontType, color: buttonState == .Disabled ? Color.ASDS.labelTertiary : configuration.isPressed ? Color.ASDS.labelSecondary : textColor)
                        .cornerRadius(cornerRadius)
                        .padding(.horizontal, buttonSize != .Xlarge && buttonWidth == .infinity ? 16 : 0)
                }
            }
        }
    }
}

extension ASDSButton {
    private struct ASDSButtonProgressView: View {
        @State private var isLoading = false
        let color: Color
        let size: CGFloat
        
        init(color: Color, size: CGFloat) {
            self.color = color
            self.size = size
        }
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(color.opacity(0.3), lineWidth: 3)
                    .frame(width: size, height: size)
                
                Circle()
                    .trim(from: 0, to: 0.75)
                    .stroke(color, lineWidth: 3)
                    .frame(width: size, height: size)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.isLoading = true
                    }
            }
        }
    }
}

extension ASDSButton {
    public enum ButtonType {
        /// 기본형
        case Basic
        /// 기본 비강조형
        case BasicUnaccent
        /// 라인 강조형
        case LineAccent
        /// 라인 비강조형
        case Line
        /// 텍스트형
        case Text
    }

    public enum ButtonSize {
        /// height: 48px - width: .infinity - withNoPadding and Round
        case Xlarge
        /// height: 48px - width: .infinity
        case Large
        /// height: 40px
        case Medium
        /// height: 32px
        case Small
        /// height: 24px
        case Xsmall
        
        var height: CGFloat {
            switch self {
            case .Xlarge:
                return 48
            case .Large:
                return 48
            case .Medium:
                return 40
            case .Small:
                return 32
            case .Xsmall:
                return 24
            }
        }
    }

    public enum ButtonState {
        /// 기본 상태
        case Default
        /// 활성화 상태
        case Active
        /// 비활성화 상태
        case Disabled
        /// 로딩 상태
        case Progress
    }
}
