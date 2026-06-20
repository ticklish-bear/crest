# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# flutter_local_notifications uses Gson + reflection to (de)serialize the
# scheduled-notification payloads. Without these keeps, R8 strips the classes
# and scheduled reminders silently fail in release builds.
-keep class com.dexterous.** { *; }
-keep class com.google.gson.** { *; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Flutter's embedding references Play Core (deferred components / SplitCompat),
# which Crest does not use and does not bundle. Tell R8 not to fail on the
# missing references.
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Keep generic type information used by Gson via TypeToken.
-keep class * extends com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken
