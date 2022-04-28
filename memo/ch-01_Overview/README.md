# Provider Overview

## 1. 프로바이더? 
- 상태관리 (State Management)

- 위젯트리상 불필요한 Inversion of control(함수는 정의하지만 실행은 다른 위젯에서 실행하는 현상)이 많아진다. 


```dart

 Provider({
    Key? key,
    required Create<T> create, 
    Dispose<T>? dispose,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  })

```

- create에 전달하는 함수가 return 하는 오브젝트르 하위 위젯들이 접근 가능하다.

---

## 2. Provider 없이 state를 관리
- 굉장히 불필요하게 값을 전달해줘야 한다.
- 위젯트리가 깊어질수록 불필요하고 어느 위젯에서 값을 바꾸었는지 알 수가 없다.

---

## 3. Dependency Injection
- 오브젝트를 위젯트리 상에서 쉽게 엑세스 하게 해주는 것 
- **BLOC : Business LOgic Component**

- 공통적으로 속한 Ancestor 위젯에 Provider를 생성
- Provider 또한 위젯

- `${Provider.of<Dog>(context).name}` : context를 받아 상위 위젯으로 올라가며, Provider에서 Dog 타입의 인스턴스를 찾고 프로퍼티를 가져온다

- `Provider.of<Dog>(context, listen: false).grow();` : 버튼은 어떤 값이 변한다고 해도 다시 그려질 필요가 없으니 listen : false를 줘서 rebuild를 막는다

---

## 4. ChangeNotifier
- A class that can be extended or mixed in that provides a change notification API using VoidCallback for notofication

- `notifyListeners(); ` : ChangeNotifier 내의 데이터에 변동이 생겼을 때 ChangeNotifier를 Listen하고 있는 모든 오브젝트에 변동사항을 알려준다.
- `addListener( (){} ) ` : notifyListeners()가 호출되면 실행할 함수 
- Listener는 자동으로 dispose 되지 않기 때문에 수동으로 dispose 해주어야 한다. `removeListener()`

![image](https://user-images.githubusercontent.com/61898890/165437487-6819e630-82fb-4004-8420-53b23eb7006c.png)

- ChangeNotifier를 사용하면 인스턴스를 전달해줘야 하고, UI를 수동으로 그려줘야 하는 불편함이 있다.

- 이걸 해소하기 위해 나온 것이 **changeNotifierProvider**

![image](https://user-images.githubusercontent.com/61898890/165440168-8408b328-1a18-4254-bfec-78d59da21d20.png)


---

## 5. ChangeNotifierProvider
- 1. Create an instance of ChangeNotifier
- 2. Provide an easy way to access ChangeNotifier for widgets that need it, and rebuilds the UI if necessary

---

## 6. extension methodes
### 1) read
-  ` context.read<T>() -> T ` 
- Obtain a value from the nearese ancestor provider of type T : 가장 가까운 T 타입의 프로바이더를 찾는다.
- `Provider.of<T>(context,listen: false)`
- 값을 읽어오기만 하고, Nofitifier를 호출하는 코드가 있어야 다시 rebuild를 진행한다.
- 변화를 listen하지 않는다. 

### 2) watch
- `context.watch<T>() -> T `
- Obtain a value from the nearest ancestor provider of type T, and subscribe to the provider : 가장 가까운 T 타입의 프로바이더를 return 하고, value change를 listen한다.
- `Provider.of<T>(context)` 
- **오브젝트 중 하나의 내용이라도 변하면 전체가 rebuild**
- rebuild 하고자 하는 widget에서는 watch를 사용한다.

### 3) select 
- `context.select<T,R>(R selecttor(T value)) -> R`
- Watch a value of type T exposed from a provider, and listen only partially to changes  : 프로퍼티를 많이 가지고 있는 오브젝트의 특정 프로퍼티의 변화만 listen하고 싶을 때  사용
- listen 하고 싶은 것만 선별적으로 listen
- `context.select<Dog, String> ((Dog dog) => dog.name) : name이 변할 때만 rebuilding

---


## 7. MultiProvider

![image](https://user-images.githubusercontent.com/61898890/165442246-b3f5ca1a-68d7-4b2c-9fb6-02b98a4b87ed.png)

---

## 8. FutureProvider 
- 연속된 값으로 계속 리빌드 할 때는 Stream이 나을 수도 있다
- Future에 대해 try~catch를 작성

```dart

FutureProvider(
 Key? key,
 required Create<Future<T>?> create,
 required T initialData
),

```
- FutureProvider는 Future의 return value를 타입으로 가진다. 작성한 코드에서는 Future<int> 타입 
 
 
 
 
---

## 9. StreamProvider
 
 
 ```dart
 StreamProvider(
 Key? key,
 required Create<Future<T>?> create,
 required T initialData
),
```

- 만약 Provider에서 create에서 다른 데이터를 watch로 읽어와 사용한다면? `Tried to listen to an InheritedWidget in a life-cycle that will never be called again.` 에러 발생
- creat는 한 번만 호출되기 때문에 논리적으로도 맞지 않다


--- 
 
 
## 10. Consumer
- Obtains Provider<T> from its ancestors and passes its value to builder 
- The Consumer widget doesn't do any fancy work. it just class Provider.of in a new widget and delegats its build implementation to builder : 새로운 위젯에서 Provider.of를 호출하고 위젯의 build 구현을 builder에 위임한다 
- builder must not be null and may be called multiple times(such as when the provided value changes) 
- 모든 위젯을 새로 그린다? -> builder에 Nullable한 파라미터가 있어 특정 위젯을 build에서 제외시킬 수 있다. 
 
```dart
 
 Consumer(
  Key? key,
  required Widget builder(BuildContext context, T value, Widget? child),
 }
 
``` 
 


```dart

Consumer<Dog4>(
        builder: (BuildContext context, Dog4 dog, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                child!,
                SizedBox(height: 10.0,),
                Text(
                  '- name: ${dog.name}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                BreedAndAge(),
              ],
            ),
          );
        },
        child: Text(
          'I like dogs very much',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
 
```

- child를 직접 지정해줌으로써 rebuild를 방지한다. Column 내에 Provider.of와는 무관한 위젯들이 있을 때 rebuild를 방지하기 위해 사용한다. 

---
 
 
## 11. ProviderNotFoundException
 
 ```
 
 Error : Could not find the correct Provider<T> above this MyHomePage Widget
 
 This happends because you used a 'BuildContext' that does not inclue the provider of your choice. There are a few common scenarios:
 
 - You added a new provider in your `main.dart` and performed a hot-reload.
  To fix, perform a hot-restart.  : 핫 리로드시 프로바이더를 추가할 경우 
  
- The provider you are trying to read is in a different route. : 다른 route에서 프로바이더의 값을 read할 경우 

  Providers are "scoped". So if you insert of provider inside a route, then
  other routes will not be able to access that provider.

- You used a `BuildContext` that is an ancestor of the provider you are trying to read. : 프로바이더를 사용해 상위 ancestor를 read하기 위해 BuildContext 과정을 진행한다.

  Make sure that MyHomepage is under your MultiProvider/Provider<Foo>.
  This usually happens when you are creating a provider and trying to read it immediately.
 
 ----
 
 For example, instead of:


  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // Will throw a ProviderNotFoundError, because `context` is associated
      // to the widget that is the parent of `Provider<Example>`
      child: Text(context.watch<Example>()),
    ),
  }


  consider using `builder` like so:


  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // we use `builder` to obtain a new `BuildContext` that has access to the provider
      builder: (context) {
        // No longer throws
        return Text(context.watch<Example>()),
      }
    ),
  }

 
 
 
``` 

- 근본적으로 Builder와 Consumer는 비슷해서 서로 공용해 사용할 수 있다.




---

## 12. Selector
 
- Consumer보다 더 세세한 처리를 할 수 있다. 
 
- An equivalent to Consumer that can filter updates by selecting a limited amount of values and prevent rebuild if they don't change.
 
```dart
 
 Selector({
  Key? key,
  required ValueWidgetBuilder<S> builder,
  required S selector(BuildContext, A),
  ...
 })
 
``` 
- `Selector<오브젝트 타입, 그 중 선택할 프로퍼티 타입> () `


```dart
 
@override
  Widget build(BuildContext context) {
    return Selector<Dog4, int>(                                     // Dog4 클래스에서 int 타입의 프로퍼티를 선택 
      selector: (BuildContext context, Dog4 dog)=>dog.age,          // Dog4 dog를 찾고, dog의 age를 return. 
        builder: (_, int age, __) {                                 // builder에서 age를 사용
          return Column(
            children: [
              Text(
                '- age: ${age}',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(onPressed: () {
                context.read<Dog4>().grow();                         // grow()는 다시 찾아서 사용해야 하니 read를 사용
              }, child: Text('Grow', style: TextStyle(fontSize: 20.0),))
            ],
          );
        });
  }
 
``` 
 
---
 
 
## 13. ProviderNotFoundException 더 알아보기 및 Builder widget

- extesion 메소드에 전달되는 context는 Build 함수의 context일 수가 있으니, 상위 위젯으로 가서 찾기 위해서는 Builder를 사용한다. 

- Widget를 분리해서 build를 실행 시키거나, 내부에서 Builder를 이용해서 사용한다.


----
 
## 14. Provider Access - Anonymous route access 
 
 - **.value** constructor usage is closely related to "Provider Access" : 새로운 subtree에 이미 존재하는 클래스에 대한 access를 제공

- Navigator.push()는 child widget 생성이 아닌 새로운 위젯트리 생성이다. 

- 자동으로 close 하지 않는다.



``` dart
 
 MaterialPageRoute(builder: (counterContext) {
                    return ChangeNotifierProvider.value(
                      value: context.read<Counter>(),
                      child: ShowMeCounter(),
                    );
                  }),
 
``` 
- value에서 사용해야 하는 context는 현재 페이지의 context에서 찾아야 하는데, MaterialPageRoute의 builder의 context를 context라고 하면 덮어버리니 올바른 값을 전달할 수가 없어서 다른 이름으로 준다.


## 15. Provider NamedRoute
 
 ```dart
 
 final Counter _counter = Counter(); // Counter는 ChangeNotifier
 
 routes: {
        '/': (context) => ChangeNotifierProvider.value(value: _counter,child: MyHomePage()),
       '/counter': (context) => ChangeNotifierProvider.value(value: _counter ,child: ShowMeCounter()),
     },
 
 ```
- 클래스에서 final로 특정 인스턴스를 생성해주고, route에 있는 위젯을 `ChangeNotifierProvider.value()`로 감싸고 인스턴스를 value로 전달한다. 
- 예시로 작성한 Counter는 ChangeNotifier인데, ChangeNotifierProvider를 통하지 않고 생성했기 때문에 자동으로 해제가 되지 않아 dispose()에서 삭제를 해준다.
 

## 16. Generate route access, Global access

```dart
 
 onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: _counter,
                child: MyHomePage(),
              ),
            );
          case '/counter':
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: _counter,
                child: ShowMeCounter(),
              ),
            );
          default:
            return null;
        }
      },

 ```

 - Global Access는 제일 상위 위젯을 Provider로 감싸는 것을 의미한다. 그러나 앱이 커진다면 이것은 바람직하지 않다.

 
 ## 17. ProxyProvider 
 - 어떤 프로바이더에서 다른 프로바이더의 값이 필요하다면?
 - ` A provider that builds a value based on other providers`
 
 ```dart
 
 ProxyProvider({
  Key? key,
  Create<R>? create,
  required ProxyProviderBuilder<T,R> update,
  UpdateShouldNotify<R>? updateShouldNotify,
  Dispose<R>? dispose,
  bool? lazy,
  TransitionBuilder? builder,
  Widget? child,
 })
 

 ```
 
 - ProxyProvider가 순전히 값에만 의존해서 새로운 value를 만드는 경우가 있기 때문에 create는 nullable, update는 여러 번 호출하기 때문에 required
 - 자기가 핸들링 해야 할 별도의 Object가 있고 그 Object의 Value 중 일부 또는 전체가 다른 Provider에 의존한다면 Create를 통해 핸들링 할 Object를 만들어서 사용한다.

 
 ### 언제 update가 일어나는가
 - 1. When ProxyProvider first obtains the value of the provider it depends on : ProxyProvider가 의존하는 값을 처음으로 획득했을 때 
 - 2. When the value of the provider that ProxyProvider depends on changes : ProxyProvider가 의존하는 Provider 값이 바뀔 때 
 - 3. Whenever ProxyProvider rebuilds : ProxyProvider가 rebuild될 때마다
 
 ### update callback
 
 ```dart
 
 typedef ProxyProviderBuilder<T,R> = R Function(
  Buildcontext context,
  T value,
  R? previous,
 )
 
 ```
 
 ### ProxyProviderN
 - N : from None to 6
 
 - ProxyProvider<A,Result> is equal to ProxyProvider0<Result>
 
 ### ChangeNotifierProxyProvider

 -  외부 ChangeNotifier와 값을 synchronize 한다.
 
 ![image](https://user-images.githubusercontent.com/61898890/165723813-616c0222-c9b3-477e-a208-3e6d99901bf2.png)

 - Don't create the ChangeNotifier inside update directly : ChangeNotifier를 직접적으로 만들지 마라.
 - -> 의존하고 있는 값이 업데이트 될 때 state가 lost 될 수 있다. 
 - -> ChangeNotifier안에 async가 있는데 이걸 기다리는 동안 update가 되면 잘못된 데이터를 통한 update가 이뤄진다. 
 
 ![image](https://user-images.githubusercontent.com/61898890/165724526-d67afa73-d257-4f63-bb13-26bf5db6edc8.png)

 - create된 Object가 HTTP 호출이나, 다른 유사 side effect 없이 다른 object들에 combination으로만 이루어진다면, **ProxyProvider를 사용해 immutable한 object** 를 만들어 사용한다. 
 
 
 
 
 ## 18. ProxyProvider 예제
 
 ### update / create를 사용했을 때
 
 ```dart
 
 class Translations {
  late int _value;

  void update(int newValue) {
    _value = newValue;
  }

  String get title => 'You clicked $_value times';
}
 
 
 ProxyProvider0<Translations>(
          create: (_) => Translations(),
          update: (_, Translations? translations) {
            translations!.update(counter);
            return translations;
          },
 
 ```
 
 ### update만을 사용했을 때 
 
 ```dart
 
 class Translations {
  const Translations(this._value);
  final int _value;

  String get title => 'You clicked $_value times';
}
 
 
 ProxyProvider0<Translations>(
          update: (_, __) => Translations(counter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShowTranslations(),
              SizedBox(height: 20.0),
              IncreaseButton(increment: increment),
            ],
          ),
        ),
 
 
 ```
 
## 19. Provider의 에러
 
### 1. ProviderNotFound Exceptiuon
 - 새로운 프로바이더를 생성하고 hot reload를 하거나, buildcontext 위치가 옳지 않거나, 다른 route에서 provider를 읽을 때.
 
### 2. Tried to listen to a value exposed with provider
 - provider.watch<T>() 를 사용할 때 자주 발생하는 에러 
 - provider.of()를 호출할 때 listen : false를 하거나, read()를 사용한다. 
 
 
 
## 19-1 Page rendering process of StatefulWidget 
 1. Create an element (BuildContext)
 2. initState
 3. didChangeDependencies
 4. Build
 
 ![image](https://user-images.githubusercontent.com/61898890/165745349-a0860f15-f164-40b1-ac06-27f2e75ab60c.png)

 - initState 전에 build를 하라는 에러가 많이 발생해 state management를 사용한다면 showDialog, showSnackBar로 따리 처리해준다.
 
 ### ** addPostFrameCallback **
 
 
 ```dart
 
 WidgetsBinding.instance!.addPostFrameCallback((Duration timestamp) { 
 // Do something
 });
 
 ```
 - 현재 Frame이 완성된 후, 등록된 callback을 실행시킨다. 
 
 
 ```dart
 
 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<Counter>().increment();
      myCounter = context.read<Counter>().counter + 10;
    });
    // Future.delayed(Duration(seconds: 0), () {
    //   context.read<Counter>().increment();
    //   myCounter = context.read<Counter>().counter + 10;
    // });
    // Future.microtask(() {
    //   context.read<Counter>().increment();
    //   myCounter = context.read<Counter>().counter + 10;
    // });
  }
 
 ```
 
 ## 20. ChangeNotifier addListener
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
