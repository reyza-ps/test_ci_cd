import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tokens"
export default class extends Controller {
  static targets = ["button", "message", "token"];
  static values = {
    message: String, token: String
  }

  connect() {
  }

  generateToken(e) {
    console.log(e.target)
    let data = e.target.dataset
    console.log(data)

    let params = { 
      client_id: data.clientId, redirect_uri: data.redirectUri, 
      response_type: data.responseType, client_secret: data.clientSecret,
      code: data.code, grant_type: data.grantType
    }
    const csrfToken = document.querySelector("[name='csrf-token']").content
    fetch('/partner/tokens/ocpi_request', {
        method: 'POST',
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        },
        body: JSON.stringify(params)
    }).then(response => response.json())
      .then(data => {
        if(data.is_success){
          this.buttonTarget.classList.add("hidden");
          this.messageTarget.innerHTML = 'Your access token below: '
          this.tokenTarget.innerHTML = data.access_token
        }
      })
  }
}
