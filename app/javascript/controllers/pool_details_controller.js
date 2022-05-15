import { Controller } from "@hotwired/stimulus"
import axios from 'axios';

export default class extends Controller {
  static targets = [ "active" ]
  static values = { poolId: Number, portfolioId: Number }

  // connect() {
  //   console.log('pool id ' + this.poolIdValue)
  //   console.log('portfolio id ' + this.portfolioIdValue)
  //   console.log('domain name ' + window.location.host)
  // }

  setInactive(event) {    
    axios.get(`/portfolio/${this.portfolioIdValue}/pool/${this.poolIdValue}/active`)
      .then(res => {
        const result = res.data;
        console.log(result)
        document.location.reload(true)
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
  }
}
