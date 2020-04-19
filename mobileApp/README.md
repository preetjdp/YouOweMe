## Styles
Dart File Naming Convention => lowerCamelCase

## Font
The font being used throughout the application is.
[Aileron Black](https://open-foundry.com/fonts/aileron_black)

## How to get the app started.
```bash
flutter run
```
YouOweMe uses [Device Preview](https://pub.dev/packages/device_preview) to
build and to visualise how the app will look
on different devices.

On First Debug Run you will find a such a layout:

![screenshot](https://user-images.githubusercontent.com/27439197/76833208-efea3f00-6850-11ea-867a-231a47072f50.png)

This applicaiton used Artemis for graphql code generation.

To update the schema get the latest form the [API](https://youoweme-6c622.appspot.com/),
and update the file located at `lib/resources/graphql/youoweme.schema.graphql`

## Run the code generator
```bash
flutter pub run build_runner build
```

## Add New Queries / Mutation / Subscriptions
Add them to their respective folders under `lib/resources/graphql/`

## Add missing files in code.
flutter create . --org dev.preetjdp youoweme

## How to update the icon
flutter pub run flutter_launcher_icons:main

## KeyTool options
`Password => q^iB07QT `

## Get Sha Key from key.jks
```bash
keytool -list -v -keystore {filePath} -alias {key-alias}
Example:
keytool -list -v -keystore ./android/app/key.jks -alias key
```

