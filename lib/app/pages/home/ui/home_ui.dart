import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing/app/bloc/notification/notification_bloc.dart';
import 'package:morphing/app/pages/home/bloc/home_bloc.dart';
import 'package:morphing/app/pages/home/model/home_model.dart';
import 'package:morphing/app/routes/routes.dart';
import 'package:morphing/shared/util/loader.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  late HomeBloc _bloc;
  TopicList? _topicList;

  @override
  void initState() {
    _bloc = HomeBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, HomeState state) {},
        builder: (BuildContext context, HomeState state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child: BlocProvider<HomeBloc>(
                create: (BuildContext context) => _bloc,
                child: BlocConsumer<HomeBloc, HomeState>(
                  listener: (BuildContext context, HomeState state) {
                    if (state is TopicListApiReqiestSuccessState) {
                      _topicList = state.topicList;
                      BlocProvider.of<NotificationBloc>(context)
                          .add(SuccessNotificationEvent('Page Reloaded !!!'));
                    }
                  },
                  builder: (BuildContext context, HomeState state) {
                    if (state is HomePageLoadingState) {
                      return Center(child: Loader.circular());
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        _bloc.homeReload();
                      },
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverToBoxAdapter(
                            child: Container(
                              height: 150,
                              child: Center(
                                child: Text('Home Page'),
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return _listTile(index);
                              },
                              childCount: _topicList?.topics?.length ?? 0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _listTile(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.topic_details,
          // arguments: <String, dynamic>{
          //   'package_id': 1,
          //   'home_bloc': widget.homeBloc,
          //   'training_plan': widget.trainingPlan,
          // },
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.greenAccent,
        ),
        margin: const EdgeInsets.only(
          left: 12,
          right: 16,
          top: 16,
        ),
        height: 100,
        width: MediaQuery.of(context).size.width - 32,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Text(
                _topicList?.topics?[index].name ?? '',
                // style: SGTextStyles.display24whitew700italic,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              child: Text(
                (_topicList?.topics?[index].start?.toString() ?? '') +
                    ' - ' +
                    (_topicList?.topics?[index].end?.toString() ?? ''),
                // style: SGTextStyles.pro12white,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
