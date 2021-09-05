import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing/app/pages/topic_details/bloc/topic_details_bloc.dart';

class TopicDetailsUI extends StatefulWidget {
  @override
  _TopicDetailsUIState createState() => _TopicDetailsUIState();
}

class _TopicDetailsUIState extends State<TopicDetailsUI> {
  late TopicDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = TopicDetailsBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Topic Details',
        ),
      ),
      body: BlocProvider<TopicDetailsBloc>(
        create: (BuildContext context) => _bloc,
        child: BlocConsumer<TopicDetailsBloc, TopicDetailsState>(
          listener: (BuildContext context, TopicDetailsState state) {
            // if (state is GoalDetailsErrorState) {
            //   BlocProvider.of<NotificationBloc>(context)
            //       .add(ErrorNotificationEvent(state.error));
            // } else if (state is GoalDetailsApiRequestSuccessState) {
            //   goalDetails = state.goalDetails;
            // } else if (state is GoalDetailsLoadingState) {
            //   goalDetails = null;
            // } else if (state is GoalDeletedState) {
            //   Navigator.of(context).pop();
            // }
          },
          builder: (BuildContext context, TopicDetailsState state) {
            // if (state is GoalDetailsLoadingState) {
            //   return Center(child: PALoader.square());
            // }
            return RefreshIndicator(
              onRefresh: () async {
                // _bloc.goalDetailsReload();
              },
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            // _topPortion(context),
                            // _goalDetails(),
                            // _editGoalPortion(),
                            // _deleteGoalPortion(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
