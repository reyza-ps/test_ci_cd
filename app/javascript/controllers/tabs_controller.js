import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "content"];

  connect() {
    this.showTab(0);
  }

  changeTab(event) {
    event.preventDefault();
    this.showTab(this.tabTargets.indexOf(event.target));
    console.log("Clicked tab index:", this.tabTargets.indexOf(event.target));
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      tab.classList.toggle("tab-active", i === index);
      tab.classList.remove("tab-inactive", i === index);
      tab.classList.toggle("tab-inactive", i !== index);
      if (i === index) {
        this.contentTargets[i].classList.remove("hidden");
      } else {
        this.contentTargets[i].classList.add("hidden");
      }
    });
  }
}
