# TODO

![image](https://user-images.githubusercontent.com/61898890/165878504-f8456a45-0853-4c10-9f79-5e177a39ae94.png)


## 1. Provider를 효율적이게 사용하는 방법
1. State는 가급적 atomic 하게 만든다. 논리적으로 분리할 수 있으면 별도의 state로 만들어서 관리
2. State는 주로 class 형태로 관리하고 논리적으로 연관된 값들을 묶어서 관리한다. 또한, String, int 등 primitive type 변수도 class화 해서 관리해 type 충돌을 피한다.
3. Immutable state를 만들고 copyWith 함수를 사용해 새로운 state를 만든다.
4. Awlays extends Equatable class를 만들어 Object instance들의 equality check를 쉽게 하고 stringify 등의 편의 함수를 제공한다.

## 2. 단순한 스트링도 클래스로 관리하는 이유
- 1. 모든 State를 다루는 데에 있어서 일관성을 다룰 수 있다. 
- 2. 타입의 충돌을 피할 수 있다. 

```dart

class TodoSearchState extends Equatable{
  final String searchTerm;

  TodoSearchState({ required this.searchTerm});

  factory TodoSearchState.initial(){
    return TodoSearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({String? searchTerm}){
    return TodoSearchState(searchTerm: searchTerm ?? this.searchTerm);
  }

}

```

## 3. Stringify
- true를 설정함으로써 debug를 유용하게 할 수 있다. 

![image](https://user-images.githubusercontent.com/61898890/165887366-612b3c74-ebe4-4afd-b24e-b63a92f5d45a.png)






























































