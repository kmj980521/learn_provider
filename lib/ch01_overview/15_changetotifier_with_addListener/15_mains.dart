import 'package:flutter/material.dart';
import 'package:learn_provider/ch01_overview/15_changetotifier_with_addListener/app_provider.dart';
import 'package:learn_provider/ch01_overview/15_changetotifier_with_addListener/success_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'addListener of ChangeNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled; // state가 바뀔 때까지 입력 x
  String? searchTerm;
  late final AppProvider appProv;

  @override
  void initState() {
    super.initState();
    appProv = context.read<AppProvider>();
    appProv.addListener(appListener);
  }

  void appListener() {
    if (appProv.state == AppState.success) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SuccessPage();
      }));
    } else if (appProv.state == AppState.error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Somethig went wrong'),
          );
        },
      );
    }
  }

  void submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always; // 한번 제출되고 나면 validatemode on
    });
    final form = formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();
    context.read<AppProvider>().getResult(searchTerm!);
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return SuccessPage();
    // }));
    //
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       content: Text('Somethig went wrong'),
    //     );
    //   },
    // );
    //   try {
    //     await context.read<AppProvider>().getResult(searchTerm!);
    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       return SuccessPage();
    //     }));
    //   } catch (e) {
    //     showDialog(
    //         context: context,
    //         builder: (context) {
    //           return AlertDialog(
    //             content: Text('Somethig went wrong'),
    //           );
    //         },
    //     );
    //   }
    // }
  }

  @override
  void dispose() {
    appProv.removeListener(appListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppProvider>().state;
    // if (appState == AppState.success) {
    //   WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) {
    //             return SuccessPage();
    //           },
    //         ),
    //       );
    //     },
    //   );
    // } else if (appState == AppState.error) {
    //   WidgetsBinding.instance!.addPostFrameCallback((_) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           content: Text('Somethig went wrong'),
    //         );
    //       },
    //     );
    //   });
    // }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              autovalidateMode: autovalidateMode,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Search'),
                      prefixIcon: Icon(Icons.search),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Search term required';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      searchTerm = value;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: Text(
                      appState == AppState.loading
                          ? 'Loading...'
                          : 'Get Result',
                      style: TextStyle(fontSize: 24.0),
                    ),
                    onPressed: appState == AppState.loading ? null : submit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
