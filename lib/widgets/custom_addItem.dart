// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moona/controller/addItem_controller.dart';
import 'package:moona/controller/lang_controller.dart';
import 'package:moona/controller/theme_controller.dart';
import 'package:moona/core/colors_manager.dart';
import 'package:moona/generated/l10n.dart';
import 'package:provider/provider.dart';

class CustomAdditem extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomAdditem({super.key});

  @override
  State<CustomAdditem> createState() => _CustomAdditemState();
}

class _CustomAdditemState extends State<CustomAdditem> {
  final TextEditingController stockController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String? selectedType;

  String? selectedSubType;

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final langController = Provider.of<LangController>(context);
    final currentLang = langController.locale;
    final size = MediaQuery.of(context).size;
    final height = size.height; // screen height
    // ignore: unused_local_variable
    final width = size.width; // screen width

    final Map<String, List<String>> categories = {
      S.of(context).buildingMaterials: [
        S.of(context).bricks,
        S.of(context).cement,
        S.of(context).sand,
        S.of(context).steel,
      ],

      S.of(context).electricalAndLightning: [
        S.of(context).wires,
        S.of(context).switches,
        S.of(context).bulbs,
        S.of(context).panels,
      ],
      S.of(context).finishingMaterilas: [
        S.of(context).paints,
        S.of(context).tiles,
        S.of(context).wallpaper,
      ],
      S.of(context).plumbing: [
        S.of(context).pipes,
        S.of(context).taps,
        S.of(context).valves,
      ],
      S.of(context).constructionTools: [
        S.of(context).hummer,
        S.of(context).drill,
        S.of(context).saw,
      ],
    };

    return Consumer<AdditemProvider>(
      builder: (context, provider, child) => Container(
        height: height * 0.80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeController.isLight
              ? ColorsManager.white
              : ColorsManager.green, // Dark green background
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: themeController.isLight
                ? ColorsManager.white
                : ColorsManager.green,
            width: 2.w,
          ),
        ),
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).productType,
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.gold,
                        ),
                      ),
                    ),
                    dropdownColor: themeController.isLight
                        ? ColorsManager.white
                        : const Color(0xFF164734),
                    iconEnabledColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                    value: selectedType,
                    hint: Text(
                      S.of(context).selectType,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                    ),
                    items: categories.keys
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: GoogleFonts.inter(
                                color: themeController.isLight
                                    ? ColorsManager.green
                                    : ColorsManager.white,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                        selectedSubType = null;
                      });
                    },
                  ),

                  SizedBox(height: 16.h),

                  if (selectedType != null)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                          ),
                        ),
                      ),
                      dropdownColor: themeController.isLight
                          ? ColorsManager.white
                          : const Color(0xFF164734),
                      iconEnabledColor: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      value: categories[selectedType]!.contains(selectedSubType)
                          ? selectedSubType
                          : categories[selectedType]!.first,

                      hint: Text(
                        S.of(context).selectItem,
                        style: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                      ),
                      items: categories[selectedType]!
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.inter(
                                  color: themeController.isLight
                                      ? ColorsManager.green
                                      : ColorsManager.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSubType = value;
                        });
                      },
                    ),
                ],
              ),

              SizedBox(height: 15.h),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: stockController,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                      decoration: InputDecoration(
                        hintText: S.of(context).stock,
                        hintStyle: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                        // suffixText: "LT",
                        // suffixStyle: TextStyle(
                        //   color: themeController.isLight
                        //       ? ColorsManager.green
                        //       : ColorsManager.white,
                        // ),
                        filled: true,
                        fillColor: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10.h),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      style: GoogleFonts.inter(
                        color: themeController.isLight
                            ? ColorsManager.green
                            : ColorsManager.white,
                      ),
                      decoration: InputDecoration(
                        hintText: S.of(context).pricePerTon,
                        hintStyle: GoogleFonts.inter(
                          color: themeController.isLight
                              ? ColorsManager.green
                              : ColorsManager.white,
                        ),
                        filled: true,
                        fillColor: themeController.isLight
                            ? ColorsManager.white
                            : ColorsManager.green,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.white,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeController.isLight
                                ? ColorsManager.green
                                : ColorsManager.gold,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),

              TextField(
                controller: companyController,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).companyOfProduct,
                  hintStyle: GoogleFonts.inter(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                  ),
                  filled: true,
                  fillColor: themeController.isLight
                      ? ColorsManager.white
                      : ColorsManager.green,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              TextField(
                controller: descriptionController,
                style: GoogleFonts.inter(
                  color: themeController.isLight
                      ? ColorsManager.green
                      : ColorsManager.white,
                ),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: S.of(context).description,
                  hintStyle: GoogleFonts.inter(
                    color: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.white,
                  ),
                  filled: true,
                  fillColor: themeController.isLight
                      ? ColorsManager.white
                      : ColorsManager.green,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.gold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).delivery,
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  Switch(
                    value: provider.isDelivery,
                    activeColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    onChanged: (val) {
                      provider.toggleDelivery(val);
                    },
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).sellOnCredit,
                    style: GoogleFonts.inter(
                      color: themeController.isLight
                          ? ColorsManager.green
                          : ColorsManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  Switch(
                    value: provider.isCredit,
                    activeColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    onChanged: (val) {
                      provider.toggleCredit(val);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeController.isLight
                        ? ColorsManager.green
                        : ColorsManager.gold,
                    padding: EdgeInsets.symmetric(vertical: 15.r),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () async {
                    if (selectedType == null ||
                        selectedSubType == null ||
                        stockController.text.isEmpty ||
                        priceController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.of(context).fillAllFields)),
                      );
                      return;
                    }

                    final stock = double.tryParse(stockController.text) ?? 0;
                    final price = double.tryParse(priceController.text) ?? 0;
                    final company = companyController.text.trim();
                    final description = descriptionController.text.trim();

                    final newProduct = await provider.addProduct(
                      price: price,
                      description: description,
                      type: selectedType!,
                      company: company,
                      stock: stock,
                      isDelivery: provider.isDelivery,
                      isCredit: provider.isCredit,
                      name: selectedSubType!,
                    );
                    if (newProduct != null) {
                      provider.products.add(newProduct);
                      setState(() {});
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).add,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeController.isLight
                          ? ColorsManager.white
                          : ColorsManager.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
