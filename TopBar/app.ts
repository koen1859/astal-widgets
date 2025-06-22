import { App } from "astal/gtk3";
import style from "./TopBar.scss";
import Bar from "./Bar";

App.start({
  css: style,
  instanceName: "js",
  requestHandler(request, res) {
    print(request);
    res("ok");
  },
  main: () => App.get_monitors().map(Bar),
});
