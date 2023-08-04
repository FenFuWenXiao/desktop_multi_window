//
//  SharedPreferencesPluginOrigin.swift
//  desktop_multi_window
//
//  Created by CJ on 2023/3/25.
//

import Foundation
import FlutterMacOS
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif



private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol UserDefaultsApi {
  func remove(key: String) throws
  func setBool(key: String, value: Bool) throws
  func setDouble(key: String, value: Double) throws
  func setValue(key: String, value: Any) throws
  func getAllWithPrefix(prefix: String) throws -> [String?: Any?]
  func clearWithPrefix(prefix: String) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class UserDefaultsApiSetup {
  /// The codec used by UserDefaultsApi.
  /// Sets up an instance of `UserDefaultsApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: UserDefaultsApi?) {
    let removeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.remove", binaryMessenger: binaryMessenger)
    if let api = api {
      removeChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        do {
          try api.remove(key: keyArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      removeChannel.setMessageHandler(nil)
    }
    let setBoolChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setBool", binaryMessenger: binaryMessenger)
    if let api = api {
      setBoolChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Bool
        do {
          try api.setBool(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setBoolChannel.setMessageHandler(nil)
    }
    let setDoubleChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setDouble", binaryMessenger: binaryMessenger)
    if let api = api {
      setDoubleChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1] as! Double
        do {
          try api.setDouble(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setDoubleChannel.setMessageHandler(nil)
    }
    let setValueChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.setValue", binaryMessenger: binaryMessenger)
    if let api = api {
      setValueChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let keyArg = args[0] as! String
        let valueArg = args[1]
        do {
          try api.setValue(key: keyArg, value: valueArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setValueChannel.setMessageHandler(nil)
    }
    let getAllWithPrefixChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.getAllWithPrefix", binaryMessenger: binaryMessenger)
    if let api = api {
      getAllWithPrefixChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let prefixArg = args[0] as! String
        do {
          let result = try api.getAllWithPrefix(prefix: prefixArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getAllWithPrefixChannel.setMessageHandler(nil)
    }
    let clearWithPrefixChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.UserDefaultsApi.clearWithPrefix", binaryMessenger: binaryMessenger)
    if let api = api {
      clearWithPrefixChannel.setMessageHandler { message, reply in
        let args = message as! [Any]
        let prefixArg = args[0] as! String
        do {
          try api.clearWithPrefix(prefix: prefixArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      clearWithPrefixChannel.setMessageHandler(nil)
    }
  }
}


public class SharedPreferencesPluginOriginal: NSObject, FlutterPlugin, UserDefaultsApi {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SharedPreferencesPluginOriginal()
    // Workaround for https://github.com/flutter/flutter/issues/118103.
#if os(iOS)
    let messenger = registrar.messenger()
#else
    let messenger = registrar.messenger
#endif
    UserDefaultsApiSetup.setUp(binaryMessenger: messenger, api: instance)
  }

  func getAllWithPrefix(prefix: String) -> [String? : Any?] {
    return getAllPrefs(prefix: prefix)
  }

  func setBool(key: String, value: Bool) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setDouble(key: String, value: Double) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func setValue(key: String, value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }

  func remove(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
  }

  func clearWithPrefix(prefix: String) {
    let defaults = UserDefaults.standard
    for (key, _) in getAllPrefs(prefix: prefix) {
      defaults.removeObject(forKey: key)
    }
  }

  /// Returns all preferences stored with specified prefix.
  func getAllPrefs(prefix: String) -> [String: Any] {
    var filteredPrefs: [String: Any] = [:]
    if let appDomain = Bundle.main.bundleIdentifier,
      let prefs = UserDefaults.standard.persistentDomain(forName: appDomain)
    {
      for (key, value) in prefs where key.hasPrefix(prefix) {
        filteredPrefs[key] = value
      }
    }
    return filteredPrefs
  }
}
