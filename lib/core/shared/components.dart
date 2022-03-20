import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_practicing/core/shared/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

// import '../../layouts/home/Widgets/cubit/shop_cubit.dart';

Widget articleBuilder(list) => ConditionalBuilder(
      condition: list.length > 0,
      fallback: (context) => const Center(child: CircularProgressIndicator()),
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
                color: Colors.grey, endIndent: .5, thickness: 1, height: 5)),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
      ),
    );

Widget articleBuilder2(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget buildTappedArticleItem(article, context) => InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(article['urlToImage'] ??
                        "https://st4.depositphotos.com/14953852/22772/v/600/depositphotos_227725020-stock-illustration-image-available-icon-flat-vector.jpg")),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  Function(String)? onSubmit,
  String? hint,
  Function(String)? onChanged,
  GestureTapCallback? onTap,
  String? Function(String?)? validate,
  required String? label,
  required IconData? prefix,
  bool isClickable = true,
  IconData? suffix,
  void Function()? suffixPressed,
  bool obscureText = false,
  int? maxLength,
}) =>
    TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp('[0-9]'))
      ],
      autocorrect: true,
      enableSuggestions: true,
      maxLength: maxLength,
      obscureText: obscureText,
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        counter: const Offstage(),
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        hintStyle: TextStyle(color: Colors.grey[400]),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(suffix),
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  required String? text,
  required void Function()? function,
}) =>
    TextButton(
        onPressed: function,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: background),
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(color: Colors.white)),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[400],
      ),
    );

//--------------Navigator To Page -----------------------
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

//---------SHOW TOAST AND CHANGE IT'S COLOR-------------
void showToast({required String? message, required ToastStates state}) {
  Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, error, warning }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
  }
  return color;
}

void printFullText(String text) {
  // 800 is the size of each chunk
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });
}

Widget progress(context) {
  return Center(
    child: SizedBox(
      height: 80,
      width: 80,
      child: LiquidCircularProgressIndicator(
        value: .80,
        // Defaults to 0.5.
        valueColor: const AlwaysStoppedAnimation(Colors.blue),
        // Defaults to the current Theme's accentColor.
        backgroundColor: Colors.white,
        // Defaults to the current Theme's backgroundColor.
        borderColor: Colors.red,
        borderWidth: 1.0,
        direction: Axis.vertical,
        // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
        center: const Text("Loading..."),
      ),
    ),
  );
}

//--------------Capitalized Extension--------------------
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Widget buildListProduct(context, {bool isOldPrice = true, required model}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.product!.image!),
                  height: 120,
                  width: 120,
                ),
                if (model.product!.discount != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: Text(
                      'discount'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          //product Image
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //product Name
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13, height: 1.5, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Row(
                  children: [
                    //product Price
                    Text(
                      model.product!.price!.toString(),
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    //product old Price
                    if (model.product!.discount != 0 && isOldPrice)
                      Text(
                        isOldPrice ? model.product!.oldPrice!.toString() : '',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.double,
                        ),
                      ),
                    // Icons.favorite_border
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // ShopCubit.get(context).changeFavorites(
                        //   model.product!.id,
                        // );
                      },
                      icon: const Icon(
                        // ShopCubit.get(context).favorites[model.product!.id]
                        //     ? Icons.favorite_outlined:
                        Icons.favorite_border,
                        size: 25,
                        // color: ShopCubit.get(context)
                        //     .favorites[model.product!.id]//     ?
                        color: Colors.red,
                        //     : Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

PreferredSizeWidget? defaultAppbar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          IconBroken.Arrow___Left_2,
        ),
      ),
      actions: actions,
      titleSpacing: 5.0,
      title: Text(title!),
    );
