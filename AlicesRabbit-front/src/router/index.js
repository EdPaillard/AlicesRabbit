import { createRouter, createWebHashHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import UserView from "../views/UserView.vue";
import WorkingTimesView from "@/views/WorkingTimesView";

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/user",
    name: "user",
    component: UserView,
  },
  {
    path: "/workingtimes",
    name: "workingtimes",
    component: WorkingTimesView,
  }
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

export default router;
