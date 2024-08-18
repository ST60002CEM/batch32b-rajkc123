class HomeViewState {
  final bool showLogoutDialog;

  HomeViewState({this.showLogoutDialog = false});

  HomeViewState copyWith({bool? showLogoutDialog}) {
    return HomeViewState(
      showLogoutDialog: showLogoutDialog ?? this.showLogoutDialog,
    );
  }
}
