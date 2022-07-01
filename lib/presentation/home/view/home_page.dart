import 'package:flavoring/configuration/style/style_barrel.dart';
import 'package:flavoring/presentation/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final String? route;
  const HomePage({Key? key, this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.whiteFD,
        title: Row(
          children: [
            Text(
              route ?? 'Taskker',
              style: AppTextStyle.orange(30, weight: FontWeight.bold),
            )
          ],
        ),
      ),
      // context.read<AuthBloc>().add(const LoggedOut());
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: AppColor.greyCF,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, index) => WidgetTaskItem(),
              itemCount: 10,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(color: AppColor.whiteFD, boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)
            ]),
            child: Row(
              children: [
                Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      color: AppColor.orangeE6, shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    color: AppColor.whiteFD,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Thêm công việc mới',
                  style: AppTextStyle.orange(16, weight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WidgetTaskItem extends StatefulWidget {
  const WidgetTaskItem({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetTaskItem> createState() => _WidgetTaskItemState();
}

class _WidgetTaskItemState extends State<WidgetTaskItem> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.2,
          child: Radio(
              value: true,
              groupValue: isSelected,
              toggleable: true,
              onChanged: (value) {
                setState(() {
                  isSelected = !isSelected;
                });
              }),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                'halo',
                style: AppTextStyle.black(18),
              ),
              const SizedBox(height: 5),
              Text(
                'Nhắc nhở',
                style: AppTextStyle.grey(16),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 1,
                width: double.infinity,
                color: AppColor.greyCF,
              ),
            ],
          ),
        )
      ],
    );
  }
}
