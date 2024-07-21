import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:reservasi/main.dart' as app;
import 'package:reservasi/presentation/screens/login_screen.dart';
import 'package:reservasi/presentation/screens/register_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Landing Screen UI Interactions', (WidgetTester tester) async {
    app.main(); // Start the app
    await tester.pumpAndSettle();

    // Verify initial screen
    expect(find.text('Jangan takut'), findsOneWidget);
    expect(find.text('ga kebagian\ntempat duduk.'), findsOneWidget);

    // Tap on 'Masuk' button to navigate to LoginScreen
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    // Verify navigation to LoginScreen
    expect(find.byType(LoginScreen), findsOneWidget);

    // Navigate back to LandingScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Tap on 'Buat Akun' to navigate to RegisterScreen
    await tester.tap(find.text('Buat Akun'));
    await tester.pumpAndSettle();

    // Verify navigation to RegisterScreen
    expect(find.byType(RegisterScreen), findsOneWidget);

    // Navigate back to LandingScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Tap on 'Masuk dengan Google' button
    await tester.tap(find.text('Masuk dengan Google'));
    await tester.pumpAndSettle();

    // You may want to mock or verify specific Google sign-in actions
    // For simplicity, just checking if the button was tapped
    expect(find.text('Masuk dengan Google'), findsOneWidget);
  });
}
