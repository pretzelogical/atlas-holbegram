# holbegram

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using flutter on Arch.
Flutter does not play well with pacman. To sidestep this, we are using flutter version manager to control our flutter sdk independent of the system package manager. You need the yay aur helper installed.

### Install
Install fvm and flutter.
 - Install with yay: ```yay -S fvm-bin```
 - Install latest stable sdk from fvm: ```fvm install stable```
 - Set stable as the global version: ```fvm global stable```

Install android dev-tools:
 - Install with yay: ```yay -S android-sdk-cmdline-tools-latest```
 - Logout and log back in
 - Install with sdkmanager: ```sudo sdkmanager "build-tools;34.0.0" "platform-tools" "platform;android-34" "emulator" "system-images;android-34;google_apis_playstore;arm64-v8a"```
 - Add emulator to path in ~/.bashrc:
 ```bash
 # Android emulator
 export PATH="$PATH":"/opt/android-sdk/emulator"
 ```

### Run

**TODO:** Determine if user needs to manually install flutter_emulator package

