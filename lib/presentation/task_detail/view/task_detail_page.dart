import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/presentation/task_detail/bloc/task_detail_cubit.dart';
import 'package:flavoring/presentation/task_detail/view/widget/widget_barrel.dart';
import 'package:flavoring/utils/validator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavoring/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskEntity task;

  const TaskDetailPage({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TextEditingController titleController;
  late TextEditingController noteController;
  late TextEditingController deadlineController;
  late TaskDetailCubit cubit;
  @override
  void initState() {
    titleController = TextEditingController(text: widget.task.title);
    noteController = TextEditingController(text: widget.task.note);
    deadlineController = TextEditingController(
        text: widget.task.deadline.fromEpoch().toDisplayString());
    cubit = context.read<TaskDetailCubit>();

    super.initState();

    cubit.init(widget.task);
    titleController.addListener(() {
      cubit.changeTitle(titleController.text);
    });

    noteController.addListener(() {
      cubit.changeNote(noteController.text);
    });

    deadlineController.addListener(() {
      cubit.changeDeadline(deadlineController.text);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildTitleField(),
              const SizedBox(height: 20),
              _buildDeadlineField(),
              const SizedBox(height: 20),
              _buildNoteField(),
              const SizedBox(height: 20),
              BlocBuilder<TaskDetailCubit, TaskDetailState>(
                buildWhen: (previous, current) =>
                    previous.newState != current.newState,
                builder: (context, state) {
                  return WidgetSwitch(
                    title: 'Hoàn thành',
                    value: state.newState!.isDone,
                    onTap: () => cubit.changeIsDoneStatus(widget.task.id),
                  );
                },
              ),
              BlocBuilder<TaskDetailCubit, TaskDetailState>(
                buildWhen: (previous, current) =>
                    previous.newState != current.newState,
                builder: (context, state) {
                  return WidgetSwitch(
                    title: 'Nhận thông báo',
                    value: state.newState!.isReceiveNotification,
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildNoteField() {
    return WidgetTextField(
      hintText: 'Ghi chú',
      maxLine: 3,
      controller: noteController,
    );
  }

  _buildDeadlineField() {
    return WidgetDatePicker(
      minimumDate: DateTime.now(),
      hintText: 'Hạn chót',
      controller: deadlineController,
      pickerMode: CupertinoDatePickerMode.dateAndTime,
      validator: (value) {
        if (ValidatorUtils.validateEmpty(value)) {
          return 'Chọn hạn chót';
        }
        return null;
      },
    );
  }

  _buildTitleField() {
    return WidgetTextField(
      hintText: 'Mục tiêu',
      controller: titleController,
      validator: (value) {
        if (ValidatorUtils.validateEmpty(value)) {
          return "Nhập vào mục tiêu";
        }
        return null;
      },
    );
  }
}
