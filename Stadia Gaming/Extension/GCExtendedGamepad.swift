// Copyright (c) 2020 Nomad5. All rights reserved.

import Foundation
import GameController

extension GCExtendedGamepad {

    func toJson() -> String? {
        guard let buttonOptions = buttonOptions,
              let buttonHome = buttonHome,
              let leftThumbstickButton = leftThumbstickButton,
              let rightThumbstickButton = rightThumbstickButton else {
            return nil
        }
        return Controller(
                axes: [Double(leftThumbstick.xAxis.value),
                       Double(-1.0 * leftThumbstick.yAxis.value),
                       Double(rightThumbstick.xAxis.value),
                       Double(-1.0 * rightThumbstick.yAxis.value)],
                buttons: [Controller.Button(pressed: buttonA.isPressed, value: Double(buttonA.value)),
                          Controller.Button(pressed: buttonB.isPressed, value: Double(buttonB.value)),
                          Controller.Button(pressed: buttonX.isPressed, value: Double(buttonX.value)),
                          Controller.Button(pressed: buttonY.isPressed, value: Double(buttonY.value)),
                          Controller.Button(pressed: leftShoulder.isPressed, value: Double(leftShoulder.value)),
                          Controller.Button(pressed: rightShoulder.isPressed, value: Double(rightShoulder.value)),
                          Controller.Button(pressed: leftTrigger.isPressed, value: Double(leftTrigger.value)),
                          Controller.Button(pressed: rightTrigger.isPressed, value: Double(rightTrigger.value)),
                          Controller.Button(pressed: buttonOptions.isPressed, value: Double(buttonOptions.value)),
                          Controller.Button(pressed: buttonMenu.isPressed, value: Double(buttonMenu.value)),
                          Controller.Button(pressed: leftThumbstickButton.isPressed, value: Double(leftThumbstickButton.value)),
                          Controller.Button(pressed: rightThumbstickButton.isPressed, value: Double(rightThumbstickButton.value)),
                          Controller.Button(pressed: dpad.up.isPressed, value: Double(dpad.up.value)),
                          Controller.Button(pressed: dpad.down.isPressed, value: Double(dpad.down.value)),
                          Controller.Button(pressed: dpad.left.isPressed, value: Double(dpad.left.value)),
                          Controller.Button(pressed: dpad.right.isPressed, value: Double(dpad.right.value)),
                          Controller.Button(pressed: buttonHome.isPressed, value: Double(buttonHome.value)), ])
                .jsonString
    }
}