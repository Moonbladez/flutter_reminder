import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/category.dart';
import 'package:reminders/models/reminder/reminder.dart';
import 'package:reminders/screens/view_list/view_list_by_category_screen.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);

    return GridView.count(
      childAspectRatio: 16 / 9,
      crossAxisSpacing: 8,
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: categories
          .map(
            (category) => InkWell(
              onTap: getCategoryCount(
                          id: category.id, allReminders: allReminders) >
                      0
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewListByCategoryScreen(
                            category: category,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF1A1910),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          category.icon,
                          Text(
                            getCategoryCount(
                                    id: category.id, allReminders: allReminders)
                                .toString(),
                          ),
                        ],
                      ),
                      Text(category.name,
                          style: Theme.of(context).textTheme.headline6),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  int getCategoryCount({required String id, List<Reminder>? allReminders}) {
    if (id == "all" && allReminders != null) {
      return allReminders.length;
    }

    final categories =
        allReminders?.where((reminder) => reminder.categoryId == id);

    if (categories != null) {
      return categories.length;
    }

    return 0;
  }
}
