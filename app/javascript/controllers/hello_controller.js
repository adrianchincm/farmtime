import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showHideDetails(event) {
    const element = event.currentTarget.querySelector("#details")
    element.hidden = !element.hidden
  }
}
