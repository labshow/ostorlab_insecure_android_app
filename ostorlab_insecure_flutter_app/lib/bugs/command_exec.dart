import 'package:ostorlab_insecure_flutter_app/bug_rule.dart';
import 'dart:io';

/// A [BugRule] that triggers the execution of arbitrary commands in a Flutter app.
class CommandExec extends BugRule {
  /// The tag used to identify instances of this rule.
  static const String _tag = 'CommandExec';

  /// Trigger the [BugRule]
  @override
  Future<void> run() async {
    String domainName = "google.com";
    String fileName = "ostorlab.bin";
    String command;

    // command contains chmod
    command = "chmod 777 $fileName";
    await executeCommand(command, "/sdcard");

    //command executed on sdcard
    command = "ping -c 3 $domainName";
    await executeCommand(command, "/sdcard/ostorlab");
  }

  /// Execute a command with optional working directory.
  ///
  /// * [command] the command to execute.
  /// * [pathName] the optional path to set as the working directory for the command.
  Future<void> executeCommand(String command, String pathName) async {
    try {
      var file = pathName != null ? Directory(pathName) : null;
      var process = Process.runSync(command, [], workingDirectory: file?.path);
      print(process.stdout);
    } catch (e) {
      print(e);
    }
  }

  /// Returns a description of this [BugRule] implementation.
  @override
  String getDescription() {
    return "The application executes commands";
  }
}
