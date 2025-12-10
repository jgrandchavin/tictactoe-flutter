import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gaimon/gaimon.dart';
import 'package:tictactoe_flutter/core/utils/logger.dart';

/// Centralized haptics helper for consistent feedback across the app.
class HapticsUtils {
  HapticsUtils._();

  /// Global toggle to enable/disable advanced haptics.
  static bool hapticFeedbackEnabled = true;

  static Future<void> light() async {
    if (!hapticFeedbackEnabled) return;
    await HapticFeedback.lightImpact();
  }

  /// Gentle feedback for a valid, normal action (e.g., placing a move).
  static Future<void> move() async {
    if (!hapticFeedbackEnabled) return;
    await HapticFeedback.lightImpact();
  }

  /// Stronger feedback for an invalid action (e.g., tapping an occupied cell).
  static Future<void> invalidMove() async {
    if (!hapticFeedbackEnabled) return;
    await HapticFeedback.mediumImpact();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.lightImpact();
  }

  /// Brief feedback for a draw/end with no winner.
  static Future<void> draw() async {
    if (!hapticFeedbackEnabled) return;
    await HapticFeedback.selectionClick();
  }

  /// Subtle feedback for starting a new game or resetting.
  static Future<void> startNewGame() async {
    if (!hapticFeedbackEnabled) return;
    await HapticFeedback.selectionClick();
  }

  /// Custom haptic for a short cell appear effect (~800ms).
  static Future<void> win() async {
    try {
      if (!hapticFeedbackEnabled) return;
      final haptic = {
        "Version": 1,
        "Pattern": [
          {
            "Event": {
              "Time": 0.0,
              "EventType": "HapticContinuous",
              "EventDuration": 0.45,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.4},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.3},
              ],
            },
          },
          {
            "Event": {
              "Time": 0.45,
              "EventType": "HapticContinuous",
              "EventDuration": 0.45,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.2},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15},
              ],
            },
          },
        ],
      };
      Gaimon.patternFromData(json.encode(haptic));
    } catch (error, trace) {
      log.e(
        'Failed to play appear haptic feedback',
        error: error,
        stackTrace: trace,
      );
    }
  }

  /// Custom haptic for a longer celebration effect (e.g., victory sequence).
  static Future<void> celebration() async {
    try {
      if (!hapticFeedbackEnabled) return;
      final haptic = {
        "Version": 1,
        "Pattern": [
          {
            "Event": {
              "Time": 0.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2},
              ],
            },
          },
          {
            "Event": {
              "Time": 2.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15},
              ],
            },
          },
          {
            "Event": {
              "Time": 3.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2},
              ],
            },
          },
          {
            "Event": {
              "Time": 5.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15},
              ],
            },
          },
          {
            "Event": {
              "Time": 6.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2},
              ],
            },
          },
          {
            "Event": {
              "Time": 8.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15},
              ],
            },
          },
          {
            "Event": {
              "Time": 9.0,
              "EventType": "HapticContinuous",
              "EventDuration": 2.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.35},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.2},
              ],
            },
          },
          {
            "Event": {
              "Time": 11.0,
              "EventType": "HapticContinuous",
              "EventDuration": 1.0,
              "EventParameters": [
                {"ParameterID": "HapticIntensity", "ParameterValue": 0.25},
                {"ParameterID": "HapticSharpness", "ParameterValue": 0.15},
              ],
            },
          },
        ],
      };
      Gaimon.patternFromData(json.encode(haptic));
    } catch (error, trace) {
      log.e(
        'Failed to play celebration haptic feedback',
        error: error,
        stackTrace: trace,
      );
    }
  }
}
