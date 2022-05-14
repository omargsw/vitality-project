import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vitality/components/alert_dialog.dart';
import 'package:vitality/components/color.dart';
import 'package:vitality/components/fonts.dart';
import 'package:vitality/components/icon_button.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:vitality/components/web_config.dart';
import 'package:vitality/model/centers.dart';
import 'package:vitality/model/customers_accounts.dart';
import 'package:http/http.dart' as http;

class AdminUsers extends StatefulWidget {
  const AdminUsers({Key? key}) : super(key: key);

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool isLoading = false;

  List<GetCusromerAccounts> customers = [];
  Future fetchCusromerAccount() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.adminViewCustomers;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetCusromerAccounts> list =
            getCusromerAccountsFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchCusromerAccount] $e");
    } finally {
      isLoading = false;
    }
  }

  List<GetCenter> centers = [];
  Future fetchCenter() async {
    isLoading = true;
    try {
      String url = WebConfig.baseUrl + WebConfig.getCenter;
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<GetCenter> list = getCenterFromJson(response.body);
        return list;
      }
    } catch (e) {
      log("[fetchCenter] $e");
    } finally {
      isLoading = false;
    }
  }

  Future deleteCustomerUser(var id) async {
    try {
      String url =
          WebConfig.baseUrl + WebConfig.adminRemoveCustomer + "?id=$id";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[deleteCustomerUser] $e");
    }
  }

  Future deleteCenterUser(var id) async {
    try {
      String url = WebConfig.baseUrl + WebConfig.adminRemoveCenter + "?id=$id";
      final response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body);
      if (json['error']) {
        return;
      }
      log(response.body);
    } catch (e) {
      log("[deleteCustomerUser] $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCusromerAccount().then((list) {
      setState(() {
        customers = list;
      });
    });
    fetchCenter().then((list) {
      setState(() {
        centers = list;
      });
    });
  }

  _displayCustomerAccount() {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          )
        : ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              GetCusromerAccounts get = customers[index];
              return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          offset: const Offset(4, 4),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          ClipOval(
                            child: Image.network(
                              WebConfig.baseUrl +
                                  WebConfig.customerImage +
                                  get.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                get.name,
                                style: AppFonts.tajawal16GreenW600,
                              ),
                              Text(
                                get.email,
                                style: AppFonts.tajawal14GreenW600,
                              ),
                              Text(
                                get.phone,
                                style: AppFonts.tajawal14BlueW600,
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialogWidget(
                                          title:
                                              "Are you sure to make Omar Wathaifi as a center account?",
                                          onTapYes: () {});
                                    });
                              },
                              child: const IconButtonWidget(
                                  color: Colors.green,
                                  icons: Icons.playlist_add_sharp)),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialogWidget(
                                        title:
                                            "Are you sure to delete this account?",
                                        onTapYes: () {
                                          deleteCustomerUser(get.id);
                                          setState(() {
                                            fetchCusromerAccount().then((list) {
                                              setState(() {
                                                customers = list;
                                              });
                                            });
                                          });
                                          Get.back();
                                        });
                                  });
                            },
                            child: const IconButtonWidget(
                                color: Colors.red, icons: Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          );
  }

  _displayCenterAccount() {
    return ListView.builder(
      itemCount: centers.length,
      itemBuilder: (context, index) {
        GetCenter get = centers[index];
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: ClipOval(
                    child: Image.network(
                      WebConfig.baseUrl + WebConfig.centerImages + get.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        get.name,
                        style: AppFonts.tajawal16GreenW600,
                      ),
                      Text(
                        get.email,
                        style: AppFonts.tajawal14GreenW600,
                      ),
                      Text(
                        get.phone,
                        style: AppFonts.tajawal14BlueW600,
                      ),
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogWidget(
                                title: "Are you sure to delete this account?",
                                onTapYes: () {
                                  deleteCenterUser(get.id);
                                  setState(() {
                                    fetchCenter().then((list) {
                                      setState(() {
                                        centers = list;
                                      });
                                    });
                                  });
                                  Get.back();
                                });
                          });
                    },
                    child: const IconButtonWidget(
                        color: Colors.red, icons: Icons.delete),
                  ),
                )));
      },
    );
  }

  tabCreateShipments() {
    List<Tab> tabs = <Tab>[
      Tab(child: _displayCustomerAccount()),
      Tab(child: _displayCenterAccount()),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTabController(
          length: tabs.length,
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.primaryColor,
            controller: _tabController,
            labelStyle: AppFonts.tajawal16GreenW600,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor: AppColors.secondaryColor,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
            tabs: const [
              Tab(text: "Customers Account"),
              Tab(text: "Centers Account"),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 1.6,
          child: TabBarView(
              controller: _tabController,
              children: tabs.map((Tab tab) {
                return Container(child: tab.child);
              }).toList()),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [tabCreateShipments()],
                ),
              )),
        ],
      ),
    );
  }
}
