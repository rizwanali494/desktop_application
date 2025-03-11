import 'package:desktop_application/core/routes/app_routes.dart';
import 'package:desktop_application/register_globle_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(428, 930),
      minTextAdapt: true,
      child: MultiProvider(
        providers: registerGlobalNotifiers(),
        child: MaterialApp.router(
          onNavigationNotification: (_) => true,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          builder: (context, child) {
            return LoaderOverlay(
              overlayWidgetBuilder: (_) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(30.r),
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
              child: child ?? Container(),
            );
          },
        ),
      ),
    );
  }
}