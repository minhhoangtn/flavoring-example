import 'package:flavoring/data/model/entity/task/task_entity.dart';
import 'package:flavoring/presentation/common/common_barrel.dart';
import 'package:flavoring/presentation/task_detail/bloc/task_detail_cubit.dart';
import 'package:flavoring/presentation/task_detail/view/widget/widget_barrel.dart';
import 'package:flavoring/core/utils/validator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavoring/core/extension/extension_barrel.dart';
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
                    title: 'Ho??n th??nh',
                    value: state.newState!.isDone,
                    onTap: () => cubit.changeIsDoneStatus(),
                  );
                },
              ),
              BlocBuilder<TaskDetailCubit, TaskDetailState>(
                buildWhen: (previous, current) =>
                    previous.newState != current.newState,
                builder: (context, state) {
                  return WidgetSwitch(
                    title: 'Nh???n th??ng b??o',
                    value: state.newState!.isReceiveNotification,
                    onTap: () => cubit.changeReceiveNotification(),
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
      hintText: 'Ghi ch??',
      maxLine: 3,
      controller: noteController,
    );
  }

  _buildDeadlineField() {
    return WidgetDatePicker(
      minimumDate: DateTime.now().add(const Duration(minutes: 1)),
      initialDate: DateTime.now().add(const Duration(minutes: 1)),
      hintText: 'H???n ch??t',
      controller: deadlineController,
      pickerMode: CupertinoDatePickerMode.dateAndTime,
      validator: (value) {
        if (ValidatorUtils.validateEmpty(value)) {
          return 'Ch???n h???n ch??t';
        } else if (ValidatorUtils.validateLateTime(value!)) {
          return 'Deadline ???? qu?? h???n';
        }
        return null;
      },
    );
  }

  _buildTitleField() {
    return WidgetTextField(
      hintText: 'M???c ti??u',
      controller: titleController,
      validator: (value) {
        if (ValidatorUtils.validateEmpty(value)) {
          return "Nh???p v??o m???c ti??u";
        }
        return null;
      },
    );
  }
}
