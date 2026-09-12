import QtQuick
import qs.Common

QtObject {
    function check(done) {
        Proc.runCommand(
            "hyprWindows.startupCheck",
            [
                "sh",
                "-c",
                "command -v hyprctl >/dev/null 2>&1 && hyprctl -j clients >/dev/null 2>&1"
            ],
            (stdout, exitCode) => {
                if (exitCode === 0) {
                    done(null)
                    return
                }

                done({
                    "title": "Hyprland is required",
                    "details": "Hyprland Windows needs a running Hyprland session and hyprctl."
                })
            },
            0
        )
    }
}
