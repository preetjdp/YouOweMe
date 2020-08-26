// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:YouOweMe/resources/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:basics/basics.dart';
import 'package:http/http.dart';

// 🌎 Project imports:
import 'package:YouOweMe/ui/IOwe/iOwePage.dart';
import 'package:YouOweMe/ui/NewOwe/newOwe.dart';
import 'package:YouOweMe/ui/OweMe/oweMePage.dart';
import 'package:YouOweMe/ui/Abstractions/yomBottomSheet.dart';
import 'package:YouOweMe/ui/DynamicLinkBottomSheet/dynamicLinkBottomSheet.dart';
import 'package:YouOweMe/ui/HomePage/homePage.dart';

/// This configures the bottom navbar
/// on android.
void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color.fromRGBO(241, 245, 249, 1),
      systemNavigationBarIconBrightness: Brightness.dark));
}

/// Fetch the GraphQL Client using the User's userId
/// which will be used for authorization.
Future<GraphQLClient> getGraphqlClient(String userId) async {
  final HttpLink httpLink =
      HttpLink(uri: await getSevaUrl(), headers: {"authorization": userId});

  return GraphQLClient(
    cache: InMemoryCache(),
    link: httpLink,
  );
}

/// Get the desired `Seva` url depending upon
/// the state of the application.
Future<String> getSevaUrl(
    {Duration timoutDuration = const Duration(seconds: 2)}) async {
  if (kReleaseMode || kProfileMode) {
    print("Using Production Seva In Release");
    return productionSevaUrl;
  }
  try {
    Response response = await get(localSevaUrl).timeout(timoutDuration);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("Using Local Seva");
      return localSevaUrl;
    } else {
      throw "Could Not Connect to Local Seva";
    }
  } catch (e) {
    print("Using Production Seva" + e.toString());
    return productionSevaUrl;
  }
}

/// Set's up Firebase Messenging for the current user.
/// Returns the Token that is generated.
Future<String> configureFirebaseMessenging() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  String token = await _firebaseMessaging.getToken();
  if (token.isNull) {
    return null;
  }
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  return token;
}

/// Returns the appropriate suffix for the
/// day.
String getDayOfMonthSuffix(final int n) {
  if (n >= 11 && n <= 13) {
    return "th";
  }
  switch (n % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

/// Configure Firebase dynamic links.
/// Set's up boilerplate to Navigate on NewLink.
/// TODO Make a tested function to get the Owe / OweID from the url.
Future<void> configureFirebaseDynamicLinks(BuildContext context) async {
  PendingDynamicLinkData linkData =
      await FirebaseDynamicLinks.instance.getInitialLink();

  if (linkData.isNotNull) {
    Uri link = linkData.link;
    String oweId = link.pathSegments[1];
    showYomBottomSheet(
        context: context,
        builder: (BuildContext context, ScrollController scrollController) =>
            DynamicLinkBottomSheet(oweId: oweId));
  }

  FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData linkData) {
    Uri link = linkData.link;
    String oweId = link.pathSegments[1];
    showYomBottomSheet(
        context: context,
        builder: (BuildContext context, ScrollController scrollController) =>
            DynamicLinkBottomSheet(oweId: oweId));
    return;
  });
}

/// Generates the routeGenerator for the entire Application.
Route<dynamic> routeGenerator(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case "i_owe_page":
      {
        return MaterialWithModalsPageRoute(
            settings: settings, builder: (context) => IOwePage());
      }
    case "owe_me_page":
      {
        return MaterialWithModalsPageRoute(
            settings: settings, builder: (context) => OweMePage());
      }
    case "new_owe_page":
      {
        return MaterialWithModalsPageRoute(
            settings: settings, builder: (context) => NewOwe());
      }
    default:
      {
        return MaterialWithModalsPageRoute(
            settings: settings, builder: (context) => HomePage());
      }
  }
}

/// Returns a serialized PhoneNumber that starts with "+91".
String serializePhoneNumber(String phoneNumber) {
  String spacesRemoved = phoneNumber.replaceAll(" ", "");
  if (spacesRemoved.contains(new RegExp(r"^(\+91)[789]\d{9}$"))) {
    return spacesRemoved;
  } else {
    return "+91" + spacesRemoved;
  }
}
