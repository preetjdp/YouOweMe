## Styles

Dart File Naming Convention => lowerCamelCase

## Font

The font being used throughout the application is
[Aileron Black](https://open-foundry.com/fonts/aileron_black)

## How to get the app started.

- Setup a Firebase Project for your own and use that `google-services.json`

OR

- Ask one of the contributors to add your SHA-1 Key to the Firebase Console.

  > _[How to get the SHA-1 Key ?](https://stackoverflow.com/questions/15727912/sha-1-fingerprint-of-keystore-certificate)_

- Run the app.

```bash
flutter run
```

### Startup

YouOweMe uses [Device Preview](https://pub.dev/packages/device_preview) to
build and to visualise how the app will look
on different devices.

On First Debug Run you will find a such a layout:

![screenshot](https://user-images.githubusercontent.com/27439197/76833208-efea3f00-6850-11ea-867a-231a47072f50.png)

This applicaiton used Artemis for graphql code generation.

To update the schema get the latest form the [API](https://youoweme-6c622.appspot.com/),
and update the file located at `lib/resources/graphql/youoweme.schema.graphql`

### Code Generator For Artemis.

When you update / add a new GraphQl Query run this to generate dart
types

```bash
flutter pub run build_runner build
```

### Run Import Sorter

```bash
flutter pub run import_sorter:main
```

### Add New Queries / Mutation / Subscriptions

Add them to their respective folders under

`lib/resources/graphql/`

### Add missing files in code.

Run this very carefully so it does not mess up some
OS level configuration.

```bash
flutter create . --org dev.preetjdp youoweme
```

### How to update the icon

```bash
flutter pub run flutter_launcher_icons:main
```

## KeyTool options

`Password => q^iB07QT`

## Get Sha Key from key.jks

```bash
keytool -list -v -keystore {filePath} -alias {key-alias}
Example:
keytool -list -v -keystore ./android/app/key.jks -alias key
```

## Launch url on the phone.

```bash
adb shell am start -a android.intent.action.VIEW -d https://youoweme.page.link/oNL2
```
