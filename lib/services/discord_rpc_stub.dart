/// Web build stand-in for [DiscordRpc]: flutter_discord_rpc needs a native library and a local Discord client.
class DiscordRpc {
  static void initialize() {}

  static Future<void> stop({bool force = false}) async {}

  static Future<void> updateRPC() async {}
}
