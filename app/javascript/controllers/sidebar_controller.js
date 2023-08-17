import { Controller } from "@hotwired/stimulus"
import { leave, enter } from "el-transition"

export default class extends Controller {
  static targets = ["sidebar", "sidebarTransition", "sidebarClose", "buttonOpenSidebar", "buttonCloseSidebar"]

  open(){
    enter(this.sidebarTarget)
    enter(this.sidebarTransitionTarget)
    enter(this.sidebarCloseTarget)
  }

  close(){
    leave(this.sidebarTarget)
    leave(this.sidebarTransitionTarget)
    leave(this.sidebarCloseTarget)
  }

  // We only want to hide the menu when we click anything except the button.
  // This lets us click anywhere outside of the dropdown menu to hide it.
  hide(event) {
    const buttonClicked = this.buttonOpenSidebarTarget.contains(event.target)

    if (!buttonClicked) {
      leave(this.sidebarTarget)
      leave(this.sidebarTransitionTarget)
      leave(this.sidebarCloseTarget)
    }
  }
}
