import { App } from "astal/gtk3";
import style from "./AppLauncher.scss";
import Applauncher from "./AppLauncher";

App.start({
  instanceName: "launcher",
  css: style,
  main: Applauncher,
});
