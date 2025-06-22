import { App } from "astal/gtk3";
import style from "./AppLauncher.scss";
import Applauncher from "./AppLauncher.tsx";

App.start({
  instanceName: "launcher",
  css: style,
  main: Applauncher,
});
