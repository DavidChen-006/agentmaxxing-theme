import { apiInitializer } from "discourse/lib/api";

export default apiInitializer((api) => {
  // Frontend behavior goes here. This runs once on app boot.
  //
  // Common starting points:
  //
  // Add an item to the user menu, hamburger, or admin menu:
  //   api.addNavigationBarItem({ name: "agents", displayName: "Agents", href: "/tag/agent" });
  //
  // Render your own component into a named slot in core's UI:
  //   api.renderInOutlet("topic-above-posts", MyComponent);
  //
  // React to app events:
  //   api.onAppEvent("topic:created", (topic) => console.log(topic));
  //
  // Outlets are the supported extension seam — they survive Discourse
  // upgrades, unlike overriding core components. Find them by searching
  // the Discourse source for `<PluginOutlet @name=`.
});
