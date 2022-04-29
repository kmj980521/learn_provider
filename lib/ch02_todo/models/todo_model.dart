import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid(); // 유니크한 아이디

class Todo extends Equatable {
  final String id;
  final String desc; // 내용
  final bool completed;

  // id는 null값이 될 수도 있고, null이면 uuid로 새로 만듦.
  // completed의 default 값은 false
  Todo({String? id, required this.desc, this.completed = false})
      : id = id ?? uuid.v4();

  @override
  List<Object> get props => [id,desc,completed];

  @override
  bool get stringify => true;
}

enum Filter {
  all,
  active,
  completed,
}
