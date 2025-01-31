import { App } from "astal/gtk3";
import style from "./styles/index.scss";
import Bar from "./widgets/bar/Bar";
import Applauncher from "./widgets/applauncher/Applauncher";
import NotificationPopups from "./widgets/notifications/NotificationPopups";

App.start({
  css: style,
  main: () => {
    App.get_monitors().map(Bar);
    App.get_monitors().map(NotificationPopups);
    Applauncher();
  },
});
