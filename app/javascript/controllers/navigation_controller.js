import { Controller } from "@hotwired/stimulus"
import { leave, enter } from "el-transition"

export default class extends Controller {
  static targets = ["element"]
  static values = {
    url: String, current_page: Boolean
  }

  connect(){
    this.filterClass();
  }

  filterClass(){
    this.elementTargets.forEach((el, i) => {
      console.log("element", el);
    });
  }
}
