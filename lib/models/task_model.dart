import 'package:hive/hive.dart';
part 'task_model.g.dart';
@HiveType(typeId: 1)
class task_model{
  @HiveField(0)
  late String task_text ;
task_model(this.task_text);
}